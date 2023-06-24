import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vms/helper/HelperString.dart';

import '../models/ModelVehicle.dart';
import '../repo/Repo.dart';

part 'StateVehicle.dart';

class VehicleCubit extends Cubit<StateVehicle> {
  VehicleCubit(this.vehicleRepo) : super(VehicleInitial());
  VehicleRepo vehicleRepo;

  /// this line is created for get the context or instance of this class
  static VehicleCubit get(context) => BlocProvider.of(context);

  /// database object we have initialize the open data
  late Database database;

  /// this init method is created for creating the database or table
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path =
        join(documentsDirectory.path, HelperString.instance.databaseName);
    await openDatabase(path,
        version: HelperString.instance.databaseVersion,
        onCreate: _onCreate, onOpen: (value) {
      database = value;
      getAllServices();
    }).then((value) {
      database = value;
    }).catchError((onError) {});
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${HelperString.instance.table} (
            ${HelperString.instance.columnId} INTEGER PRIMARY KEY,
            ${HelperString.instance.columnVehicleModel} TEXT NOT NULL,
            ${HelperString.instance.columnService} TEXT NOT NULL,
            ${HelperString.instance.columnServiceDate} TEXT NOT NULL,
            ${HelperString.instance.columnServiceTimeSlot} TEXT NOT NULL
          )
          ''').then((value) {}).catchError((onError) {});
  }

  /// here we have created the method for getting all the operations like
  /// get, add, update and delete
  /// we are emitting the response on the basis of result
  getAllServices() async {
    emit(StateLoading());
    await database.transaction((txn) {
      return vehicleRepo.getAllServices(txn).then((value) {
        emit(StateSuccess(value));
      }).catchError((onError) {
        emit(StateError(onError.toString()));
      });
    });
  }

  /// when we are going to add user we are using this method for adding the user in database
  addService(ModelVehicle vehicle) async {
    await database.transaction((txn) {
      return vehicleRepo.createService(txn, vehicle).then((value) {
        getAllServices();
      });
    });
  }
}
