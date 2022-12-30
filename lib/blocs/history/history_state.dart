
import '../../model/pet.dart';

abstract class HistoryState {}

class InitialState extends HistoryState {

  InitialState();
}

class PetLoaded extends HistoryState {
  final List<Pet> pets;

  PetLoaded(this.pets);
}
