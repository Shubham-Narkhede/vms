import 'package:sqflite/sqflite.dart';
import 'package:vms/helper/HelperString.dart';
import 'package:vms/models/ModelVehicle.dart';

class VehicleRepo {
  // createService this method we are using for adding new user in the database
  Future<int> createService(Transaction txn, ModelVehicle vehicle) async {
    var result =
        txn.insert(HelperString.instance.table, vehicle.toDatabaseJson());

    return result;
  }

  // For getting all the user from database we have created getAllServices method
  Future<List<ModelVehicle>> getAllServices(Transaction txn) async {
    List<Map<String, dynamic>> result;
    result = await txn.query(HelperString.instance.table);
    List<ModelVehicle> listVehicleServices = result.isNotEmpty
        ? result.map((item) => ModelVehicle.fromDatabaseJson(item)).toList()
        : [];
    return listVehicleServices;
  }
}
