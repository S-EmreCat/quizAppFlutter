import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/core/constants/padding.dart';
import '../../core/constants/radius.dart';
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
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(RadiusConstants.yirmi),
            ),
            child: const Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/purplebg.jpg'),
            ),
          ),
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
                Center(
                  child: timerWidget(widthPage, heightPage),
                ),
                Center(
                  child: Container(
                    height: heightPage / 3,
                    width: widthPage / 1.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(RadiusConstants.yirmi),
                      ),
                    ),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(RadiusConstants.yirmi),
                        ),
                      ),
                      child: Padding(
                        padding: const PagePaddings.all15(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Question 2/10",
                                style: Theme.of(context).textTheme.subtitle1),
                            Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                "datadatadatadatadatadatadata data data data datada data datada",
                                style: Theme.of(context).textTheme.headline6),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const PagePaddings.all15(),
                    child: Container(
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          testWidget(context),
                          testWidget(context),
                          testWidget(context),
                          testWidget(context),
                        ],
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

  GestureDetector testWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        alignment: Alignment.center,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 3),
              blurRadius: 3,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: const Text(
          "option",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
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
