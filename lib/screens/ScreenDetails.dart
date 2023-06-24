import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vms/helper/HelperSharedPreference.dart';
import 'package:vms/models/ModelVehicle.dart';
import 'package:vms/screens/ScreenLogin.dart';
import 'package:vms/widget/WidgetAppBar.dart';
import 'package:vms/widget/WidgetText.dart';

import '../cubit/CubitVehicle.dart';
import 'ScreenVehicleListing.dart';

//ScreenDetails this screen basically we have created for showing details of all booked services
class ScreenDetails extends StatefulWidget {
  @override
  _ScreenDetailsState createState() => _ScreenDetailsState();
}

class _ScreenDetailsState extends State<ScreenDetails> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VehicleCubit>(context).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: WidgetAppBar(
        title: "Service Details",
        listAction: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout();
            },
          )
        ],
      ),
      body: BlocBuilder<VehicleCubit, StateVehicle>(builder: (_, state) {
        if (state is StateLoading) {
          return const CircularProgressIndicator();
        } else if (state is StateError) {
          return Text(state.error.toString());
        } else if (state is StateSuccess) {
          return state.list.isEmpty
              ? Center(
                  child: widgetText(
                      text: "No User added any service they want yet"),
                )
              : ScreenVehicleList(state.list);
        }
        return Container();
      }),
    );
  }

  logout() {
    HelperSharedPreference.clearPreferences().then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => ScreenLogin()),
          (Route<dynamic> route) => false);
    });
  }
}
