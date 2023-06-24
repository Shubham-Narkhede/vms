class HelperString {
  HelperString._();

  static final instance = HelperString._();

  String userRoleId = "userRole";
  String admin = "admin";
  String customer = "customer";
  String mechanic = "mechanic";

  String databaseName = "MyDatabase.db";
  int databaseVersion = 1;

  String table = 'my_table';

  String columnId = '_id';
  String columnVehicleModel = 'vehicleModel';
  String columnService = 'vehicleService';
  String columnServiceDate = 'vehicleDate';
  String columnServiceTimeSlot = 'vehicleTimeSlot';
}
