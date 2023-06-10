import 'package:auto_route/auto_route.dart';
import 'package:fancy_image_loader/fancy_image_loader.dart';
import 'package:flutter/material.dart';
import 'package:jbeauty/data/shared_perf_manager.dart';
import 'package:jbeauty/route/app_router.gr.dart';
import 'package:jbeauty/style/assets.dart';
import 'package:jbeauty/style/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (SharedPerfManager.showIntro) {
        context.router.replace(const OnboardingRoute());
      } else {
        if (SharedPerfManager.isLoggedIn) {
          context.router.replace(const HomeRoute());
        } else {
          context.router.replace(const SignupRoute());
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.primaryColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FancyImageLoader(
                path: Assets.icon,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.app_name,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
