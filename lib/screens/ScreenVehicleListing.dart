import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vms/models/ModelVehicle.dart';
import 'package:vms/widget/WidgetText.dart';

class ScreenVehicleList extends StatelessWidget {
  List<ModelVehicle> listModelVehicle;
  ScreenVehicleList(this.listModelVehicle);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, int i) {
        ModelVehicle vehicle = listModelVehicle[i];
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
          padding: EdgeInsets.only(left: 8.w, top: 6.h, bottom: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widgetText(
                  text: vehicle.vehicleModel,
                  textStyle:
                      textStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
              widgetChild(vehicle.service, Icons.settings),
              widgetChild(vehicle.serviceDate, Icons.calendar_today),
              widgetChild(vehicle.serviceTimeSlot, Icons.lock_clock),
            ],
          ),
        );
      },
      itemCount: listModelVehicle.length,
    );
  }

  Widget widgetChild(String title, IconData iconData) {
    return Container(
      margin: EdgeInsets.only(
        top: 4.h,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 20.h,
            color: Colors.grey.shade700,
          ),
          Container(
            margin: EdgeInsets.only(left: 4.w),
            child: widgetText(
                text: title,
                textStyle: textStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    textColor: Colors.grey.shade700)),
          ),
        ],
      ),
    );
  }
}
