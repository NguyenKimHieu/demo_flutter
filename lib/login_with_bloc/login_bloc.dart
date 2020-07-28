import 'package:demoblocprovider/login_with_bloc/login_event.dart';
import 'package:demoblocprovider/login_with_bloc/login_state.dart';
import 'package:demoblocprovider/login_with_bloc/models/password.dart';
import 'package:demoblocprovider/login_with_bloc/models/user_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);
  final loading = BlocObserver();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UserNameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is PasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is FormSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    UserNameChanged event,
    LoginState state,
  ) {
    final username = UserName.dirty(event.userName);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(
    PasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    FormSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        print('Pressssss!');
        await Future.delayed(Duration(seconds: 5), () {});
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
