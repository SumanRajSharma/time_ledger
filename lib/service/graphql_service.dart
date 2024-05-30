import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GraphQLService {
  static String getApiUrl() {
    final apiUrl = dotenv.env['API_URL'];

    if (apiUrl == null) {
      throw Exception('API_URL not configured in .env file');
    }
    return apiUrl;
  }

  static HttpLink httpLink = HttpLink(
    getApiUrl(),
  );

  static final Link link = httpLink;

  static GraphQLClient initializeClient() {
    return GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    );
  }
}
