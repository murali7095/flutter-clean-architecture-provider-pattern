import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/common%20widgets/custom_elevated_button.dart';
import 'package:m_mart_shopping/core/common%20widgets/custom_text_form_field.dart';
import 'package:m_mart_shopping/features/auth/signIn/domain/sign_in_request_model.dart';
import 'package:m_mart_shopping/features/auth/signIn/presentation/controller/sign_in_controller.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/controller/sign_up_controller.dart';
import 'package:m_mart_shopping/features/home%20page/home_page.dart';
import 'package:provider/provider.dart';

///SignInUserMain widget responsible for allowing the user to enter their credentials and do validation
///The User will be navigated to home screen with correct credentials
class SignInUserMain extends StatefulWidget {
  const SignInUserMain({Key? key}) : super(key: key);

  @override
  State<SignInUserMain> createState() => _SignInUserMainState();
}

class _SignInUserMainState extends State<SignInUserMain> {
  var signInRequestModel = SignInRequestModel();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  _focusListener() {
    setState(() {});
  }

  @override
  void initState() {
    _emailFocusNode.addListener(_focusListener);
    _passwordFocusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_focusListener);
    _passwordFocusNode.removeListener(_focusListener);
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? emailErrorMessage;
  String? passwordErrorMessage;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<SignInController>(builder: (context, data, _) {
      ///show loader when the api validation is in progress
      return data.isLoading
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          :

          ///onTap GestureDetector will close the keyboard
          GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                body: Stack(
                  children: [
                    gradientContainer(),
                    SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildSignInTextWidget(),
                          buildCustomTextFormFields(),

                          ///Sign in Button to submit the user inputs
                          Consumer<SignUpController>(
                              builder: (context, controller, _) {
                            return CustomElevatesButton(
                              onPressed: () {
                                onSubmit();
                              },
                              child: const Text("Sign Up"),
                            );
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
    });
  }

  ///onSubmit to do validation
  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (emailErrorMessage == '' && passwordErrorMessage == '') {
        var provider = Provider.of<SignInController>(context, listen: false);
        await provider.signInUserController(signInRequestModel, context);
        debugPrint('entered inside second if');
        if (provider.isBack) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      }
    }
  }

  ///crates text widgets to the user to enter their inputs
  Container buildCustomTextFormFields() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomTextFormField(
                    focusNode: _emailFocusNode,
                    autoFocus: true,
                    controller: emailController,
                    errorText: emailErrorMessage ?? '',
                    onChanged: (value) {
                      signInRequestModel.email = value;
                      emailController.text = value;
                      debugPrint(
                          ' signInRequestModel.email : ${signInRequestModel.email}');
                    },
                    validate: (value) {
                      setState(() {
                        emailErrorMessage = validateEmail(value) ?? '';
                      });
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    hintText: 'email',
                    labelText: 'email',
                    iconData: Icons.email,
                  ),
                  CustomTextFormField(
                    focusNode: _passwordFocusNode,
                    autoFocus: false,
                    errorText: passwordErrorMessage ?? '',
                    controller: passwordController,
                    onChanged: (value) {
                      signInRequestModel.password = value;
                      passwordController.text = value;
                      debugPrint(
                          ' signInRequestModel.password : ${signInRequestModel.password}');
                    },
                    validate: (value) {
                      setState(() {
                        passwordErrorMessage = validatePassword(value) ?? '';
                        debugPrint(
                            ' passwordErrorMessage : $passwordErrorMessage');
                      });
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    hintText: 'password',
                    labelText: 'password',
                    iconData: Icons.lock_open_rounded,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///Creates gradients with colors
Container gradientContainer() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.blue, Colors.red],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft),
    ),
  );
}

///Sign in text widget
Flexible buildSignInTextWidget() {
  return Flexible(
    child: Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(8.0),
      child: const Text(
        'Sign in',
        style: TextStyle(fontSize: 30.0),
      ),
    ),
  );
}

String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter email';
  } else {
    if (!value.contains('@')) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Please enter Password';
  } else {
    if (value.length < 5) {
      return 'Enter at least 5 chars';
    } else {
      return null;
    }
  }
}

String? validateUsername(String value) {
  if (value.isEmpty) {
    return 'Please enter username';
  } else {
    if (value.length < 5) {
      return 'Enter at least 3 chars';
    } else {
      return null;
    }
  }
}

String? validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return 'Please enter phone number';
  } else {
    if (value.length != 10) {
      return 'Enter 10 digit mobile number';
    } else {
      return null;
    }
  }
}
