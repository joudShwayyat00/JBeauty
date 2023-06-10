// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:jbeauty/data/product.dart' as _i15;
import 'package:jbeauty/screens/help_screen.dart' as _i1;
import 'package:jbeauty/screens/home_screen.dart' as _i2;
import 'package:jbeauty/screens/login_screen.dart' as _i3;
import 'package:jbeauty/screens/my_orders_scrfeen.dart' as _i4;
import 'package:jbeauty/screens/name_address_data_screen.dart' as _i5;
import 'package:jbeauty/screens/onboarding_screen.dart' as _i6;
import 'package:jbeauty/screens/product_description_screen.dart' as _i7;
import 'package:jbeauty/screens/settings_scrren.dart' as _i8;
import 'package:jbeauty/screens/signup_screen.dart' as _i9;
import 'package:jbeauty/screens/splash_screen.dart' as _i10;
import 'package:jbeauty/screens/verify_email_screen.dart' as _i11;
import 'package:jbeauty/screens/verify_success_screen.dart' as _i12;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    HelpRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HelpScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
      );
    },
    MyOrdersRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.MyOrdersScreen(),
      );
    },
    NameAddressRoute.name: (routeData) {
      final args = routeData.argsAs<NameAddressRouteArgs>(
          orElse: () => const NameAddressRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.NameAddressScreen(
          key: args.key,
          data: args.data,
        ),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.OnboardingScreen(),
      );
    },
    ProductDescritionRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDescritionRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.ProductDescritionScreen(
          key: args.key,
          product: args.product,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SettingsScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SignupScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SplashScreen(),
      );
    },
    VerfiyEmailRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.VerfiyEmailScreen(),
      );
    },
    VerifySuccessRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.VerifySuccessScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.HelpScreen]
class HelpRoute extends _i13.PageRouteInfo<void> {
  const HelpRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i4.MyOrdersScreen]
class MyOrdersRoute extends _i13.PageRouteInfo<void> {
  const MyOrdersRoute({List<_i13.PageRouteInfo>? children})
      : super(
          MyOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyOrdersRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i5.NameAddressScreen]
class NameAddressRoute extends _i13.PageRouteInfo<NameAddressRouteArgs> {
  NameAddressRoute({
    _i14.Key? key,
    Map<String, dynamic>? data,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          NameAddressRoute.name,
          args: NameAddressRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'NameAddressRoute';

  static const _i13.PageInfo<NameAddressRouteArgs> page =
      _i13.PageInfo<NameAddressRouteArgs>(name);
}

class NameAddressRouteArgs {
  const NameAddressRouteArgs({
    this.key,
    this.data,
  });

  final _i14.Key? key;

  final Map<String, dynamic>? data;

  @override
  String toString() {
    return 'NameAddressRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i6.OnboardingScreen]
class OnboardingRoute extends _i13.PageRouteInfo<void> {
  const OnboardingRoute({List<_i13.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ProductDescritionScreen]
class ProductDescritionRoute
    extends _i13.PageRouteInfo<ProductDescritionRouteArgs> {
  ProductDescritionRoute({
    _i14.Key? key,
    required _i15.Product product,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ProductDescritionRoute.name,
          args: ProductDescritionRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDescritionRoute';

  static const _i13.PageInfo<ProductDescritionRouteArgs> page =
      _i13.PageInfo<ProductDescritionRouteArgs>(name);
}

class ProductDescritionRouteArgs {
  const ProductDescritionRouteArgs({
    this.key,
    required this.product,
  });

  final _i14.Key? key;

  final _i15.Product product;

  @override
  String toString() {
    return 'ProductDescritionRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i8.SettingsScreen]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SignupScreen]
class SignupRoute extends _i13.PageRouteInfo<void> {
  const SignupRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SplashScreen]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.VerfiyEmailScreen]
class VerfiyEmailRoute extends _i13.PageRouteInfo<void> {
  const VerfiyEmailRoute({List<_i13.PageRouteInfo>? children})
      : super(
          VerfiyEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerfiyEmailRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.VerifySuccessScreen]
class VerifySuccessRoute extends _i13.PageRouteInfo<void> {
  const VerifySuccessRoute({List<_i13.PageRouteInfo>? children})
      : super(
          VerifySuccessRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifySuccessRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}
