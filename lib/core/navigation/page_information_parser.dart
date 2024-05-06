// lib/core/navigation/page_information_parser.dart

import 'package:flutter/material.dart';
import 'package:time_ledger/core/navigation/page_config.dart';

/// Parses a URL string into a [PageConfiguration] object.
class PageInformationParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    // Parse the URI from the route location
    final uri = Uri.parse(routeInformation.uri as String);

    // Check the path and return the appropriate page configuration
    if (uri.path == '/home') {
      return const PageConfiguration(PageType.home);
    } else {
      return const PageConfiguration(PageType.login);
    }
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    // Convert the [PageConfiguration] back to a URL string
    switch (configuration.type) {
      case PageType.home:
        return RouteInformation(uri: Uri.parse('/home'));
      case PageType.login:
        return RouteInformation(uri: Uri.parse('/login'));
    }
  }
}
