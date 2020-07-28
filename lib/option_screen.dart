import 'package:demoblocprovider/login_with_bloc/login_screen.dart';
import 'package:demoblocprovider/login_with_provider/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OptionScreenState();
  }
}

class OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 120,
            height: 50,
            child: RawMaterialButton(
              constraints: BoxConstraints.expand(),
              fillColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreenBloc(),
                  ),
                );
              },
              child: Text(
                'BLOC',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            width: 120,
            height: 50,
            margin: EdgeInsets.only(top: 25),
            child: RawMaterialButton(
              constraints: BoxConstraints.expand(),
              fillColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text(
                'PROVIDER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
