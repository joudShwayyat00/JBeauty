import 'package:jbeauty/data/shared_perf_manager.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jbeauty/main.dart';
import 'package:jbeauty/route/app_router.gr.dart';

@RoutePage()
class VerifySuccessScreen extends StatefulWidget {
  const VerifySuccessScreen({super.key});

  @override
  State<VerifySuccessScreen> createState() => _VerifySuccessScreenState();
}

class _VerifySuccessScreenState extends State<VerifySuccessScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () async {
      var uid = FirebaseAuth.instance.currentUser!.uid;

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

      // /// pop until first route
      // context.router.popUntilRoot();
      // context.router.push(const OTPRoute());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline_rounded,
                size: 150, color: Colors.green),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                tr.verification_code_send,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
