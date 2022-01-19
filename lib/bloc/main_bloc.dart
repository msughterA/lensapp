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

class LogInEvent extends MainEvent {
  final String phoneNumber;
  final String deviceId;
  final String password;
  LogInEvent({this.deviceId, this.password, this.phoneNumber});
  @override
  List<Object> get props => [deviceId, password, phoneNumber];
}

class LogOutEvent extends MainEvent {
  final String phoneNumber;
  final String deviceId;
  LogOutEvent({this.phoneNumber, this.deviceId});
  @override
  List<Object> get props => [phoneNumber, deviceId];
}

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
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String deviceId;
  VerifyNumberEvent(
      {this.phoneAuthCredential,
      this.email,
      this.password,
      this.phoneNumber,
      this.deviceId,
      this.username});
  @override
  List<Object> get props =>
      [phoneAuthCredential, email, password, phoneNumber, deviceId, username];
}

class EditEvent extends MainEvent {
  final String email;
  final String username;
  final String phoneNumber;
  EditEvent({this.email, this.username, this.phoneNumber});
  @override
  List<Object> get props => [email, username, phoneNumber];
}

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

class LogInError extends MainState {
  final String message;
  LogInError({this.message});
  @override
  List<Object> get props => [];
}

class VerifyState extends MainState {
  final verificationId;
  VerifyState({this.verificationId});
  @override
  List<Object> get props => [verificationId];
}

class VerifyLoadingState extends MainState {}

class LogOutState extends MainState {}

class LogOutLoadingState extends MainState {}

class VerifyError extends MainState {
  final String message;
  VerifyError({this.message});
  @override
  List<Object> get props => [];
}

class LogOutError extends MainState {
  final String message;
  LogOutError({this.message});
  @override
  List<Object> get props => [];
}

class SignUpState extends MainState {}

class SignUpLoadingState extends MainState {}

class SignUpError extends MainState {
  final String message;
  SignUpError({this.message});
  @override
  List<Object> get props => [];
}

class ValidateLoadingState extends MainState {}

class HomeState extends MainState {}

class ValidationError extends MainState {
  final String message;
  ValidationError({this.message});
  @override
  List<Object> get props => [];
}

class EditedState extends MainState {}

class EditLoadingState extends MainState {}

