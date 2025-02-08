
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowCursorColor extends Cubit<bool>{
  ShowCursorColor() : super(false);

  void changeTheCursorColor(){ // Change The Cursor
    emit(true);
  }

  void resetTheCursorColor(){ // Reset The Color
    emit(false);
  }
}