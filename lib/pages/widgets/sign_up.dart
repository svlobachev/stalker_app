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
  final FocusNode _signupFocusNodeName = FocusNode();
  final FocusNode _signupFocusNodeEmail = FocusNode();
  final FocusNode _signupFocusNodePassword = FocusNode();
  final FocusNode _signupFocusNodeConfirmPassword = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  FieldsValidator fieldsValidator = FieldsValidator();

  final TextEditingController _signupNameController = TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();
  final TextEditingController _signupPasswordController =
      TextEditingController();
  final TextEditingController _signupConfirmPasswordController =
      TextEditingController();

  final _signupFieldsFocus = <String, bool>{};

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
    _signupFocusNodeName.addListener(_fieldsFocusState);
    // signupFocusNodeEmail.addListener(_fieldsFocusState);
    _signupFocusNodePassword.addListener(_fieldsFocusState);
    // signupFocusNodeConfirmPassword.addListener(_fieldsFocusState);

    _signupNameController.addListener(_fieldsLatestValue);
    _signupEmailController.addListener(_fieldsLatestValue);
    _signupPasswordController.addListener(_fieldsLatestValue);
    _signupConfirmPasswordController.addListener(_fieldsLatestValue);
    super.initState();
  }

  void _fieldsFocusState() {
    // containsKey(Object key): возвращает true, если Map содержит ключ key
    // containsValue(Object value): возвращает true, если Map содержит значение value

    _subFieldsFocusState(strKey, signupFocusNode) {
      if (!signupFocusNode &&
          _signupFieldsFocus.containsKey(strKey) &&
          _signupFieldsFocus[strKey] == true) {
        _signupFieldsFocus[strKey] = signupFocusNode;
      } else if (signupFocusNode) {
        _signupFieldsFocus[strKey] = signupFocusNode;
      } else if (!signupFocusNode &&
          _signupFieldsFocus.containsKey(strKey) &&
          _signupFieldsFocus[strKey] == false) {
        _signupFieldsFocus.remove(strKey);
      }
    }

    String strKey = 'signupFocusNodeName';
    var signupFocusNode = _signupFocusNodeName.hasFocus;
    _subFieldsFocusState(strKey, signupFocusNode);

    strKey = 'signupFocusNodeEmail';
    signupFocusNode = _signupFocusNodeEmail.hasFocus;
    _subFieldsFocusState(strKey, signupFocusNode);

    strKey = 'signupFocusNodePassword';
    signupFocusNode = _signupFocusNodePassword.hasFocus;
    _subFieldsFocusState(strKey, signupFocusNode);

    strKey = 'signupFocusNodeConfirmPassword';
    signupFocusNode = _signupFocusNodeConfirmPassword.hasFocus;
    _subFieldsFocusState(strKey, signupFocusNode);

    if (kDebugMode) {
      print(_signupFieldsFocus);
    }
  }

  void _fieldsLatestValue() {
    String result = '';
    if (_signupNameController.text != "") {
      result = _signupNameController.text;
      if (kDebugMode) print('nameFieldText: $result');
    } else if (_signupEmailController.text != "") {
      result = _signupEmailController.text;
      if (kDebugMode) print('emailFieldText: $result');
    } else if (_signupPasswordController.text != "") {
      result = _signupPasswordController.text;
      if (kDebugMode) print('passwordFieldText: $result');
    } else if (_signupConfirmPasswordController.text != "") {
      result = _signupConfirmPasswordController.text;
      if (kDebugMode) {
        print('confirmPasswordFieldText: $result');
      }
    }
  }

  @override
  void dispose() {
    _signupFocusNodePassword.dispose();
    _signupFocusNodeConfirmPassword.dispose();
    _signupFocusNodeEmail.dispose();
    _signupFocusNodeName.dispose();
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
                          focusNode: _signupFocusNodeName,
                          controller: _signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            // hintText: 'Name',
                            hintText:
                                AppLocalizations.of(context)!.hintTextName,
                            hintStyle: const TextStyle(
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
                          focusNode: _signupFocusNodeEmail,
                          controller: _signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            // hintText: 'Email Address',
                            hintText: AppLocalizations.of(context)!
                                .hintTextEmailAddress,
                            hintStyle: const TextStyle(
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
                          focusNode: _signupFocusNodePassword,
                          controller: _signupPasswordController,
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
                          focusNode: _signupFocusNodeConfirmPassword,
                          controller: _signupConfirmPasswordController,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
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
