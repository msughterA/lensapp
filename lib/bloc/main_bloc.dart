import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lensapp/services/app_exceptions.dart';
import '/services/app_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lensapp/constants/api_constants.dart';

//import 'package:lensapp/cubit/app_cubit_states.dart';

class MainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LogInEvent extends MainEvent {}

class VerifyErrorEvent extends MainEvent {
  final String message;
  VerifyErrorEvent({this.message});
  @override
  List<Object> get props => [];
}

class ValidateDataEvent extends MainEvent {
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String deviceId;
  ValidateDataEvent(
      {this.username,
      this.email,
      this.password,
      this.phoneNumber,
      this.deviceId});
  @override
  List<Object> get props => [username, email, password, phoneNumber, deviceId];
}

class VerifyNumberEvent extends MainEvent {
  final PhoneAuthCredential phoneAuthCredential;
  VerifyNumberEvent({this.phoneAuthCredential});
  @override
  List<Object> get props => [phoneAuthCredential];
}

class EditEvent extends MainEvent {}

class GoToStateEvent extends MainEvent {
  final inputState;
  GoToStateEvent({this.inputState});
  @override
  List<Object> get props => [inputState];
}

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

class VerifyState extends MainState {
  final verificationId;
  VerifyState({this.verificationId});
  @override
  List<Object> get props => [verificationId];
}

class VerifyLoadingState extends MainState {}

class VerificationError extends MainState {}

class SignUpState extends MainState {}

class SignUpLoadingState extends MainState {}

class SignUpError extends MainState {}

class ValidateLoadingState extends MainState {}

class HomeState extends MainState {}

class VerificatonError extends MainState {}

class EditedState extends MainState {}

class EditLoadingState extends MainState {}

class EditError extends MainState {}

class ErrorState extends MainState {
  final String message;
  ErrorState({this.message});
  @override
  List<Object> get props => [message];
}

class Initial extends MainState {}

class MainBloc extends Bloc<MainEvent, MainState> {
  final _auth = FirebaseAuth.instance;
  MainBloc(MainState initialState) : super(initialState) {
    on<VerifyNumberEvent>(
        (event, emit) => sendCredentials(emit, event.phoneAuthCredential));
    on<EditEvent>((event, emit) => editData(emit));
    on<ResetEvent>((event, emit) => emit(event.inputState));
    on<DisplayErrorEvent>((event, emit) => displayError(emit, HomeState()));
    on<VerifyErrorEvent>(
        (event, emit) => emit(ErrorState(message: event.message)));
    on<ValidateDataEvent>((event, emit) => runValidations(
        emit: emit,
        username: event.username,
        email: event.email,
        password: event.password,
        deviceId: event.deviceId,
        phoneNumber: event.phoneNumber));
    on<GoToStateEvent>((event, emit) => emit(event.inputState));
  }

  @override
  MainState get InitialState => Initial();

  Future<void> runValidations(
      {Emitter<MainState> emit,
      username,
      password,
      phoneNumber,
      deviceId,
      email}) async {
    emit(ValidateLoadingState());
    bool isError = await validateData(
        emit: emit,
        email: email,
        deviceId: deviceId,
        username: username,
        password: password,
        phoneNumber: phoneNumber);
    if (isError == false) {
      await verifyNumber(emit, phoneNumber);
    }
  }

  Future<void> verifyNumber(
    Emitter<MainState> emit,
    String phoneNumber,
  ) async {
    //emit(VerifyLoadingState());
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          // set the appropriate state
        },
        verificationFailed: (verificationFailed) async {
          //await verificationFailed.message;
          // emit(ErrorState(message: 'number verification failed'));
          print('Invalid phone number error');
          add(VerifyErrorEvent(message: 'Invalid Phone Number'));
        },
        codeSent: (verificationId, resendingToken) async {
          add(GoToStateEvent(
              inputState: VerifyState(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  Future<void> sendCredentials(
      Emitter<MainState> emit, PhoneAuthCredential phoneAuthCredential) async {
    emit(VerifyLoadingState());
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredential?.user != null) {
        emit(HomeState());
      }
    } on FirebaseAuthException catch (e) {
      emit(VerificationError());
    }
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

  Future<bool> validateData(
      {Emitter emit, username, password, phoneNumber, deviceId, email}) async {
    var request = {
      'username': username,
      'phone_number': phoneNumber,
      'password': password,
      'device_id': deviceId,
      'email': email
    };
    bool isError = false;
    var response = await BaseClient()
        .post(ApiConstants.BASE_URL, ApiConstants.VERIFY, request)
        .catchError((error) {
      handleError(emit, error);
      isError = true;
      return isError;
    });
    return isError;
  }

  void handleError(Emitter<MainState> emit, error) {
    if (error is BadRequestException) {
      print('Bad Request ${error}');
      add(GoToStateEvent(inputState: ErrorState(message: 'Bad Request')));
    } else if (error is ApiNotRespondingException) {
      print('Api not responding ${error}');
      add(GoToStateEvent(inputState: ErrorState(message: 'Took too long')));
    } else if (error is UnAuthorizedException) {
      print('Unauthorized exception ${error}');
      add(GoToStateEvent(inputState: ErrorState(message: error.message)));
    } else if (error is FetchDataException) {
      print('Fetch data exception ${error}');
      add(GoToStateEvent(
          inputState: ErrorState(message: 'Fetch data exception')));
    }
  }
}
