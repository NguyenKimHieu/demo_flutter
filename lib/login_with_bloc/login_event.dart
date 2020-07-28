import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class UserNameChanged extends LoginEvent {
  final String userName;

  UserNameChanged(this.userName);

  @override
  List<Object> get props => [userName];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class FormSubmitted extends LoginEvent {}
