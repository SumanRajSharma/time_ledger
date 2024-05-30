import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/user/data/data_sources/get_user_query.dart';
import 'package:time_ledger/features/user/data/models/user_model_response.dart';
import 'package:time_ledger/features/user/domain/repository/get_user_repository.dart';
import 'package:time_ledger/service/token_service.dart';

class GetUserRepositoryImpl implements GetUserRepository {
  final GraphQLClient graphQLClient;
  final SecureTokenService
      tokenService; // Function to fetch the authorization token

  GetUserRepositoryImpl({
    required this.graphQLClient,
    required this.tokenService,
  });

  @override
  Future<DataState<UserModel>> getUser() async {
    try {
      String? token = await tokenService.getToken();

      // Add the authorization token to the headers
      final authLink = AuthLink(
        getToken: () => 'Bearer $token',
      );

      // Chain the existing GraphQL client link with the new auth link
      final link = authLink.concat(graphQLClient.link);
      final authClient = GraphQLClient(
        link: link,
        cache: graphQLClient.cache,
      );

      // Execute the query with the authorization token
      final result = await authClient.query(QueryOptions(
        document: gql(getUserQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ));

      if (result.hasException) {
        String errorMessage = 'Unknown error occurred';

        // Check if there are specific GraphQL errors
        if (result.exception!.graphqlErrors.isNotEmpty) {
          errorMessage =
              result.exception!.graphqlErrors.map((e) => e.message).join(', ');
        }
        // Optionally, handle network errors differently
        else if (result.exception!.linkException != null) {
          errorMessage = result.exception!.linkException.toString();
        }
        return DataFailed(Exception(errorMessage));
      }

      // Extract and parse the user data from the response
      final userData = result.data?['me'];
      if (userData == null || userData is! Map<String, dynamic>) {
        return DataFailed(Exception('Invalid user data'));
      }
      UserModel userModel = UserModel.fromJson(userData);
      return DataSuccess(userModel);
    } catch (e) {
      // General exception handling
      return DataFailed(Exception('Failed to get user data: ${e.toString()}'));
    }
  }
}
