import 'package:flutter/material.dart';
import 'package:juno_provider_base_project/core/core.dart';
import 'package:juno_provider_base_project/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:juno_provider_base_project/features/project_details/project_details.dart';

class NavRouter {
  NavRouter._();

  static MaterialPageRoute _pageRoute(Widget page, settings,
      {bool fullscreenDialog = false}) {
    return MaterialPageRoute(
        builder: (_) => page,
        settings: settings,
        fullscreenDialog: fullscreenDialog);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return _pageRoute(DashboardView(), settings);
      case Routes.projectDetails:
        return _pageRoute(
            ProjectDetailsView(
                argument: settings.arguments as ProjectDetailsArgument),
            settings);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
