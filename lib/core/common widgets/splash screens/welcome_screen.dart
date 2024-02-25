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
            child: Image.network(
                "https://images.smiletemplates.com/uploads/screenshots/320/0000320055/powerpoint-template-450w.jpg",
                fit: BoxFit.fitHeight),
          ),
          const GreetingWidget(),
          // Align(child: Text("shop",style: TextStyle(color: Colors.red),),),

          //Align(child: Text("shop"),)
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
        padding: const EdgeInsets.only(top: 400),
        child: Column(
          children: [
            const Text(
              "Welcome to MMart",
              style: TextStyle(color: Colors.redAccent, fontSize: 28),
            ),
            const Text(
              "The Biggest online shopping world",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpUserMain(),
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
