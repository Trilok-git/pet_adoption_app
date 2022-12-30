

import '../../model/pet.dart';

abstract class DetailState {}

class InitialState extends DetailState {

  InitialState();
}


class PetAdopted extends DetailState {
  final Pet pet;
  final bool isAdoped;
  PetAdopted(this.pet,this.isAdoped);
}



