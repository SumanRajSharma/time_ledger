import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:time_ledger/core/resources/data_state.dart';
import 'package:time_ledger/features/clients/data/data_sources/create_client_query.dart';
import 'package:time_ledger/features/clients/data/models/client_model_response.dart';
import 'package:time_ledger/features/clients/domain/entities/clients.dart';
import 'package:time_ledger/features/clients/domain/repository/create_client_repository.dart';

class CreateClientRepositoryImpl implements CreateClientRepository {
  final GraphQLClient graphQLClient;
  CreateClientRepositoryImpl({
    required this.graphQLClient,
  });

  @override
  Future<DataState<ClientModel>> createClient({
    required String name,
    required String address,
    required String participantName,
    required String participantNumber,
    required List<CareTypeEntity> careTypes,
    required RateEntity rate,
  }) async {
    try {
      final result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(createClientQuery),
          variables: {
            'name': name,
            'address': address,
            'participant_name': participantName,
            'participant_number': participantNumber,
            'care_type': careTypes
                .map((e) => {
                      'care_title': e.careTitle,
                      'description': e.description,
                    })
                .toList(),
            'rate': {
              'monday': rate.monday,
              'tuesday': rate.tuesday,
              'wednesday': rate.wednesday,
              'thursday': rate.thursday,
              'friday': rate.friday,
              'saturday': rate.saturday,
              'sunday': rate.sunday,
              'public_holiday': rate.publicHoliday,
            },
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

      final createClientData = result.data?['createClient'];
      if (createClientData == null ||
          createClientData is! Map<String, dynamic>) {
        return DataFailed(Exception('Invalid create client data'));
      }

      ClientModel createClientModel = ClientModel.fromJson(createClientData);
      return DataSuccess(createClientModel);
    } catch (e) {
      return DataFailed(Exception('Failed to create client: ${e.toString()}'));
    }
  }
}
