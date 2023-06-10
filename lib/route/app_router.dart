import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(
      page: OnboardingRoute.page,
    ),
    AutoRoute(
      page: VerifySuccessRoute.page,
    ),
    AutoRoute(
      page: NameAddressRoute.page,
    ),
    AutoRoute(
      page: HomeRoute.page,
    ),
    AutoRoute(page: SignupRoute.page),
    AutoRoute(page: VerfiyEmailRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: ProductDescritionRoute.page),
    AutoRoute(page: MyOrdersRoute.page),
    AutoRoute(page: HelpRoute.page),
    AutoRoute(page: LoginRoute.page),
  ];
}
