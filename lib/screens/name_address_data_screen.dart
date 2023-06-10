// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

import 'package:jbeauty/data/shared_perf_manager.dart';
import 'package:jbeauty/route/app_router.gr.dart';

import '../main.dart';

PhoneController phoneController = PhoneController(null);
TextEditingController nameController = TextEditingController();
TextEditingController addressController = TextEditingController();

@RoutePage()
class NameAddressScreen extends StatelessWidget {
  const NameAddressScreen({
    Key? key,
    this.data,
  }) : super(key: key);
  final Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    fillData();
    const outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(16)));

    return Scaffold(
        appBar: AppBar(
          title: Text(tr.enter_your_data),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr.enter_your_name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: tr.enter_your_name,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  tr.enter_your_address,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  maxLines: 4,
                  minLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                PhoneFormField(
                    controller: phoneController,
                    onChanged: (value) {
                      phoneController.value = value;
                    },
                    showFlagInInput: false,
                    validator: (phoneNumber) {
                      if (phoneNumber == null || !phoneNumber.isValid()) {
                        return tr.please_Enter_Your_Phone_Number;
                      }
                      return null;
                    },
                    defaultCountry: IsoCode.JO,
                    decoration: InputDecoration(
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      hintText: tr.enter_Your_Mobile_Number,
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                // const Spacer(),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      bool isPhoneValid =
                          phoneController.value?.isValid() ?? false;

                      /// check if the user data is valid
                      if (nameController.text.isEmpty ||
                          addressController.text.isEmpty ||
                          isPhoneValid == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(tr.please_fill_the_fields_correctly),
                          ),
                        );
                        return;
                      }

                      /// save the user data to firebase firestore
                      var uid = FirebaseAuth.instance.currentUser?.uid;
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(uid)
                          .set({
                        "name": nameController.text,
                        "address": addressController.text,
                        "phone": phoneController.value!.international,
                      });
                      if (data == null) {
                        SharedPerfManager.setIsLogedIn(true);
                        context.router.popUntilRoot();
                        context.router.push(const HomeRoute());
                      } else {
                        context.router.pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(data == null ? tr.verify : tr.update)),
              ],
            ),
          ),
        ));
  }

  void fillData() {
    if (data != null) {
      nameController.text = data!["name"];
      addressController.text = data!["address"];
      phoneController.value = PhoneNumber.parse(data!["phone"]);
    }
  }
}
