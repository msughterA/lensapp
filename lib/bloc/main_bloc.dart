import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lensapp/services/app_exceptions.dart';
import '/services/app_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lensapp/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class SummarizeEvent extends MainEvent {
  final img;
  final mode;
  SummarizeEvent({this.img, this.mode});
  @override
  List<Object> get props => [img, mode];
}

class ExampleEvent extends MainEvent {
  final img;
  final mode;
  ExampleEvent({this.img, this.mode});
  @override
  List<Object> get props => [img, mode];
}

class AnswerChemistryEvent extends MainEvent {
  final img;
  final mode;
  AnswerChemistryEvent({this.img, this.mode});
  @override
  List<Object> get props => [img, mode];
}

class CalculateEvent extends MainEvent {
  final img;
  final mode;
  CalculateEvent({this.img, this.mode});
  @override
  List<Object> get props => [img, mode];
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
  final String newPhoneNumber;
  EditEvent({this.email, this.username, this.phoneNumber, this.newPhoneNumber});
  @override
  List<Object> get props => [email, username, phoneNumber, newPhoneNumber];
}

class GoToEdit extends MainEvent {
  final String email;
  final String username;
  final String phoneNumber;
  GoToEdit({this.email, this.username, this.phoneNumber});
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

class Calculatiing extends MainState {}

class Solution extends MainState {
  final List question;
  final List answer;
  Solution({this.answer, this.question});
  @override
  List<Object> get props => [question, answer];
}

class Example extends MainState {
  final List examples;
  Example({this.examples});
  @override
  List<Object> get props => [examples];
}

class AnsweredChemistry extends MainState {
  final List question;
  final List answer;
  AnsweredChemistry({this.answer, this.question});
  @override
  List<Object> get props => [question, answer];
}

class Summary extends MainState {
  final List summary;
  Summary({this.summary});
  @override
  List<Object> get props => [summary];
}

class SummaryError extends MainState {
  final String message;
  SummaryError({this.message});
  @override
  List<Object> get props => [message];
}

class ExampleError extends MainState {
  final String message;
  ExampleError({this.message});
  @override
  List<Object> get props => [message];
}

class AnswerChemistryError extends MainState {
  final String message;
  AnswerChemistryError({this.message});
  @override
  List<Object> get props => [message];
}

class AnsweringChemistry extends MainState {}

class ExampleLoading extends MainState {}

class LogInState extends MainState {}

class LogInLoadingState extends MainState {}

class LogInError extends MainState {
  final String message;
  LogInError({this.message});
  @override
  List<Object> get props => [];
}

class CalculationError extends MainState {
  final String message;
  CalculationError({this.message});
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

class Summarizing extends MainState {}

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

class EditState extends MainState {}

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
        newPhoneNumber: event.newPhoneNumber,
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
    on<CalculateEvent>((event, emit) =>
        calculate(emit: emit, img: event.img, mode: event.mode));
    on<LogOutEvent>((event, emit) =>
        logOut(phoneNumber: event.phoneNumber, deviceId: event.deviceId));
    on<LogInEvent>((event, emit) => runLogin(
        password: event.password,
        deviceId: event.deviceId,
        phoneNumber: event.phoneNumber));
    on<SummarizeEvent>(
        (event, emit) => summarize(img: event.img, mode: event.mode));
    on<AnswerChemistryEvent>(
        (event, emit) => answerChemistry(img: event.img, mode: event.mode));
    on<ExampleEvent>(
        (event, emit) => example(img: event.img, mode: event.mode));
    on<GoToEdit>((event, emit) => emit(EditState()));
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
      {Emitter<MainState> emit,
      username,
      email,
      phoneNumber,
      newPhoneNumber}) async {
    emit(EditLoadingState());

    var request = {
      'username': username,
      'phone_number': phoneNumber,
      'email': email,
      'new_phone_number': newPhoneNumber
    };

    if (username != null) {
      request.removeWhere((key, value) => key == "email");
      request.removeWhere((key, value) => key == "new_phone_number");
      //request['phone_number'] = phoneNumber;
    } else if (newPhoneNumber != null) {
      request.removeWhere((key, value) => key == "email");
      request.removeWhere((key, value) => key == "username");
    } else if (email != null) {
      request.removeWhere((key, value) => key == "username");
      request.removeWhere((key, value) => key == "new_phone_number");
    }
    print(request);
    var response = await BaseClient()
        .put(ApiConstants.BASE_URL, ApiConstants.CREATE_ACCOUNT, request)
        .catchError((error) {
      handleError(ErrorType.editError, error);
    });

    if (response != null) {
      final pref = await SharedPreferences.getInstance();
      if (username != null) {
        pref.setString('username', username);
      } else if (newPhoneNumber != null) {
        pref.setString('phoneNumber', newPhoneNumber);
      } else if (email != null) {
        pref.setString('email', email);
      }
      emit(EditedState());
    }
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

  runLogin({Emitter emit, phoneNumber, deviceId, password}) async {
    var response = await login(
        emit: emit,
        password: password,
        phoneNumber: phoneNumber,
        deviceId: deviceId);
    if (response != null) {
      final pref = await SharedPreferences.getInstance();
      pref.setString('username', response['username']);
      pref.setString('email', response['email']);
      add(GoToStateEvent(inputState: HomeState()));
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
        .post(ApiConstants.BASE_URL, ApiConstants.LOGIN, request)
        .catchError((error) {
      handleError(ErrorType.logInError, error);
    });
    return response;
  }

  Future calculate({Emitter emit, var img, String mode}) async {
    var request = {'image': img, 'mode': mode};
    add(GoToStateEvent(inputState: Calculatiing()));
    var response = await BaseClient()
        .post(ApiConstants.BASE_URL, ApiConstants.MATHEMATICS, request)
        .catchError((error) {
      handleError(ErrorType.calculationError, error);
    });
    if (response != null) {
      var question = response['question'];
      var answer = response['answer'];
      print('Adding Event to the bloc');
      print(question);
      emit(Solution(question: question, answer: answer));
    } else {
      print('A SERVER ERROR OCCURRED');
      handleError(ErrorType.calculationError, 'Server error');
    }
  }

  Future summarize({var img, String mode}) async {
    var request = {'image': img, 'mode': mode};
    add(GoToStateEvent(inputState: Summarizing()));
    var response = await BaseClient()
        .post(ApiConstants.BASE_URL, ApiConstants.SUMMARIZER, request);
    if (response != null) {
      var summary = response['summary'];
      add(GoToStateEvent(inputState: Summary(summary: summary)));
    } else {
      print('A SERVER ERROR OCCURRED');
      handleError(ErrorType.summaryError, 'Server error');
    }
  }

  Future example({var img, String mode}) async {
    var request = {'image': img, 'mode': mode};
    add(GoToStateEvent(inputState: ExampleLoading()));
    var response = await BaseClient()
        .post(ApiConstants.BASE_URL, ApiConstants.EXAMPLES, request);
    if (response != null) {
      var examples = response['examples'];
      print(examples);
      add(GoToStateEvent(inputState: Example(examples: examples)));
    } else {
      print('A SERVER ERROR OCCURRED');
      handleError(ErrorType.exampleError, 'Server error');
    }
  }

  Future answerChemistry({var img, String mode}) async {
    var request = {'image': img, 'mode': mode};
    add(GoToStateEvent(inputState: AnsweringChemistry()));
    var response = await BaseClient()
        .post(ApiConstants.BASE_URL, ApiConstants.CHEMISTRY, request);
    if (response != null) {
      var question = response['question'];
      var answer = response['answer'];
      add(GoToStateEvent(
          inputState: AnsweredChemistry(question: question, answer: answer)));
    } else {
      print('A SERVER ERROR OCCURRED');
      handleError(ErrorType.answerChemistryError, 'Server error');
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
      case ErrorType.calculationError:
        add(GoToStateEvent(inputState: CalculationError(message: message)));
        break;
      case ErrorType.editError:
        add(GoToStateEvent(inputState: EditError(message: message)));
        break;
      case ErrorType.summaryError:
        add(GoToStateEvent(inputState: SummaryError(message: message)));
        break;
      case ErrorType.answerChemistryError:
        add(GoToStateEvent(inputState: AnswerChemistryError(message: message)));
        break;
      case ErrorType.exampleError:
        add(GoToStateEvent(inputState: ExampleError(message: message)));
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
  editError,
  calculationError,
  summaryError,
  answerChemistryError,
  exampleError,
}
