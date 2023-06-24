import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vms/helper/HelperFunction.dart';
import 'package:vms/helper/HelperSharedPreference.dart';
import 'package:vms/helper/HelperString.dart';
import 'package:vms/screens/ScreenAddDetails.dart';
import 'package:vms/screens/ScreenDetails.dart';
import 'package:vms/widget/WidgetButton.dart';
import 'package:vms/widget/WidgetText.dart';
import 'package:vms/widget/WidgetTextField.dart';

/// ScreenLogin this file we are using for login the user
class ScreenLogin extends StatefulWidget {
  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  WidgetButtonController controllerLogin = WidgetButtonController();
  final key = GlobalKey<FormState>();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40.h, bottom: 10.h),
              child: Image.asset(
                "assets/vms_icon.png",
                height: 150.h,
              ),
            ),
            widgetText(
                text: "Vehicle Management System",
                textStyle: textStyle(fontSize: 24.sp)),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                    child: Column(
                      children: [
                        WidgetTextField(
                          controller: controllerUserName,
                          hintText: "Username",
                          enumValidator: EnumValidator.text,
                          modelTextField: ModelTextField(isCompulsory: true),
                        ),
                        WidgetTextField(
                          controller: controllerPassword,
                          hintText: "Password",
                          obscureText: isObsecure,
                          enumValidator: EnumValidator.text,
                          modelTextField: ModelTextField(isCompulsory: true),
                          suffixIcon: IconButton(
                            icon:
                                Icon(isObsecure ? Icons.lock : Icons.lock_open),
                            onPressed: () {
                              setState(() {
                                isObsecure = !isObsecure;
                              });
                            },
                          ),
                        ),
                        WidgetButton(
                          controller: controllerLogin,
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              controllerLogin.loading!();
                              functionLogin(controllerUserName.text.toString(),
                                  controllerPassword.text.toString());
                            }
                          },
                          title: "Login".toUpperCase(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// in this function we are just validating from which user id user is currently login
  functionLogin(String userName, String password) {
    if (userName.trim().toLowerCase() == password.trim().toLowerCase()) {
      if (userName.trim().toLowerCase() == HelperString.instance.customer) {
        callSessionMethod(userName);
      } else if (userName.trim().toLowerCase() == HelperString.instance.admin) {
        callSessionMethod(userName);
      } else if (userName.trim().toLowerCase() ==
          HelperString.instance.mechanic) {
        callSessionMethod(userName);
      } else {
        /// if user id is not match then we are show error message
        controllerLogin.reset!();
        HelperFunction.showFlushbarError(
            context, "Please enter valid credentials");
      }
    } else {
      /// if user id is not match then we are show error message
      controllerLogin.error!();
      controllerLogin.reset!();
      HelperFunction.showFlushbarError(
          context, "Please enter valid credentials");
    }
  }

  /// to know the user we are show flushbar from which login he is logged in
  callSessionMethod(String value) {
    Future.delayed(const Duration(seconds: 1), () {
      HelperFunction.showFlushbarSuccess(
          context, "You are login with ${value.toUpperCase()}");
    });

    Future.delayed(const Duration(seconds: 2), () {
      session(value.trim().toLowerCase());
    });
  }

  session(String id) {
    HelperSharedPreference.setString(HelperString.instance.userRoleId, id)
        .whenComplete(() {
      controllerLogin.reset!();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(

              /// here if logged in user is customer then we are showing add details screen else we
              /// are showing details screen
              builder: (context) => id == HelperString.instance.customer
                  ? ScreenAddDetails()
                  : ScreenDetails()),
          (Route<dynamic> route) => false);
    });
  }
}
