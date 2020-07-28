import 'package:demoblocprovider/login_with_bloc/models/user_name.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'models/password.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const UserName.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final UserName username;
  final Password password;

  LoginState copyWith({
    FormzStatus status,
    UserName username,
    Password password,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}