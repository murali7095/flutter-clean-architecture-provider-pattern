import 'package:flutter/material.dart';
import 'package:m_mart_shopping/features/auth/signUp/presentation/screens/sign_up_user_main.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset("assets/images/shopping.png",
                fit: BoxFit.fitHeight),
          ),
          const GreetingWidget(),
        ],
      ),
    );
  }
}

class GreetingWidget extends StatefulWidget {
  const GreetingWidget({super.key});

  @override
  State<GreetingWidget> createState() => _GreetingWidgetState();
}

class _GreetingWidgetState extends State<GreetingWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const Text(
              "𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝒕𝒐 𝑴𝑴𝒂𝒓𝒕",
              style: TextStyle(color: Colors.black87, fontSize: 28),
            ),
            const Text(
              "𝑺𝒉𝒐𝒑 𝑯𝒆𝒓𝒆",
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 490),
              child: SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpUserMain(),
                            ));
                      },
                      child: const Text("Get Started"))),
            ),
          ],
        ),
      ),
    );
  }
}
