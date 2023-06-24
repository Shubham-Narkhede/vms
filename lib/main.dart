import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vms/cubit/CubitVehicle.dart';
import 'package:vms/repo/Repo.dart';
import 'package:vms/screens/ScreenAddDetails.dart';
import 'package:vms/screens/ScreenDetails.dart';
import 'package:vms/screens/ScreenLogin.dart';

import 'helper/HelperSharedPreference.dart';
import 'helper/HelperString.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HelperSharedPreference.init();
  await ScreenUtil.ensureScreenSize();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return BlocProvider<VehicleCubit>(
              create: (BuildContext context) => VehicleCubit(VehicleRepo()),
              child: MaterialApp(
                home: () {
                  if (HelperSharedPreference.getString(
                          HelperString.instance.userRoleId)
                      .isEmpty) {
                    return ScreenLogin();
                  } else if (HelperSharedPreference.getString(
                          HelperString.instance.userRoleId) ==
                      HelperString.instance.customer) {
                    return ScreenAddDetails();
                  } else {
                    return ScreenDetails();
                  }
                }(),
              ));
        });
  }
}
