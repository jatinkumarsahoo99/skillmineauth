import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skillmineauth/AuthUi/text_styles.dart';
import 'package:skillmineauth/AuthUi/theme.dart';

import '../Widgets/common_appbar_view.dart';
import '../Widgets/common_button.dart';
import '../Widgets/common_text_field_view.dart';
import '../Widgets/remove_focuse.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final VoidCallback onLogInBtnCallBack;
  final Function(Map) onSignUpResponse;
  const RegistrationScreen({super.key,required this.onLogInBtnCallBack,required this.onSignUpResponse});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  String _errorEmail = '';
  TextEditingController _emailController = TextEditingController();
  String _errorPassword = '';
  TextEditingController _passwordController = TextEditingController();
  String _errorFName = '';
  TextEditingController _fnameController = TextEditingController();
  String _errorLName = '';
  TextEditingController _lnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: RemoveFocuse(
          onClick: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _appBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CommonTextFieldView(
                        controller: _fnameController,
                        errorText: _errorFName,
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 24, right: 24),
                        titleText: "First Name",
                        hintText:"Enter First Name",
                        keyboardType: TextInputType.name,
                        onChanged: (String txt) {},
                      ),
                      CommonTextFieldView(
                        controller: _lnameController,
                        errorText: _errorLName,
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 24, right: 24),
                        titleText: "Last Name",
                        hintText:"Enter Last Name",
                        keyboardType: TextInputType.name,
                        onChanged: (String txt) {},
                      ),
                      CommonTextFieldView(
                        controller: _emailController,
                        errorText: _errorEmail,
                        titleText: "Email",
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 16),
                        hintText:"Enter your email",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String txt) {},
                      ),
                      CommonTextFieldView(
                        titleText:"Password",
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 24),
                        hintText:"Enter your password",
                        isObscureText: true,
                        onChanged: (String txt) {},
                        errorText: _errorPassword,
                        controller: _passwordController,
                      ),
                      CommonButton(
                        padding:
                        EdgeInsets.only(left: 24, right: 24, bottom: 8),
                        buttonText: "SignUp",
                        onTap: () {
                          if (_allValidation()){
                            widget.onSignUpResponse({"signUp":"Account Created Successfully"});
                          }
                          // NavigationServices(context).gotoTabScreen();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "By Signing up,you agreed with our terms of\nServices and privacy policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Already have account? Log in",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            onTap: widget.onLogInBtnCallBack,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Login",
                                style: TextStyles(context)
                                    .getRegularStyle()
                                    .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6666FF),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 24,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return CommonAppbarView(
      iconData: Icons.arrow_back,
      titleText:"SignUp",
      onBackClick: () {
        Navigator.pop(context);
      },
    );
  }

  bool _allValidation() {
    bool isValid = true;

    if (_fnameController.text.trim().isEmpty) {
      _errorFName = "first name can not be empty";
      isValid = false;
    } else {
      _errorFName = '';
    }

    if (_lnameController.text.trim().isEmpty) {
      _errorLName = "last name can not be empty";
      isValid = false;
    } else {
      _errorLName = '';
    }

    if (_emailController.text.trim().isEmpty) {
      _errorEmail = "Email can not be empty";
      isValid = false;
    }  else {
      _errorEmail = '';
    }

    if (_passwordController.text.trim().isEmpty) {
      _errorPassword = "password can not be empty";
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
