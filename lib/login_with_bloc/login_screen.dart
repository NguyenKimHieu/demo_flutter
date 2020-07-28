import 'package:demoblocprovider/login_with_bloc/login_bloc.dart';
import 'package:demoblocprovider/login_with_bloc/login_event.dart';
import 'package:demoblocprovider/login_with_bloc/login_state.dart';
import 'package:demoblocprovider/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginScreenBloc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreenBloc> {
  final _userNameController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: BlocProvider(
          create: (context) {
            return LoginBloc(const LoginState());
          },
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            if (state.status.isSubmissionInProgress) {
              return AppLoading();
            } else {
              return _buildBody();
            }
          }),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 90,
            height: 90,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
              child: FlutterLogo(),
            ),
          ),
          _buildUserNameField(),
          _buildPasswordField(),
          _buildButtonLogin()
        ],
      ),
    );
  }

  Widget _buildUserNameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          width: double.infinity,
          height: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'User name:',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: TextField(
                    controller: _userNameController,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Input email or phone number',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(60, 60, 60, 0.4),
                      ),
                    ),
                    onChanged: (value) {
                      context.bloc<LoginBloc>().add(UserNameChanged(value));
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          width: double.infinity,
          height: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'Password:',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: TextField(
                    controller: _passController,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Input your password',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(60, 60, 60, 0.4),
                      ),
                    ),
                    onChanged: (value) {
                      context.bloc<LoginBloc>().add(PasswordChanged(value));
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonLogin() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        bool enable = state.username.valid && state.password.valid;
        return Container(
          margin: EdgeInsets.only(top: 30),
          alignment: Alignment.center,
          height: 60,
          width: 240,
          child: RawMaterialButton(
            constraints: BoxConstraints.expand(),
            fillColor: enable ? Colors.blueAccent : Colors.grey,
            onPressed: enable
                ? () {
                    context.bloc<LoginBloc>().add(FormSubmitted());
                  }
                : null,
            child: Text(
              'LOGIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
