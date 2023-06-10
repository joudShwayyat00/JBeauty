import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:jbeauty/data/shared_perf_manager.dart';
import 'package:jbeauty/route/app_router.gr.dart';
import 'package:jbeauty/style/assets.dart';
import 'package:jbeauty/style/style.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: OnBoardingSlider(
        pageBackgroundColor: Theme.of(context).colorScheme.background,
        // hasFloatingButton: false,
        indicatorAbove: true,
        centerBackground: true,
        onFinish: () {
          SharedPerfManager.setShowIntro(false);
          context.router.replace(const SignupRoute());
        },
        hasSkip: true,
        controllerColor: Style.primaryColor,
        headerBackgroundColor: Colors.white,
        finishButtonText: tr.get_Started,
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Style.primaryColor,
        ),
        skipTextButton:
            Text(tr.skip, style: const TextStyle(color: Colors.grey)),
        background: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Lottie.asset(Assets.ob1),
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: Lottie.asset(Assets.ob2),
          ),
        ],
        totalPage: 2,
        speed: 1.8,
        pageBodies: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
              ),
              Text(
                tr.e_Shopping,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                tr.explore_Top_Makeup_Brands_and_Products,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
              ),
              Text(
                tr.delivary_on_the_Way,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                tr.get_Yor_Order_by_Speed_Delivary,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
