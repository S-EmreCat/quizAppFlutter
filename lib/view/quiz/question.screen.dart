import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/padding.dart';
import '../../core/constants/radius.dart';
import '../login/login_viewmodel.dart';

import 'question_viewmodel.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  SingingCharacter? character = SingingCharacter.lafayette;

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
      body: Consumer(
        builder: (context, value, child) {
          if (dataProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              bgImageMethod(),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backToLoginScreenIconButton(context),
                    Center(
                      child: timerWidget(
                        widthPage,
                        heightPage,
                        dataProvider.timerDuration,
                        dataProvider.controller,
                      ),
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
                                // Text(
                                //     "Question ${context.read<QuestionProvider>().questionIndex}/10",
                                //     style: Theme.of(context).textTheme.subtitle1),
                                Text(
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    (dataProvider.currentQuestion.toString()),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // TODO: options
                    Expanded(
                      child: Padding(
                        padding: const PagePaddings.all15(),
                        child: Container(
                          color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text("2"),
                              Text("3"),
                              Text("4"),
                              Text("5"),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  IconButton backToLoginScreenIconButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, "login");
      },
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  ClipRRect bgImageMethod() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(RadiusConstants.yirmi),
      ),
      child: const Image(
        fit: BoxFit.cover,
        image: AssetImage('assets/purplebg.jpg'),
      ),
    );
  }

  CircularCountDownTimer timerWidget(double widthPage, double heightPage,
      int duration, CountDownController controller) {
    return CircularCountDownTimer(
      onChange: (String timeStamp) {
        debugPrint('Countdown Changed $timeStamp');
        if (dataProvider.questionIndex < 2 &&
            timeStamp == dataProvider.timerDuration.toString()) {
          // dataProvider.testFun();
          dataProvider.incrementQuestionIndex();
          debugPrint(dataProvider.questionIndex.toString());
          dataProvider.controller.restart();
        }
        // if (dataProvider.questionIndex == 2) {
        //   dataProvider.controller.reset();
        //   // TODO : question option kısmı yapıldıktan sonra yorumdan çıkarılacak > score page

        //   // SchedulerBinding.instance.addPostFrameCallback((_) {
        //   //   Navigator.pushReplacementNamed(context, 'score');
        //   // });
        // }
      },
      controller: controller,
      width: widthPage / 6,
      height: heightPage / 6,
      duration: duration,
      fillColor: Colors.purpleAccent[100]!,
      backgroundColor: Colors.white,
      ringColor: Colors.white,
    );
  }
}
