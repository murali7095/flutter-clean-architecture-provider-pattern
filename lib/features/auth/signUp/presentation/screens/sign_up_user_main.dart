import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/common%20widgets/custom_elevated_button.dart';
import 'package:m_mart_shopping/core/common%20widgets/custom_text_form_field.dart';
import 'package:m_mart_shopping/core/common%20widgets/text_form_field_custom_widget.dart';

import 'package:m_mart_shopping/features/auth/signIn/presentation/screens/sign_in_user_main.dart';
import 'package:m_mart_shopping/features/auth/signUp/data/model/sign_up_model.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/controller/sign_up_controller.dart';
import 'package:m_mart_shopping/features/home%20page/home_page.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils.dart';

///SignUpUserMain widget is responsible for allowing the user to enter details and do validations
///The User will be navigated to home screen after the successful registration
class SignUpUserMain extends StatefulWidget {
  const SignUpUserMain({Key? key}) : super(key: key);

  @override
  State<SignUpUserMain> createState() => _SignUpUserMainState();
}

class _SignUpUserMainState extends State<SignUpUserMain>
    with SingleTickerProviderStateMixin {
  var signUpModel = SignUpModel();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  //final _usernameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  late AnimationController controller;
  late Animation<double> headingFadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  _focusListener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    headingFadeAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    slideAnimation = Tween(
      begin: const Offset(-1, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );

    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    controller.forward();
    _emailFocusNode.addListener(_focusListener);
    _passwordFocusNode.addListener(_focusListener);
    _phoneNumberFocusNode.addListener(_focusListener);
    //_usernameFocusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_focusListener);
    _passwordFocusNode.removeListener(_focusListener);
    _phoneNumberFocusNode.removeListener(_focusListener);
    //_usernameFocusNode.removeListener(_focusListener);
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
                  child: Stack(
                    children: [
                      Container(
                        height: size.height,
                        width: size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.red[600]!.withOpacity(0.5),
                            Colors.blue.withOpacity(0.5),
                          ]),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: 80),
                        height: size.height,
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FadeTransition(
                                opacity: headingFadeAnimation,
                                child: buildSignInTextWidget()),
                            textFieldsWithButtonWidget(),
                            FadeTransition(
                                opacity: headingFadeAnimation,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Already have an account?"),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignInUserMain()));
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.blue.shade800),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
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

  textFieldsWithButtonWidget() {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Column(
          children: [
            buildCustomTextFormFields(),
            const SizedBox(
              height: 30,
            ),

            ///Sign up Button to submit the user inputs
            Consumer<SignUpController>(builder: (context, controller, _) {
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
    );
  }

  ///crates text widgets to the user to enter their inputs
  Padding buildCustomTextFormFields() {
    return Padding(
      padding: const EdgeInsets.only(top: 35, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormFieldCustomWidget(
              hintText: 'Username',
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
                FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
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

///Sign up text widget
Align buildSignInTextWidget() {
  return const Align(
    alignment: Alignment.topLeft,
    child: SizedBox(
      height: 96,
      width: 163,
      child: Text(
        '𝘾𝙧𝙚𝙖𝙩𝙚\n𝙮𝙤𝙪𝙧 𝙖𝙘𝙘𝙤𝙪𝙣𝙩',
        style: TextStyle(fontSize: 25.0),
      ),
    ),
  );
}
