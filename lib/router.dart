import 'package:flutter_application_1/routes.dart';
import 'package:flutter_application_1/ui/holidays/holidays.dart';
import 'package:flutter_application_1/ui/holidays/holidays_view_model.dart';
import 'package:flutter_application_1/ui/home/home.dart';
import 'package:flutter_application_1/ui/home/home_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = HomeViewModel(repository: context.read());
        return Home(viewModel: viewModel);
      },
      routes: [
        GoRoute(
          path: Routes.holidaysRelative,
          builder: (context, state) {
            final viewModel = HolidaysViewModel(repository: context.read());
            return Holidays(viewModel: viewModel);
          },
          routes: [
            GoRoute(
              path: ':countryCode',
              builder: (context, state) {
                final countryCode = state.pathParameters['countryCode']!;
                final viewModel = HolidaysViewModel(repository: context.read());

                viewModel.getHolidays.execute(countryCode);

                return Holidays(viewModel: viewModel);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
