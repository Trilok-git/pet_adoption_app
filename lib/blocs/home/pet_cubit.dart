
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/pet.dart';
import '../details/detail_cubit.dart';
import 'counter_cubit.dart';
import 'home_state.dart';

class PetCubit extends Cubit<HomeState> {

  PetCubit() : super(InitialState(Pet.getInitialList(6)));

  int currentPage = 1;

  int cardCount = 6;

  String searchQuery = "";

  // static List<String> adoptedPetId = [];


  Future<void> loadPets() async {
    emit(PetLoading(isFetched: false));

    //get adopted pet's id from SharedPref
    final prefs = await SharedPreferences.getInstance();
    final List<String>? adoptedPet = prefs.getStringList('adoptedPets');
    if(adoptedPet!=null) {
      DetailCubit.adoptedPetId = adoptedPet;

      for(Pet pet in Pet.PetsList) {
        for (var id in adoptedPet) {
          if(pet.id == id) {
            pet.isAdopted = true;

          }
        }
      }


    }
    final List<Pet> tempList = [];

    for(int i=0; i<cardCount; i++){
      tempList.add(Pet.PetsList.elementAt(i));
    }

    CounterCubit.currentPage = 1;
    CounterCubit().getPage();

    Future.delayed(Duration(seconds: 1),(){
      emit(PetLoaded(tempList));
    });
  }



  void nextPage(){
    emit(PetLoading(isFetched: false));
    final List<Pet> tempList = [];
    CounterCubit.currentPage += 1;
    int startIndex = (CounterCubit.currentPage-1) * cardCount;
    int endIndex = startIndex+cardCount;
    if(endIndex>Pet.PetsList.length) {
      endIndex = Pet.PetsList.length;
    }
    for(int i=startIndex; i<endIndex; i++){
      tempList.add(Pet.PetsList.elementAt(i));
    }
    Future.delayed(Duration(seconds: 1),(){
      emit(PetLoaded(tempList));
    });
  }

  void prevPage(){
    emit(PetLoading(isFetched: false));
    final List<Pet> tempList = [];
    CounterCubit.currentPage -= 1;
    int startIndex = (CounterCubit.currentPage-1) * cardCount;
    int endIndex = startIndex+cardCount;
    if(endIndex>Pet.PetsList.length) {
      endIndex = Pet.PetsList.length;
    }
    for(int i=startIndex; i<endIndex; i++){
      tempList.add(Pet.PetsList.elementAt(i));
    }
    Future.delayed(Duration(seconds: 1),(){
      emit(PetLoaded(tempList));
    });
  }


  void search(String s) {
    final List<Pet> searchResult = [];

    if(s==""){
      for(int i=0; i<cardCount; i++) {
        searchResult.add(Pet.PetsList[i]);
      }
    }else {
      for (var pet in Pet.PetsList) {
        if (pet.name.toLowerCase().contains(s.toLowerCase())) {
          searchResult.add(pet);
        }
      }
    }

    emit(PetLoaded(searchResult));
  }


  Future<void> refresh() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? adoptedPet = prefs.getStringList('adoptedPets');
    if(adoptedPet!=null) {
      DetailCubit.adoptedPetId = adoptedPet;

      for(Pet pet in Pet.PetsList) {
        for (var id in adoptedPet) {
          if(pet.id == id) {
            pet.isAdopted = true;

          }
        }
      }


    }
    final List<Pet> tempList = [];

    for(int i=0; i<cardCount; i++){
      tempList.add(Pet.PetsList.elementAt(i));
    }

    CounterCubit.currentPage = 1;
    CounterCubit().getPage();

    emit(PetLoaded(tempList));
  }



}