import 'package:flutter/material.dart';
import '../Widgets/common_appbar_view.dart';
import '../Widgets/common_button.dart';
import '../Widgets/common_text_field_view.dart';
import '../Widgets/my_widgets.dart';
import '../Widgets/remove_focuse.dart';

class LoginScreen extends StatefulWidget {
  final Function(Map) onLoginResult;
   const LoginScreen({super.key,required this.onLoginResult});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  String _errorEmail = '';
  final TextEditingController _emailController = TextEditingController();
  String _errorPassword = '';
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.arrow_back,
              titleText: "Login",
              onBackClick: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Login With Email",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    CommonTextFieldView(
                      controller: _emailController,
                      errorText: _errorEmail,
                      titleText: "Email",
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      hintText:
                      "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String txt) {},
                    ),
                    CommonTextFieldView(
                      titleText: "Password",
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      hintText: "Enter your password",
                      isObscureText: true,
                      onChanged: (String txt) {},
                      errorText: _errorPassword,
                      controller: _passwordController,
                    ),
                    // _forgotYourPasswordUI(),
                    CommonButton(
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                      buttonText: "Login",
                      onTap: () {
                        MyWidget.showLoading(context);
                        if (_allValidation()){
                          widget.onLoginResult({"login":"Login Successfully"});
                        }
                        // NavigationServices(context).gotoTabScreen();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  bool _allValidation() {
    bool isValid = true;
    if (_emailController.text.trim().isEmpty) {
      _errorEmail = "Please enter your email";
      isValid = false;
    }  else {
      _errorEmail = '';
    }

    if (_passwordController.text.trim().isEmpty) {
      _errorPassword = "Please enter your password";
      isValid = false;
    } else if (_passwordController.text.trim().length < 6) {
      _errorPassword = "Please enter valid password";
      isValid = false;
    } else {
      _errorPassword = '';
    }
    setState(() {});
    return isValid;
  }



}
