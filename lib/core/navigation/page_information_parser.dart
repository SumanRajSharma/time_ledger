// lib/core/navigation/page_information_parser.dart

import 'package:flutter/material.dart';
import 'package:time_ledger/core/navigation/page_config.dart';

/// Parses a URL [Uri] into a [PageConfiguration] object.
class PageInformationParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    // Access the uri property directly
    final uri = routeInformation.uri;
    // Check the path and return the appropriate page configuration
    if (uri.path == '/home') {
      return const PageConfiguration(PageType.home);
    } else {
      return const PageConfiguration(PageType.login);
    }
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    // Convert the [PageConfiguration] back to a [Uri]
    switch (configuration.type) {
      case PageType.home:
        return RouteInformation(uri: Uri.parse('/home'));
      case PageType.login:
        return RouteInformation(uri: Uri.parse('/login'));
    }
  }
}
