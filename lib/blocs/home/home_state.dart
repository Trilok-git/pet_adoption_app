

import '../../model/pet.dart';

abstract class HomeState {}

class InitialState extends HomeState {
  final List<Pet> pets;
  InitialState(this.pets);
}

class PetLoaded extends HomeState{
  final List<Pet> pets;

  PetLoaded(this.pets);
}

class PetLoading extends HomeState {
  final bool isFetched;
  final List<Pet> pets = [];

  PetLoading({this.isFetched=false});
}