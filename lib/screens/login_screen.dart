import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jbeauty/data/shared_perf_manager.dart';
import 'package:jbeauty/main.dart';
import 'package:jbeauty/route/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(
        actions: [
          AuthStateChangeAction<UserCreated>((context, state) {
            // context.router.push(const VerfiyEmailRoute());
            /// send email verification
            state.credential.user?.sendEmailVerification();
            // show snackbar to verify email
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr.please_verify_your_email),
                duration: const Duration(seconds: 3),
              ),
            );
            context.router.push(const LoginRoute());
          }),
          AuthStateChangeAction<SignedIn>((context, state) async {
            if (!(state.user!.emailVerified)) {
              // context.router.push(const VerfiyEmailRoute());
            state.user?.sendEmailVerification();

              // show snackbar to verify email
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(tr.please_verify_your_email),
                  duration: const Duration(seconds: 3),
                ),
              );
              context.router.push(const LoginRoute());
            } else {
              var uid = auth.FirebaseAuth.instance.currentUser!.uid;

              /// check if user exist in users collection
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .get()
                  .then((value) {
                if (value.exists) {
                  /// user exist
                  SharedPerfManager.setIsLogedIn(true);

                  context.router.popUntilRoot();
                  context.router.push(const HomeRoute());
                } else {
                  /// user not exist
                  context.router.popUntilRoot();
                  context.router.push(NameAddressRoute());
                }
              });
            }
          }),
        ],
      ),
    );
  }
}
