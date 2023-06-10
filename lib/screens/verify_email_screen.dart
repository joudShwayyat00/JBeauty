import 'package:jbeauty/route/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VerfiyEmailScreen extends StatelessWidget {
  const VerfiyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmailVerificationScreen(
        
        actions: [
          EmailVerifiedAction(() {
            context.router.replace(const VerifySuccessRoute());
          }),
          AuthCancelledAction((context) {
            FirebaseUIAuth.signOut(context: context);
            context.router.replace(const SignupRoute());
          }),
        ],
      ),
    );
  }
}
