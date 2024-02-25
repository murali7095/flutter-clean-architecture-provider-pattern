import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/common%20widgets/custom_elevated_button.dart';
import 'package:m_mart_shopping/core/common%20widgets/custom_text_form_field.dart';
import 'package:m_mart_shopping/core/common%20widgets/text_form_field_custom_widget.dart';

import 'package:m_mart_shopping/features/auth/signIn/presentation/screens/sign_in_user_main.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/model/sign_up_model.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/controller/sign_up_controller.dart';
import 'package:m_mart_shopping/features/home%20page/home_page.dart';
import 'package:provider/provider.dart';

///SignUpUserMain widget is responsible for allowing the user to enter details and do validations
///The User will be navigated to home screen after the successful registration
class SignUpUserMain extends StatefulWidget {
  const SignUpUserMain({Key? key}) : super(key: key);

  @override
  State<SignUpUserMain> createState() => _SignUpUserMainState();
}

class _SignUpUserMainState extends State<SignUpUserMain> {
  var signUpModel = SignUpModel();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();

  _focusListener() {
    setState(() {});
  }

  @override
  void initState() {
    _emailFocusNode.addListener(_focusListener);
    _passwordFocusNode.addListener(_focusListener);
    _phoneNumberFocusNode.addListener(_focusListener);
    _usernameFocusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_focusListener);
    _passwordFocusNode.removeListener(_focusListener);
    _phoneNumberFocusNode.removeListener(_focusListener);
    _usernameFocusNode.removeListener(_focusListener);
    passwordController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  String? emailErrorMessage;
  String? passwordErrorMessage;
  String? usernameErrorMessage;
  String? phoneNumberErrorMessage;
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
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, top: 100),
                    height: size.height,
                    width: size.width,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildSignInTextWidget(),
                        buildCustomTextFormFields(),
                        const SizedBox(
                          height: 25,
                        ),

                        ///Sign up Button to submit the user inputs
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
      if (emailErrorMessage == null &&
          passwordErrorMessage == null &&
          usernameErrorMessage == null &&
          phoneNumberErrorMessage == null) {
        var provider = Provider.of<SignUpController>(context, listen: false);
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
  Padding buildCustomTextFormFields() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormFieldCustomWidget(
              hintText: 'username',
              focusNode: _usernameFocusNode,
              onChanged: (value) {
                signUpModel.username = value;
                userNameController.text = value;
              },
              validate: (value) {
                setState(() {
                  usernameErrorMessage = validateUsername(value);
                });
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_emailFocusNode);
              },
              errorText: usernameErrorMessage,
            ),
            TextFormFieldCustomWidget(
              hintText: 'Email',
              focusNode: _emailFocusNode,
              onChanged: (value) {
                signUpModel.email = value;
                emailController.text = value;
                debugPrint(' signInRequestModel.email : ${signUpModel.email}');
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
                signUpModel.password = value;
                passwordController.text = value;
                debugPrint(
                    ' signInRequestModel.email : ${signUpModel.password}');
              },
              validate: (value) {
                setState(() {
                  passwordErrorMessage = validatePassword(value);
                });
              },
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              errorText: passwordErrorMessage,
            ),
            TextFormFieldCustomWidget(
              hintText: 'Phone number',
              focusNode: _phoneNumberFocusNode,
              onChanged: (value) {
                signUpModel.phoneNumber = value;
                phoneNumberController.text = value;
              },
              validate: (value) {
                setState(() {
                  phoneNumberErrorMessage = validatePhoneNumber(value);
                });
              },
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              errorText: phoneNumberErrorMessage,
            ),
            /*CustomTextFormField(
              focusNode: _emailFocusNode,
              autoFocus: false,
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
            ),*/
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
        'Create\nyour account',
        style: TextStyle(fontSize: 25.0),
      ),
    ),
  );
}
