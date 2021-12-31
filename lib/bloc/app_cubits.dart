import 'package:bloc/bloc.dart';
//import 'package:lensapp/cubit/app_cubit_states.dart';
import 'app_cubit_states.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits() : super(InitialState()) {
    emit(LoginState());
  }

  void signUp() {
    emit(VerificationLoadingState());
  }
}
