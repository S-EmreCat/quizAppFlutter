import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/padding.dart';
import '../../core/constants/string.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginViewModel loginProvider =
      Provider.of<LoginViewModel>(context, listen: false);
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LoginViewModel>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage('assets/bg.jpg'),
            ),
          ),
          Center(
            child: Padding(
              padding: const PagePaddings.all15(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),
                  textPlayString(),
                  Text(AppStringConstants.enterYourName),
                  const Spacer(),
                  Consumer(
                    builder: (context, value, child) {
                      return tFieldNickName();
                    },
                  ),
                  const Spacer(),
                  goToQuizPageButton(context),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Text textPlayString() => Text(AppStringConstants.letsPlay,
      maxLines: 1,
      style: Theme.of(context)
          .textTheme
          .headline4!
          .copyWith(color: Colors.white, fontWeight: FontWeight.bold));

  TextField tFieldNickName() {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        hintText: 'Nick Name',
        filled: true,
        fillColor: Color.fromARGB(255, 39, 42, 58),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }

  InkWell goToQuizPageButton(BuildContext context) {
    return InkWell(
      onTap: () {
        loginProvider.getNickName(_controller.text);
        debugPrint(loginProvider.nickName);
        Navigator.pushNamed(context, 'test');
        debugPrint(_controller.text);
      },
      child: Container(
          alignment: Alignment.center,
          padding: const PagePaddings.all15(),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color.fromARGB(255, 41, 25, 73),
                Color.fromARGB(255, 84, 57, 85),
                Color(0xffac255e),
                Color.fromARGB(255, 84, 57, 85),
                Color.fromARGB(255, 41, 25, 73),
              ],
            ),
          ),
          child: Text(AppStringConstants.playButtons)),
    );
  }
}
