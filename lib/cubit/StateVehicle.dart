part of 'CubitVehicle.dart';

abstract class StateVehicle extends Equatable {
  const StateVehicle();

  @override
  List<Object> get props => [];
}

class VehicleInitial extends StateVehicle {}

class StateLoading extends StateVehicle {}

class StateSuccess extends StateVehicle {
  StateSuccess(this.list);

  final List<ModelVehicle> list;

  @override
  List<ModelVehicle> get getList => list;
}

class StateError extends StateVehicle {
  StateError(this.error);

  final String error;

  @override
  String get getError => error;
}
