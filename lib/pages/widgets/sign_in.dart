import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stalker_app/utils/theme.dart';
import 'package:stalker_app/utils/snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stalker_app/utils/fields_validator.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  String emailFieldText = "";
  String passwordFieldText = "";
  bool _obscureTextPassword = true;
  FieldsValidator fieldsValidator = FieldsValidator();

  // static bool _onSignInButtonPress = false;
  static bool _onSignUpButtonPress = false;

  set onSignUpButtonPress(bool value) {
    _onSignUpButtonPress = value;
  }

  // set onSignInButtonPress(bool value) {
  //   _onSignInButtonPress = value;
  // }

  @override
  void initState() {
    super.initState();
    focusNodeEmail.addListener(_emailFieldFocusState);
    focusNodePassword.addListener(_passwordsFieldFocus);
    loginEmailController.addListener(_fieldLatestValue);
    loginPasswordController.addListener(_fieldLatestValue);
  }

  void _fieldLatestValue() {
    if (loginEmailController.text != "") {
      emailFieldText = loginEmailController.text;
      // if (kDebugMode) print('Email text field: ${emailFieldText}');
    } else if (loginPasswordController.text != "") {
      passwordFieldText = loginPasswordController.text;
      // if (kDebugMode) print('Password text field: ${passwordFieldText}');
    }
  }

  bool _emailFieldFocusState() {
    bool result = focusNodeEmail.hasFocus;
    if (kDebugMode) print("Focus of email field: $result");

    if (!fieldsValidator.validateEmail(emailFieldText) &&
        !result &&
        !_onSignUpButtonPress) {
      CustomSnackBar(context,
          Text(AppLocalizations.of(context)!.emailValidateText), Colors.orange);
    }
    return result;
  }

  bool _passwordsFieldFocus() {
    bool result = focusNodePassword.hasFocus;
    if (kDebugMode) {
      print("Focus of password field: $result");
    }
    if (!fieldsValidator.validatePassword(passwordFieldText) &&
        !result &&
        !_onSignUpButtonPress) {
      CustomSnackBar(
          context,
          Text(AppLocalizations.of(context)!.passwordValidateText),
          Colors.orange);
    }
    return result;
  }

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeEmail,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            // hintText: 'Email Address',
                            hintText: AppLocalizations.of(context)!
                                .hintTextEmailAddress,
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                          ),
                          onSubmitted: (_) {
                            focusNodePassword.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodePassword,
                          controller: loginPasswordController,
                          obscureText: _obscureTextPassword,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText:
                                AppLocalizations.of(context)!.hintTextPassword,
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onSubmitted: (_) {
                            _toggleSignInButton();
                          },
                          textInputAction: TextInputAction.go,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 170.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomTheme.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: CustomTheme.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: <Color>[
                        CustomTheme.loginGradientEnd,
                        CustomTheme.loginGradientStart
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: <double>[0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: CustomTheme.loginGradientEnd,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      // 'LOGIN',
                      AppLocalizations.of(context)!.buttonTextLogIn,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'WorkSansBold'),
                    ),
                  ),
                  onPressed: () => CustomSnackBar(context,
                      const Text('Login button pressed'), Colors.green),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  // 'Forgot Password?',
                  AppLocalizations.of(context)!.textForgotPassword,
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansMedium'),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                //  Далее закомментированны кнопки oneTap authentication Google, Facebook,
                // Container(
                //   decoration: const BoxDecoration(
                //     gradient: LinearGradient(
                //         colors: <Color>[
                //           Colors.white10,
                //           Colors.white,
                //         ],
                //         begin: FractionalOffset(0.0, 0.0),
                //         end: FractionalOffset(1.0, 1.0),
                //         stops: <double>[0.0, 1.0],
                //         tileMode: TileMode.clamp),
                //   ),
                //   width: 100.0,
                //   height: 1.0,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(left: 15.0, right: 15.0),
                //   child: Text(
                //     // 'Or',
                //     AppLocalizations.of(context)!.textOr,
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 16.0,
                //         fontFamily: 'WorkSansMedium'),
                //   ),
                // ),
                // Container(
                //   decoration: const BoxDecoration(
                //     gradient: LinearGradient(
                //         colors: <Color>[
                //           Colors.white,
                //           Colors.white10,
                //         ],
                //         begin: FractionalOffset(0.0, 0.0),
                //         end: FractionalOffset(1.0, 1.0),
                //         stops: <double>[0.0, 1.0],
                //         tileMode: TileMode.clamp),
                //   ),
                //   width: 100.0,
                //   height: 1.0,
                // ),// "// Это
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(top: 10.0, right: 40.0),
          //       child: GestureDetector(
          //         onTap: () => CustomSnackBar(
          //             context, const Text('Facebook button pressed')),
          //         child: Container(
          //           padding: const EdgeInsets.all(15.0),
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.white,
          //           ),
          //           child: const Icon(
          //             FontAwesomeIcons.facebookF,
          //             color: Color(0xFF0084ff),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 10.0),
          //       child: GestureDetector(
          //         onTap: () => CustomSnackBar(
          //             context, const Text('Google button pressed')),
          //         child: Container(
          //           padding: const EdgeInsets.all(15.0),
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.white,
          //           ),
          //           child: const Icon(
          //             FontAwesomeIcons.google,
          //             color: Color(0xFF0084ff),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  void _toggleSignInButton() {
    CustomSnackBar(context, const Text('Login button pressed'), Colors.green);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}
