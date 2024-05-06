import 'package:flutter/material.dart';
import '../Widgets/common_appbar_view.dart';
import '../Widgets/common_button.dart';
import '../Widgets/common_text_field_view.dart';
import '../Widgets/my_widgets.dart';
import '../Widgets/remove_focuse.dart';
import '../Widgets/three_in_out.dart';
import '../api_service/api_service_methods.dart';

class LoginScreen extends StatefulWidget {
  final Function(Map) onLoginResult;
  final String clientId;
  const LoginScreen({super.key, required this.onLoginResult, required this.clientId});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _errorEmail = '';
  final TextEditingController _emailController = TextEditingController();
  String _errorPassword = '';
  final TextEditingController _passwordController = TextEditingController();
  ApiService apiService = ApiService();
  bool isLoading = true;
  String? errorMessage;

  getApiId() {
    try {
      Map<String, dynamic> postData = {
        "view_type": "login",
        "client_id": "05c3ba54-d186-4ee4-8001-b97242143cc2",
        "response_type": "token",
        "scope": "openid",
        "redirect_uri":
            "https: //nightly-accounts.complyment.com/profile/personal-detail&groups_info=0"
      };
      apiService.postMethodCall(
          api: "https://nightly-accounts-api.complyment.com/authz-srv/authz/generate",
          fun: (map) {
            isLoading = false;
            errorMessage = "client with client_id 05c3ba54-d186-4ee4-8001-b97242143cc27  not found";
            setState(() {

            });

          },
          json: postData);
    } catch (e) {
      debugPrint(">>>>>>>>>>>>>>>>exception $e");
    }
  }

  @override
  void initState() {
    getApiId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: (isLoading)?Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height:size.height*0.1,
              width: size.width*0.2,
              child:  SpinKitThreeInOut(
                size: 50.0,
                color: Colors.blue,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              ),
            ),

          ],
        ):(errorMessage != null && errorMessage !="")?Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                errorMessage??"",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),

          ],
        ): Column(
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
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                      hintText: "Enter your email",
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
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Don't have account yet? SignUp",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    CommonButton(
                      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                      buttonText: "Login",
                      onTap: () {
                        MyWidget.showLoading(context);
                        if (_allValidation()) {
                          widget.onLoginResult({"login": "Login Successfully"});
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
    } else {
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
