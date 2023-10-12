import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:retailtribeadmin/Bottomsheet.dart';

import 'Bottomsheet.dart';

class LoginPage66 extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage66> {
  final _passwordController = TextEditingController();
  String? _githubPassword;



  Future<void> _loadSavedPassword() async {
    final String apiUrl ='https://raw.githubusercontent.com/melmorsy2010/Retailtribebuffet/main/66buffetcontact.json';
    final response = await http.get(Uri.parse(apiUrl));


    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        _githubPassword = data['password'];
        print("${_githubPassword}sss");

        _passwordController.text = "" '';
      });
    }
  }

  void _onSubmit() {
    final enteredPassword = _passwordController.text.trim();
    if (enteredPassword == _githubPassword) {
      print("${_githubPassword}sss");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyBottomNavigationBar3()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Incorrect password'),
          content: Text('Please enter the correct password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('66 buffet'),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _onSubmit,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

