import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Widgets/common_appbar_view.dart';
import '../Widgets/common_button.dart';
import '../Widgets/common_text_field_view.dart';
import '../Widgets/dynamic_signin_grid.dart';
import '../Widgets/my_widgets.dart';
import '../Widgets/remove_focuse.dart';
import '../Widgets/three_in_out.dart';
import '../api_service/api_service_methods.dart';
import '../model/LoginSettingModel.dart';

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
  String? appId;

  getApiId() {
    try {
      Map<String, dynamic> postData = {
        "view_type": "login",
        "client_id": widget.clientId,
        "response_type": "token",
        "scope": "openid",
        "redirect_uri":
            "https: //nightly-accounts.complyment.com/profile/personal-detail&groups_info=0"
      };
      apiService.postMethodCall(
          api: "https://nightly-accounts-api.complyment.com/authz-srv/authz/generate",
          fun: (map) {
            if (kDebugMode) {
              debugPrint(">>>>>>>>>>>>>>>>>>$map");
            }

            if (map is Map && map['success'] == true && map['data'] != null) {
              isLoading = false;
              errorMessage = null;
              appId = map['data']['id'] ?? "";
              getLoginConfig(appId);
            } else if (map != null && map['error'] != null) {
              isLoading = false;
              errorMessage = map['error']['error_description'] ?? "";
            } else {
              isLoading = false;
              errorMessage = "client with client_id ${widget.clientId}  not found";
            }
            setState(() {});
          },
          json: postData);
    } catch (e) {
      debugPrint(">>>>>>>>>>>>>>>>exception $e");
      isLoading = false;
      errorMessage = "client with client_id ${widget.clientId}  not found";
      setState(() {});
    }
  }

  LoginSettingModel? loginSettingModel;
  // List<LoginProviders>? loginSocialProviders = [];
  List<LoginProviders>? loginClassicalProviders = [];
  List<SignInOption> socialLoginOptions =   [
    // const SignInOption(text: "Google" ,icon:FontAwesomeIcons.google),
    // const SignInOption(text: "Facebook" ,icon:FontAwesomeIcons.facebook),
    // const SignInOption(text: "Twitter" ,icon:FontAwesomeIcons.twitter),
    // const SignInOption(text: "Twitter" ,icon:FontAwesomeIcons.twitter),
    // const SignInOption(text: "Twitter" ,icon:FontAwesomeIcons.twitter),
    // const SignInOption(text: "Twitter" ,icon:FontAwesomeIcons.twitter),
  ];

  List<SignInOption> classicalLoginOptions =   [
    // const SignInOption(text: "Google" ,icon:FontAwesomeIcons.google),
    // const SignInOption(text: "Facebook" ,icon:FontAwesomeIcons.facebook),
    // const SignInOption(text: "Twitter" ,icon:FontAwesomeIcons.twitter),
    // const SignInOption(text: "Twitter" ,icon:FontAwesomeIcons.twitter),
    // const SignInOption(text: "Twitter" ,icon:FontAwesomeIcons.twitter),
    // const SignInOption(text: "Twitter" ,icon:FontAwesomeIcons.twitter),
  ];
  LoginProviders? selectedClassicalProvider;
  int selectedClassicalIndex = 0;


  getLoginConfig(String? appId) {
    // appId = "6ae0f710-73d7-490c-b570-fb0e76623e53";
    try {
      apiService.postMethodCall(
          api:
              "https://nightly-accounts-api.complyment.com/public-srv/login/settings/by/requestid/$appId",
          fun: (map) {
            if (map is Map && map['success'] == true && map['data'] != null) {
              loginSettingModel = LoginSettingModel.fromJson(map as Map<String, dynamic>);
              log(">>>>>data ${loginSettingModel?.toJson()}");
              // loginSocialProviders?.clear();
              socialLoginOptions.clear();
              classicalLoginOptions.clear();
              int i=0;
              loginSettingModel?.data?.loginProviders?.forEach((element) {

                if(element.providerType.toString().toLowerCase() == "social"){
                  // loginSocialProviders?.add(element);
                  socialLoginOptions.add( SignInOption(text: (element.providerDisplayName??"") ,icon:getIcon(element.providerDisplayName??"") ,index: i));
                }
                if(element.providerType.toString().toLowerCase() == "classical"){
                  loginClassicalProviders?.add(element);
                  classicalLoginOptions.add( SignInOption(text: (element.providerDisplayName??"") ,icon:getIcon1(element.providerDisplayName??"") ,index: i));
                }
                i= i+1;
              });

              if(loginClassicalProviders?.length == 1){
                selectedClassicalProvider = loginClassicalProviders?[0];
                selectedClassicalIndex = 0;
              }

              setState(() {});
            } else {
              loginSettingModel = null;
            }
          });
    } catch (e) {
      debugPrint(">>>>>>>>>>>>>>>>exception $e");
    }
  }



  getIcon(String type){
    switch(type){
      case "google":
        return FontAwesomeIcons.google;
      case "facebook":
        return FontAwesomeIcons.facebook;
      case "Twitter":
        return FontAwesomeIcons.twitter;
      case "Linkedin":
        return FontAwesomeIcons.linkedinIn;
      case "login with email":
        return Icons.mail;
      case "login with mobile":
        return FontAwesomeIcons.mobile;
      default:
        return FontAwesomeIcons.sprayCan;
    }
  }

  getIcon1(String type){
    if(type.toString().toLowerCase().contains("email")){
      return Icons.mail;
    }else{
      return FontAwesomeIcons.mobile;
    }
  }



  @override
  void initState() {
    getApiId();
    super.initState();
  }

  Widget getLogInWidget(String? titleText,{bool isEmail = true}){
    return  Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Image(
                image: AssetImage('images/logo.png',
                    package: "skillmineauth"), // Replace with your actual image path
              ),
            ),

            ((loginClassicalProviders?.length ??0)>1)?
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 1,top: 1),
              child: DynamicSignInGrid(
                signInOptions: classicalLoginOptions,
                crossAxisCount: 2,
                childAspectRatio: 3,
                onSignInSelected: (option) {
                  // Handle sign-in selection based on the chosen option
                  debugPrint('Selected: ${option.text}');
                },
              ),
            ):const SizedBox(),
            
            CommonTextFieldView(
              controller: _emailController,
              errorText: _errorEmail,
              titleText: titleText??"Email Id",
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
              hintText: titleText??"Email Id",
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
            const Padding(
              padding:  EdgeInsets.only(left: 6.0,right: 6,bottom: 1),
              child:  Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.0, // Adjust divider thickness
                      color: Colors.grey, // Adjust divider color
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(16.0),
                    child: Text(
                      "or Login with",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1.0, // Adjust divider thickness
                      color: Colors.grey, // Adjust divider color
                    ),
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 4.0,right: 4,bottom: 2,top: 2),
              child: DynamicSignInGrid(
                signInOptions: socialLoginOptions,
                crossAxisCount: 3,
                onSignInSelected: (option) {
                  // Handle sign-in selection based on the chosen option
                  debugPrint('Selected: ${option.text}');
                },
              ),
            )
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RemoveFocuse(
        onClick: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: (isLoading)
            ? const SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Image(
                        image: AssetImage('images/logo.png',
                            package: "skillmineauth"), // Replace with your actual image path
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SpinKitThreeInOut(
                      size: 40.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              )
            : (errorMessage != null && errorMessage != "")
                ? SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Image(
                            image: AssetImage('images/logo.png',
                                package: "skillmineauth"), // Replace with your actual image path
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            errorMessage ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CommonAppbarView(
                        iconData: Icons.arrow_back,
                        titleText: "Login",
                        onBackClick: () {
                          Navigator.pop(context);
                        },
                      ),
                      getLogInWidget("Email Id",isEmail: true)
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