class EditError extends MainState {
  final String message;
  EditError({this.message});
  @override
  List<Object> get props => [message];
}

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
    on<VerifyNumberEvent>((event, emit) => sendCredentials(
          emit: emit,
          phoneAuthCredential: event.phoneAuthCredential,
          username: event.username,
          password: event.password,
          phoneNumber: event.phoneNumber,
          email: event.email,
          deviceId: event.deviceId,
        ));
    on<EditEvent>((event, emit) => editData(
        emit: emit,
        phoneNumber: event.phoneNumber,
        email: event.email,
        username: event.username));
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
    on<LogOutEvent>((event, emit) =>
        logOut(phoneNumber: event.phoneNumber, deviceId: event.deviceId));
    on<LogInEvent>((event, emit) => login(
        password: event.password,
        deviceId: event.deviceId,
        phoneNumber: event.phoneNumber));
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
          print('Invalid phone number error');
          //add(GoToStateEvent(
          //    inputState: ErrorState(message: 'invalid number')));
          emitError(ErrorType.validateError, 'invalid number');
        },
        codeSent: (verificationId, resendingToken) async {
          add(GoToStateEvent(
              inputState: VerifyState(verificationId: verificationId)));
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  Future<void> sendCredentials({
    Emitter<MainState> emit,
    PhoneAuthCredential phoneAuthCredential,
    username,
    password,
    phoneNumber,
    email,
    deviceId,
  }) async {
    add(GoToStateEvent(inputState: VerifyLoadingState()));
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (authCredential?.user != null) {
        var response = await createAccount(
            username: username,
            password: password,
            email: email,
            phoneNumber: phoneNumber,
            deviceId: deviceId);
        if (response != null) {
          add(GoToStateEvent(inputState: HomeState()));
        }
      }
    } on FirebaseAuthException catch (e) {
      //add(GoToStateEvent(inputState: ErrorState(message: 'Invalid Details')));
      emitError(ErrorType.verifyError, 'Invalid Details');
    }
  }

  Future<void> editData(
      {Emitter<MainState> emit, username, email, phoneNumber}) async {
    emit(EditLoadingState());
    var request = {
      'username': username,
      'phone_number': phoneNumber,
      'email': email
    };
    var response = await BaseClient()
        .post(ApiConstants.BASE_URL, ApiConstants.CREATE_ACCOUNT, request)
        .catchError((error) {
      handleError(ErrorType.signUpError, error);
    });
    return response;
    // the function would emit an error state in the case of an error
    //emit(EditError());
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
    await BaseClient()
        .post(ApiConstants.BASE_URL, ApiConstants.VERIFY, request)
        .catchError((error) {
      handleError(ErrorType.validateError, error);
      isError = true;
      return isError;
    });
    return isError;
  }

  Future createAccount(
      {Emitter emit, username, password, phoneNumber, deviceId, email}) async {
    var request = {
      'username': username,
      'phone_number': phoneNumber,
      'password': password,
      'device_id': deviceId,
      'email': email
    };
    var response = await BaseClient()
        .post(ApiConstants.BASE_URL, ApiConstants.CREATE_ACCOUNT, request)
        .catchError((error) {
      handleError(ErrorType.signUpError, error);
    });
    return response;
  }

  Future logOut({Emitter emit, phoneNumber, deviceId}) async {
    var request = {
      'phone_number': phoneNumber,
      'device_id': deviceId,
    };
    add(GoToStateEvent(inputState: LogOutLoadingState()));
    var response = await BaseClient()
        .delete(ApiConstants.BASE_URL, ApiConstants.LOGIN, request)
        .catchError((error) {
      handleError(ErrorType.logOutError, error);
    });
    if (response != null) {
      add(GoToStateEvent(inputState: LogInState()));
    }
  }

  Future login({Emitter emit, phoneNumber, deviceId, password}) async {
    var request = {
      'phone_number': phoneNumber,
      'device_id': deviceId,
      'password': password
    };
    add(GoToStateEvent(inputState: LogInLoadingState()));
    var response = await BaseClient()
        .put(ApiConstants.BASE_URL, ApiConstants.LOGIN, request)
        .catchError((error) {
      handleError(ErrorType.logInError, error);
    });

    if (response != null) {
      add(GoToStateEvent(inputState: HomeState()));
    }
  }

  void handleError(ErrorType type, error) {
    if (error is BadRequestException) {
      print('Bad Request ${error}');
      //add(GoToStateEvent(inputState: ErrorState(message: 'Bad Request')));
      emitError(type, 'Bad Request');
    } else if (error is ApiNotRespondingException) {
      print('Api not responding ${error}');
      //add(GoToStateEvent(inputState: ErrorState(message: 'Took too long')));
      emitError(type, 'Took too long');
    } else if (error is UnAuthorizedException) {
      print('Unauthorized exception ${error}');
      //add(GoToStateEvent(inputState: ErrorState(message: error.message)));
      emitError(type, error.message);
    } else if (error is FetchDataException) {
      print('Fetch data exception ${error}');
      //add(GoToStateEvent(
      //    inputState: ErrorState(message: 'Fetch data exception')));
      emitError(type, 'Fetch data exception');
    }
  }

  void emitError(ErrorType type, String message) {
    switch (type) {
      case ErrorType.logInError:
        add(GoToStateEvent(inputState: LogInError(message: message)));
        break;
      case ErrorType.logOutError:
        add(GoToStateEvent(inputState: LogOutError(message: message)));
        break;
      case ErrorType.validateError:
        add(GoToStateEvent(inputState: ValidationError(message: message)));
        break;
      case ErrorType.verifyError:
        add(GoToStateEvent(inputState: VerifyError(message: message)));
        break;
      case ErrorType.signUpError:
        add(GoToStateEvent(inputState: SignUpError(message: message)));
        break;
      case ErrorType.editError:
        add(GoToStateEvent(inputState: EditError(message: message)));
        break;
      default:
    }
  }
}

enum ErrorType {
  logOutError,
  logInError,
  validateError,
  verifyError,
  signUpError,
  editError
}
