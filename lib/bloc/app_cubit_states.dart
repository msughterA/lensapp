import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {
  @override
  List<Object> get props => [];
}

// login state
class LoginState extends CubitStates {
  @override
  List<Object> get props => [];
}

// sign up state
class SignUpState extends CubitStates {
  @override
  List<Object> get props => [];
}

// signup loading state
class SignUpLoadingState extends CubitStates {
  @override
  List<Object> get props => [];
}

// verification state
class VerificationState extends CubitStates {
  @override
  List<Object> get props => [];
}

// verification loading state
class VerificationLoadingState extends CubitStates {
  @override
  List<Object> get props => [];
}

// Home state
class HomeState extends CubitStates {
  @override
  List<Object> get props => [];
}
