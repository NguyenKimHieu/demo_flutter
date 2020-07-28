import 'package:demoblocprovider/login_with_provider/login_provider.dart';
import 'package:demoblocprovider/widget/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _userNameController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: GestureDetector(
        child: Scaffold(
          body: Consumer<LoginProvider>(
            builder: (context, login, _) {
              if (login.isLoading) {
                return AppLoading();
              } else {
                return _buildBody();
              }
            },
          ),
        ),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      ),
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
    return Consumer<LoginProvider>(
      builder: (context, login, _) {
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
                      Provider.of<LoginProvider>(context, listen: false).setUserName(value);
                      login.validateInput();
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
    return Consumer<LoginProvider>(
      builder: (context, login, _) {
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
                      Provider.of<LoginProvider>(context, listen: false).setPassWord(value);
                      login.validateInput();
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
    return Consumer<LoginProvider>(builder: (context, login, _) {
      bool enable = login.validate ?? false;
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
                  print('Login pressssssss!!!');
                  login.pushLoading();
                  login.resetLoadingState();
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
    });
  }
}
