import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/common%20widgets/custom_elevated_button.dart';
import 'package:m_mart_shopping/core/utils.dart';
import 'package:m_mart_shopping/features/auth/signIn/presentation/controller/sign_in_controller.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/controller/sign_up_controller.dart';
import 'package:m_mart_shopping/features/home%20page/home_page.dart';
import 'package:provider/provider.dart';

import '../../../../../core/common widgets/text_form_field_custom_widget.dart';
import '../../data/model/sign_in_model.dart';

///SignInUserMain widget responsible for allowing the user to enter their credentials and do validation
///The User will be navigated to home screen with correct credentials
class SignInUserMain extends StatefulWidget {
  const SignInUserMain({Key? key}) : super(key: key);

  @override
  State<SignInUserMain> createState() => _SignInUserMainState();
}

class _SignInUserMainState extends State<SignInUserMain> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var signInModel = SignInModel();

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
                body: SingleChildScrollView(
                  child: Container(
                    height: size.height,
                    width: size.width,
                    padding: const EdgeInsets.only(left: 20, top: 150),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildSignInTextWidget(),

                        buildCustomTextFormFields(),
                        const SizedBox(
                          height: 25,
                        ),

                        ///Sign in Button to submit the user inputs
                        Consumer<SignUpController>(
                            builder: (context, controller, _) {
                          return CustomElevatesButton(
                            onPressed: () {
                              onSubmit();
                            },
                            child: const Text("Log in"),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }

  ///onSubmit to do validation
  void onSubmit() async {
    debugPrint("emailErrorMessage : $emailErrorMessage");
    debugPrint("passwordErrorMessage : $passwordErrorMessage");
    if (_formKey.currentState!.validate()) {
      if (emailErrorMessage == null && passwordErrorMessage == null) {
        var provider = Provider.of<SignInController>(context, listen: false);
        await provider.signInUserController(signInModel, context);
        debugPrint('entered inside second if');
        if (provider.isBack) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      }
    }
  }

  ///crates text widgets to the user to enter their inputs
  Padding buildCustomTextFormFields() {
    return Padding(
      padding: const EdgeInsets.only(top: 80, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormFieldCustomWidget(
              hintText: 'Email',
              focusNode: _emailFocusNode,
              onChanged: (value) {
                signInModel.email = value;
                emailController.text = value;
                debugPrint(' signInRequestModel.email : ${signInModel.email}');
              },
              validate: (value) {
                setState(() {
                  emailErrorMessage = validateEmail(value);
                });
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              errorText: emailErrorMessage,
            ),
            TextFormFieldCustomWidget(
              hintText: 'Password',
              focusNode: _passwordFocusNode,
              onChanged: (value) {
                signInModel.password = value;
                passwordController.text = value;
                debugPrint(
                    ' signInRequestModel.email : ${signInModel.password}');
              },
              validate: (value) {
                setState(() {
                  passwordErrorMessage = validatePassword(value);
                });
              },
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              errorText: passwordErrorMessage,
            ),
          ],
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
Align buildSignInTextWidget() {
  return const Align(
    alignment: Alignment.topLeft,
    child: SizedBox(
      height: 96,
      width: 163,
      child: Text(
        'log into\nyour account',
        style: TextStyle(fontSize: 25.0),
      ),
    ),
  );
}
