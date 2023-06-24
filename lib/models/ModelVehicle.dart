import 'package:vms/helper/HelperString.dart';

class ModelVehicle {
  int? id;
  String vehicleModel;
  String service;
  String serviceDate;
  String serviceTimeSlot;

  ModelVehicle(
      {this.id,
      required this.service,
      required this.serviceDate,
      required this.serviceTimeSlot,
      required this.vehicleModel});

  factory ModelVehicle.fromDatabaseJson(Map<String, dynamic> data) =>
      ModelVehicle(
        id: data[HelperString.instance.columnId],
        vehicleModel: data[HelperString.instance.columnVehicleModel],
        service: data[HelperString.instance.columnService],
        serviceDate: data[HelperString.instance.columnServiceDate],
        serviceTimeSlot: data[HelperString.instance.columnServiceTimeSlot],
      );

  Map<String, dynamic> toDatabaseJson() => {
        HelperString.instance.columnId: id,
        HelperString.instance.columnVehicleModel: vehicleModel,
        HelperString.instance.columnService: service,
        HelperString.instance.columnServiceDate: serviceDate,
        HelperString.instance.columnServiceTimeSlot: serviceTimeSlot
      };
}
