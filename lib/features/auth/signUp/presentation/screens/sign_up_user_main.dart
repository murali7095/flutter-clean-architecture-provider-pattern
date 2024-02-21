import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/common%20widgets/custom_elevated_button.dart';
import 'package:m_mart_shopping/core/common%20widgets/custom_text_form_field.dart';

import 'package:m_mart_shopping/features/auth/signIn/presentation/screens/sign_in_user_main.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/model/sign_up_model.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/controller/sign_up_controller.dart';
import 'package:m_mart_shopping/features/home%20page/home_page.dart';
import 'package:provider/provider.dart';

///SignInUserMain widget responsible for allowing the user to enter their credentials and do validation
///The User will be navigated to home screen with correct credentials
class SignUpUserMain extends StatefulWidget {
  const SignUpUserMain({Key? key}) : super(key: key);

  @override
  State<SignUpUserMain> createState() => _SignUpUserMainState();
}

class _SignUpUserMainState extends State<SignUpUserMain> {
  var signUpModel = SignUpModel();
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

    return Consumer<SignUpController>(builder: (context, data, _) {
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
        var provider = Provider.of<SignUpController>(context, listen: false);
        SignUpController().signUpUserController(
            SignUpModel(
                email: "reddy162@gmail.com",
                password: "murali12354",
                returnSecureToken: true),
            context);

        await provider.signUpUserController(signUpModel, context);
        debugPrint('entered inside second if');
        if (provider.isBack) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
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
                      signUpModel.email = value;
                      emailController.text = value;
                      debugPrint(
                          ' signInRequestModel.email : ${signUpModel.email}');
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
                      signUpModel.password = value;
                      passwordController.text = value;
                      debugPrint(
                          ' signInRequestModel.password : ${signUpModel.password}');
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
        'Sign Up',
        style: TextStyle(fontSize: 30.0),
      ),
    ),
  );
}
