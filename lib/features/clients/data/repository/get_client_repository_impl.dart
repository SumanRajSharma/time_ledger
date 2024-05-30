import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/clients/data/data_sources/get_clients_query.dart';
import 'package:time_ledger/features/clients/data/models/client_model_response.dart';
import 'package:time_ledger/features/clients/domain/repository/get_client_repository.dart';
import 'package:time_ledger/service/token_service.dart';

class GetClientRepositoryImpl implements GetClientRepository {
  final GraphQLClient graphQLClient;
  final SecureTokenService tokenService;

  GetClientRepositoryImpl({
    required this.graphQLClient,
    required this.tokenService,
  });

  @override
  Future<DataState<List<ClientModel>>> getClients() async {
    try {
      String? token = await tokenService.getToken();

      final authLink = AuthLink(
        getToken: () => 'Bearer $token',
      );

      final link = authLink.concat(graphQLClient.link);
      final authClient = GraphQLClient(
        link: link,
        cache: graphQLClient.cache,
      );

      final result = await authClient.query(QueryOptions(
        document: gql(getClientsQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ));

      if (result.hasException) {
        String errorMessage = 'Unknown error occurred';

        if (result.exception!.graphqlErrors.isNotEmpty) {
          errorMessage =
              result.exception!.graphqlErrors.map((e) => e.message).join(', ');
        } else if (result.exception!.linkException != null) {
          errorMessage = result.exception!.linkException.toString();
        }
        return DataFailed(Exception(errorMessage));
      }

      final clientsData = result.data?['getClients'];
      if (clientsData == null || clientsData is! List) {
        return DataFailed(Exception('Invalid client data'));
      }

      List<ClientModel> clients = clientsData
          .map((clientData) =>
              ClientModel.fromJson(clientData as Map<String, dynamic>))
          .toList();

      return DataSuccess(clients);
    } catch (e) {
      return DataFailed(
          Exception('Failed to get client data: ${e.toString()}'));
    }
  }
}
