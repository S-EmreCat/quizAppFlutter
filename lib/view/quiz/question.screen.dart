import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/padding.dart';
import '../login/login_viewmodel.dart';

import 'question_viewmodel.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late final QuestionProvider dataProvider =
      Provider.of<QuestionProvider>(context, listen: false);
  late final LoginViewModel loginProvider =
      Provider.of<LoginViewModel>(context, listen: false);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<QuestionProvider>(context, listen: false).fetchAllQuestions();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LoginViewModel>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthPage = MediaQuery.of(context).size.width;
    double heightPage = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Image(
              fit: BoxFit.fill, image: AssetImage('assets/purplebg.jpg')),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "login");
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                ),
                Padding(
                  padding: const PagePaddings.vertical10(),
                  child: Center(
                    child: timerWidget(widthPage, heightPage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Center(
                    child: Container(
                      height: heightPage / 3,
                      width: widthPage / 1.2,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: const Card(
                        child: Text("data"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  CircularCountDownTimer timerWidget(double widthPage, double heightPage) {
    return CircularCountDownTimer(
      width: widthPage / 6,
      height: heightPage / 6,
      duration: dataProvider.timerDuration,
      fillColor: Colors.purpleAccent[100]!,
      backgroundColor: Colors.white,
      ringColor: Colors.white,
    );
  }
}
