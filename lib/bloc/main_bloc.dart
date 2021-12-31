//import 'dart:html';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:lensapp/cubit/app_cubit_states.dart';

class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LogInEvent extends MainEvent {}

class SignUpEvent extends MainEvent {}

class VerifyEvent extends MainEvent {}

class MainState extends Equatable {
  @override
  List<Object> get props => [];
}

class LogInState extends MainState {}

class LogInLoadingState extends MainState {}

class LogInError extends MainState {}

class VerifyState extends MainState {}

class VerifyLoadingState extends MainState {}

class VerificationError extends MainState {}

class SignUpState extends MainState {}

class SignUpLoadingState extends MainState {}

class SignUpError extends MainState {}

class HomeState extends MainState {}

class VerificatonError extends MainState {}

class Initial extends MainState {}

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(MainState initialState) : super(initialState) {
    on<VerifyEvent>((event, emit) => verifyData((emit)));
  }

  @override
  MainState get InitialState => Initial();

  Future<void> verifyData(Emitter<MainState> emit) async {
    emit(VerifyLoadingState());
    await Future.delayed(Duration(seconds: 2), () {
      print('i worked');
    });
    emit(HomeState());
  }
}
