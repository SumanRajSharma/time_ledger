import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/auth/data/data_sources/logout_query.dart';
import 'package:time_ledger/features/auth/data/models/logout_response.dart';
import 'package:time_ledger/features/auth/domain/repository/logout_repository.dart';
import 'package:time_ledger/service/token_service.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final SecureTokenService tokenService;
  final GraphQLClient graphQLClient;

  // Constructor injection for both GraphQLClient and SecureTokenService
  LogoutRepositoryImpl({
    required this.graphQLClient,
    required this.tokenService,
  });

  @override
  Future<DataState<LogoutModel>> logoutUser() async {
    String? token = await tokenService.getToken();
    if (token == null) {
      return DataFailed(Exception('No token found'));
    }

    try {
      final result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(LogoutMutations.logout),
          variables: {'token': token},
        ),
      );

      if (result.hasException) {
        return DataFailed(Exception(result.exception.toString()));
      }
      final logoutData = result.data?['logout'];
      if (logoutData == null) {
        return DataFailed(Exception('Unexpected null logout data'));
      }
      LogoutModel logoutModel = LogoutModel.fromJson({'logout': logoutData});
      // LogoutModel logoutModel = LogoutModel(logout: logoutData);
      await tokenService.deleteToken();
      return DataSuccess(logoutModel);
    } catch (e) {
      return DataFailed(Exception('Failed to logout: ${e.toString()}'));
    }
  }
}
