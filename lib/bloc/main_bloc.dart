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

class EditEvent extends MainEvent {}

class DisplayErrorEvent extends MainEvent {
  final inputState;
  DisplayErrorEvent({this.inputState});
  @override
  List<Object> get props => [inputState];
}

class ResetEvent extends MainEvent {
  final inputState;
  ResetEvent({this.inputState});
  @override
  List<Object> get props => [inputState];
}

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

class EditedState extends MainState {}

class EditLoadingState extends MainState {}

class EditError extends MainState {}

class Initial extends MainState {}

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(MainState initialState) : super(initialState) {
    on<VerifyEvent>((event, emit) => verifyData((emit)));
    on<EditEvent>((event, emit) => editData(emit));
    on<ResetEvent>((event, emit) => emit(event.inputState));
    on<DisplayErrorEvent>((event, emit) => displayError(emit, HomeState()));
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

  Future<void> editData(Emitter<MainState> emit) async {
    emit(EditLoadingState());
    await Future.delayed(Duration(seconds: 2), () {
      print('Data edited');
    });
    // the function would emit an error state in the case of an error
    emit(EditError());
  }

  displayError(Emitter<MainState> emit, MainState displayState) async {
    emit(displayState);
  }
}
