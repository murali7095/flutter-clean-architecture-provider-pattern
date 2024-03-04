import 'package:flutter/material.dart';
import 'package:m_mart_shopping/core/common%20widgets/custom_elevated_button.dart';
import 'package:m_mart_shopping/core/utils.dart';
import 'package:m_mart_shopping/features/auth/signIn/presentation/controller/sign_in_controller.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/controller/sign_up_controller.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/screens/sign_up_user_main.dart';
import 'package:provider/provider.dart';

import '../../../../../core/common widgets/text_form_field_custom_widget.dart';
import '../../../../home page/presentation/home_page_main.dart';
import '../../data/model/sign_in_model.dart';

///SignInUserMain widget responsible for allowing the user to enter their credentials and do validation
///The User will be navigated to home screen with correct credentials
class SignInUserMain extends StatefulWidget {
  const SignInUserMain({Key? key}) : super(key: key);

  @override
  State<SignInUserMain> createState() => _SignInUserMainState();
}

class _SignInUserMainState extends State<SignInUserMain>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var signInModel = SignInModel();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  late AnimationController controller;
  late Animation<double> headingFadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  _focusListener() {
    setState(() {});
  }

  @override
  void initState() {
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
                        padding: const EdgeInsets.only(left: 20, top: 100),
                        height: size.height,
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FadeTransition(
                                opacity: headingFadeAnimation,
                                child: buildSignInTextWidget()),
                            SlideTransition(
                                position: slideAnimation,
                                child: ScaleTransition(
                                    scale: scaleAnimation,
                                    child: textFieldsWithButtonWidget())),
                            const SizedBox(
                              height: 12,
                            ),
                            FadeTransition(
                                opacity: headingFadeAnimation,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Create One?"),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignUpUserMain()));
                                        },
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                              color: Colors.blue.shade800),
                                        )),
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
    if (_formKey.currentState!.validate()) {
      if (emailErrorMessage == null && passwordErrorMessage == null) {
        var provider = Provider.of<SignInController>(context, listen: false);
        await provider.signInUserController(signInModel, context);

        if (provider.isBack) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePageMain()));
        }
      }
    }
  }

  Column textFieldsWithButtonWidget() {
    return Column(
      children: [
        buildCustomTextFormFields(),
        const SizedBox(
          height: 40,
        ),

        ///Sign in Button to submit the user inputs
        Consumer<SignUpController>(builder: (context, controller, _) {
          return CustomElevatesButton(
            onPressed: () {
              onSubmit();
            },
            child: const Text("Log in"),
          );
        }),
      ],
    );
  }

  ///crates text widgets to the user to enter their inputs
  Padding buildCustomTextFormFields() {
    return Padding(
      padding: const EdgeInsets.only(top: 70, right: 20),
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
        '𝙇𝙤𝙜 𝙞𝙣𝙩𝙤\n𝙮𝙤𝙪𝙧 𝙖𝙘𝙘𝙤𝙪𝙣𝙩',
        style: TextStyle(fontSize: 25.0),
      ),
    ),
  );
}
