import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/user/data/data_sources/create_user_query.dart';
import 'package:time_ledger/features/user/data/models/create_user_response.dart';
import 'package:time_ledger/features/user/domain/repository/create_user_repository.dart';

class CreateUserRepositoryImpl implements CreateUserRepository {
  final GraphQLClient graphQLClient;
  CreateUserRepositoryImpl({
    required this.graphQLClient,
  });

  @override
  Future<DataState<CreateUserModel>> createUser(
      {required String fullName,
      required String email,
      required String password,
      required String phoneNumber}) async {
    try {
      final result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(createUserQuery),
          variables: {
            'email': email,
            'fullName': fullName,
            'phoneNumber': phoneNumber,
            'password': password,
          },
        ),
      );
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
      final createUserData = result.data?['createUser'];
      if (createUserData == null || createUserData is! Map<String, dynamic>) {
        return DataFailed(Exception('Invalid create user data'));
      }
      CreateUserModel createUserModel =
          CreateUserModel.fromJson(createUserData);
      return DataSuccess(createUserModel);
    } catch (e) {
      return DataFailed(Exception('Failed to registe user: ${e.toString()}'));
    }
  }
}
