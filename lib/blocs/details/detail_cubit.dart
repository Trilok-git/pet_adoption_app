import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/pet.dart';
import '../home/pet_cubit.dart';
import 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {

  DetailCubit(super.initialState);


  static List<String> adoptedPetId = [];

  bool isAdopted = false;

  loadPetDetail(String petId) {
    print("entered");
    Pet selectedPet= Pet(id:"",name: "",age: "",price: 0,image: "",isAdopted: false);
    for(Pet pet in Pet.PetsList) {
      if(pet.id == petId) {
        selectedPet = pet;
      }
    }

    // if(adoptedPetId.contains(pet.id)) {
    //   isAdopted = true;
    //   emit(PetAdopted(pet, true));
    // }else{
      emit(PetAdopted(selectedPet, false));
    // }

  }


  Future<void> adopt(String petId) async {
    Pet adoptedPet= Pet(id:"",name: "",age: "",price: 0,image: "",isAdopted: false);
    for(Pet pet in Pet.PetsList) {
      if(pet.id == petId) {
        pet.isAdopted = true;
        adoptedPet = pet;
      }
    }
    print(adoptedPet.isAdopted);

    if(!adoptedPetId.contains(petId)) {
      adoptedPetId.add(petId);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList("adoptedPets", adoptedPetId);

      emit(PetAdopted(adoptedPet, true));
    }

    PetCubit().loadPets();

  }


}