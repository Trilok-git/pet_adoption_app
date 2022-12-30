import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/pet.dart';
import '../details/detail_cubit.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {

  HistoryCubit(super.initialState);


  loadAdoptedPets() {
    print("loading adopted");
    List<Pet> adoptedPetList = [];

    for(String petId in DetailCubit.adoptedPetId) {
      for(Pet pet in Pet.PetsList) {
        if(pet.id == petId) {
          adoptedPetList.add(pet);
        }
      }
    }

    emit(PetLoaded(adoptedPetList));
  }

}

