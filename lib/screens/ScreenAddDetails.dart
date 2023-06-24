import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vms/cubit/CubitVehicle.dart';
import 'package:vms/helper/HelperFunction.dart';
import 'package:vms/models/ModelVehicle.dart';
import 'package:vms/screens/ScreenDetails.dart';
import 'package:vms/widget/WidgetAppBar.dart';
import 'package:vms/widget/WidgetButton.dart';
import 'package:vms/widget/WidgetTextField.dart';

import '../models/ModelDropDown.dart';
import '../widget/WidgetChild.dart';
import '../widget/WidgetCommonAlert.dart';

// ScreenAddDetails in this screen user can add there service which they want
class ScreenAddDetails extends StatefulWidget {
  @override
  _ScreenAddDetailsState createState() => _ScreenAddDetailsState();
}

class _ScreenAddDetailsState extends State<ScreenAddDetails> {
  TextEditingController controllerVehicleModel = TextEditingController();
  TextEditingController controllerVehicleService = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerTimeSlot = TextEditingController();
  List<ModelDropDown> listTimeSlots = [];

  ModelDropDown? selectedService, selectedTimeSlot;
  DateTime? selectedDate;
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VehicleCubit>(context).init();

    Future.delayed(Duration.zero, () {
      addTimeSlot();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: "Add Service Details",
        listAction: [
          IconButton(
            icon: Icon(Icons.fire_truck),
            onPressed: () {
              clearFields();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ScreenDetails()));
            },
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: WidgetTextField(
                    controller: controllerVehicleModel,
                    hintText: "Vehicle Model",
                    enumValidator: EnumValidator.text,
                    modelTextField: ModelTextField(isCompulsory: true),
                  ),
                ),
                WidgetTextField(
                  controller: controllerVehicleService,
                  eNum: EnumTextField.dropdown,
                  enumValidator: EnumValidator.text,
                  modelTextField: ModelTextField(isCompulsory: true),
                  onTap: () {
                    showAlertDialog("Service", context, [
                      ModelDropDown(id: 1, title: "Car Washing"),
                      ModelDropDown(id: 2, title: "Car Repair"),
                      ModelDropDown(id: 3, title: "Car Puncture"),
                      ModelDropDown(id: 4, title: "Car Decorate"),
                      ModelDropDown(id: 5, title: "Car Modification"),
                      ModelDropDown(id: 5, title: "Car Sound"),
                    ], (v) {
                      selectedService = v;
                      controllerVehicleService.text = v.title;
                    });
                  },
                  hintText: "Service You Want",
                ),
                WidgetTextField(
                  controller: controllerDate,
                  eNum: EnumTextField.datePicker,
                  enumValidator: EnumValidator.text,
                  modelTextField: ModelTextField(isCompulsory: true),
                  selectedDate: (value) {
                    selectedDate = value;
                    controllerDate.text =
                        HelperFunction.dateFormat("dd MMM, yyyy", value);
                  },
                  initialDate: DateTime.now().add(Duration(days: 1)),
                  firstDate: DateTime.now().add(Duration(days: 1)),
                  hintText: "Date Slot",
                ),
                WidgetTextField(
                  controller: controllerTimeSlot,
                  eNum: EnumTextField.dropdown,
                  enumValidator: EnumValidator.text,
                  modelTextField: ModelTextField(isCompulsory: true),
                  onTap: () {
                    showAlertDialog("TimeSlot", context, listTimeSlots, (v) {
                      selectedTimeSlot = v;
                      controllerTimeSlot.text = v.title;
                    });
                  },
                  hintText: "Select Time Slot",
                ),
                WidgetButton(
                  title: 'Submit'.toUpperCase(),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      addVehicleService(ModelVehicle(
                          service: selectedService!.title,
                          serviceDate: controllerDate.text,
                          serviceTimeSlot: selectedTimeSlot!.title,
                          vehicleModel:
                              controllerVehicleModel.text.toString()));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(
    String title,
    BuildContext context,
    List<ModelDropDown> list,
    Function(ModelDropDown) callBack,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonDialog(
            title: title,
            showCancel: true,
            child: WidgetChild(
              list: list,
              callBack: (value) {
                callBack(value);
              },
            ));
      },
    );
  }

  /// here we are simply creating the list of time slots
  addTimeSlot() {
    listTimeSlots.clear();
    List<String> list =
        HelperFunction.getTimes().map((tod) => tod.format(context)).toList();
    for (var i = 0; i < list.length; i++) {
      listTimeSlots.add(ModelDropDown(
          id: i,
          title: i != (list.length - 1) ? "${list[i]} - ${list[i + 1]}" : ""));
    }
    listTimeSlots.removeLast();
  }

  ///addVehicleService in this method we are adding the service in db
  addVehicleService(ModelVehicle vehicle) {
    VehicleCubit cubit = VehicleCubit.get(context);
    cubit.addService(vehicle);
    clearFields();
    Navigator.push(context, MaterialPageRoute(builder: (_) => ScreenDetails()));
  }

  clearFields() {
    controllerVehicleModel.clear();
    controllerVehicleService.clear();
    controllerDate.clear();
    controllerTimeSlot.clear();
    selectedService = null;
    selectedTimeSlot = null;
  }
}
