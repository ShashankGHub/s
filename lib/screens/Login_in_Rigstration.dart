import 'package:flutter/material.dart';
import 'package:rova_23/controllers/auth_controller.dart';
import 'package:rova_23/models/auth_model.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

TextEditingController phoneNumberController = TextEditingController();
TextEditingController clientNameController = TextEditingController();
AuthUserController _authUserController = AuthUserController();
Authmodel _authmodel = Authmodel();

class LoginScreen extends StatelessWidget {
  Future<void> _generateOtp(Authmodel authmodel) async {
    try {
      _authUserController.generateOtp(authmodel);
    } catch (err) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 180.0,
                height: 180.0,
                child: Image.asset(
                  'images/logo.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),

              // "Enter Name" text box
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: clientNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Enter Name',
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Enter Mobile No.',
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _authmodel.name = clientNameController.text;
                    _authmodel.phone = phoneNumberController.text;
                    _generateOtp(_authmodel);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(222, 39, 156, 214),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                  ),
                  child: Text(
                    'Send OTP',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFECEEF0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
