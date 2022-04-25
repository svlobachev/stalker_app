import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stalker_app/utils/theme.dart';
import 'package:stalker_app/utils/snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stalker_app/utils/fields_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final FocusNode signupFocusNodeName = FocusNode();
  final FocusNode signupFocusNodeEmail = FocusNode();
  final FocusNode signupFocusNodePassword = FocusNode();
  final FocusNode signupFocusNodeConfirmPassword = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  FieldsValidator fieldsValidator = FieldsValidator();

  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();

  var signupFieldsFocus = <String, bool>{};

  static bool _onSignInButtonPress = false;
  static bool _onSignUpButtonPress = false;

  set onSignUpButtonPress(bool value) {
    _onSignUpButtonPress = value;
  }

  set onSignInButtonPress(bool value) {
    _onSignInButtonPress = value;
  }

  @override
  void initState() {
    signupFocusNodeName.addListener(_fieldsFocusState);
    // signupFocusNodeEmail.addListener(_fieldsFocusState);
    signupFocusNodePassword.addListener(_fieldsFocusState);
    // signupFocusNodeConfirmPassword.addListener(_fieldsFocusState);

    signupNameController.addListener(_fieldsLatestValue);
    signupEmailController.addListener(_fieldsLatestValue);
    signupPasswordController.addListener(_fieldsLatestValue);
    signupConfirmPasswordController.addListener(_fieldsLatestValue);
    super.initState();
  }

  void _fieldsFocusState() {
    // containsKey(Object key): возвращает true, если Map содержит ключ key
    // containsValue(Object value): возвращает true, если Map содержит значение value

    _subFieldsFocusState(strKey, signupFocusNode) {
      if (!signupFocusNode &&
          signupFieldsFocus.containsKey(strKey) &&
          signupFieldsFocus[strKey] == true) {
        signupFieldsFocus[strKey] = signupFocusNode;
      } else if (signupFocusNode) {
        signupFieldsFocus[strKey] = signupFocusNode;
      } else if (!signupFocusNode &&
          signupFieldsFocus.containsKey(strKey) &&
          signupFieldsFocus[strKey] == false) {
        signupFieldsFocus.remove(strKey);
      }
    }

    String strKey = 'signupFocusNodeName';
    var signupFocusNode = signupFocusNodeName.hasFocus;
    _subFieldsFocusState(strKey, signupFocusNode);

    strKey = 'signupFocusNodeEmail';
    signupFocusNode = signupFocusNodeEmail.hasFocus;
    _subFieldsFocusState(strKey, signupFocusNode);

    strKey = 'signupFocusNodePassword';
    signupFocusNode = signupFocusNodePassword.hasFocus;
    _subFieldsFocusState(strKey, signupFocusNode);

    strKey = 'signupFocusNodeConfirmPassword';
    signupFocusNode = signupFocusNodeConfirmPassword.hasFocus;
    _subFieldsFocusState(strKey, signupFocusNode);

    if (kDebugMode) {
      print(signupFieldsFocus);
    }
  }

  void _fieldsLatestValue() {
    String result = '';
    if (signupNameController.text != "") {
      result = signupNameController.text;
      if (kDebugMode) print('nameFieldText: $result');
    } else if (signupEmailController.text != "") {
      result = signupEmailController.text;
      if (kDebugMode) print('emailFieldText: $result');
    } else if (signupPasswordController.text != "") {
      result = signupPasswordController.text;
      if (kDebugMode) print('passwordFieldText: $result');
    } else if (signupConfirmPasswordController.text != "") {
      result = signupConfirmPasswordController.text;
      if (kDebugMode) {
        print('confirmPasswordFieldText: $result');
      }
    }
  }

  @override
  void dispose() {
    signupFocusNodePassword.dispose();
    signupFocusNodeConfirmPassword.dispose();
    signupFocusNodeEmail.dispose();
    signupFocusNodeName.dispose();
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
                  height: 360.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: signupFocusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            // hintText: 'Name',
                            hintText:
                                AppLocalizations.of(context)!.hintTextName,
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                          ),
                          onSubmitted: (_) {
                            // signupFocusNodeEmail.requestFocus();
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
                          focusNode: signupFocusNodeEmail,
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            // hintText: 'Email Address',
                            hintText: AppLocalizations.of(context)!
                                .hintTextEmailAddress,
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                          ),
                          onSubmitted: (_) {
                            // signupFocusNodePassword.requestFocus();
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
                          focusNode: signupFocusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextPassword,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            // hintText: 'Password',
                            hintText:
                                AppLocalizations.of(context)!.hintTextPassword,
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
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
                            // signupFocusNodeConfirmPassword.requestFocus();
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
                          focusNode: signupFocusNodeConfirmPassword,
                          controller: signupConfirmPasswordController,
                          obscureText: _obscureTextConfirmPassword,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            // hintText: 'Confirmation',
                            hintText: AppLocalizations.of(context)!
                                .hintTextConfirmation,
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignupConfirm,
                              child: Icon(
                                _obscureTextConfirmPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onSubmitted: (_) {
                            _toggleSignUpButton();
                          },
                          textInputAction: TextInputAction.go,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 340.0),
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
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      // 'SIGN UP',
                      AppLocalizations.of(context)!.buttonTextSingUp,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'WorkSansBold'),
                    ),
                  ),
                  onPressed: () => _toggleSignUpButton(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _toggleSignUpButton() {
    CustomSnackBar(context, const Text('SignUp button pressed'), Colors.green);
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }
}
