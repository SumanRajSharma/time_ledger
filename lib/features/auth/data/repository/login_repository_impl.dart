import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/resources/data_state.dart';

import 'package:time_ledger/features/auth/data/models/login_response.dart';

import 'package:time_ledger/features/auth/domain/repository/login_repository.dart';
import 'package:time_ledger/features/auth/data/data_sources/login_query.dart';
import 'package:time_ledger/service/token_service.dart';

class LoginRepositoryImpl implements LoginRepository {
  final GraphQLClient graphQLClient;
  final SecureTokenService tokenService;

  // Constructor injection for both GraphQLClient and SecureTokenService
  LoginRepositoryImpl({
    required this.graphQLClient,
    required this.tokenService,
  });

  @override
  Future<DataState<LoginModel>> checkLoginStatus(
      {required String email, required String password}) async {
    try {
      final result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(LoginQueries
              .loginMutation), // Using the static mutation from AuthQueries
          variables: {
            'email': email,
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
      final loginData = result.data?['login'];

      if (loginData == null || loginData is! Map<String, dynamic>) {
        return DataFailed(Exception('Invalid login data'));
      }
      LoginModel loginModel = LoginModel.fromJson(loginData);

      // Saving token
      if (loginModel.token.isNotEmpty) {
        await tokenService.saveToken(loginModel.token);
      }

      return DataSuccess(loginModel);
    } catch (e) {
      // General exception handling
      return DataFailed(Exception('Failed to login: ${e.toString()}'));
    }
  }
}
