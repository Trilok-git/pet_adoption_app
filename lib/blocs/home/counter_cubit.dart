
import 'package:bloc/bloc.dart';

import '../../model/pet.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(1);

  static int currentPage = 1;

  void getInitial() {
    emit(1);
  }

  void getPage(){
    emit(currentPage);
  }

}