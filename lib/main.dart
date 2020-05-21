import 'package:flutter/material.dart';
import 'package:quiz_app/question.dart';
import 'package:quiz_app/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizView(),
          ),
        ),
      ),
    );
  }
}

class QuizView extends StatefulWidget {
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  int questioNumber = 0;
  List<Icon> icons = [];
  QuizBrain quizBrain = QuizBrain();
  bool correctAnswer;


  void checkAnswer(bool answer){
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if(answer == correctAnswer){
        icons.add(Icon(Icons.check, color: Colors.green,));
      }else {
        icons.add(Icon(Icons.close, color: Colors.red,));
      }

      quizBrain.nextQuestion();
    });

    if(quizBrain.isFinished()){
      Alert(
        context: context,
        type: AlertType.error,
        title: "Quiz App",
        desc: ":( we are sorry quiz is over",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);

              setState(() {
                quizBrain.resetQuestions();
                icons = [];
              });
              },
            width: 120,
          )
        ],
      ).show();
    }

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                '${quizBrain.getQuestionText()}', textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0,),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                "True",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
//                  questioNumber ++;
//                  questioNumber = questioNumber != quizBrain.questionBank.length ? questioNumber ++ : 0;
//                  quizBrain.nextQuestion();
//                  correctAnswer = quizBrain.getQuestionAnswer();
                  checkAnswer(true);

//                  icons.add(Icon(
//                    Icons.check,
//                    color: Colors.green,
//                  ));
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                "False",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
//                questioNumber ++;
//                questioNumber = questioNumber != quizBrain.questionBank.length ? questioNumber ++ : 0;
//                quizBrain.nextQuestion();
//                correctAnswer = quizBrain.getQuestionAnswer();
                checkAnswer(false);
//                setState(() {
//                  icons.add(Icon(
//                    Icons.clear,
//                    color: Colors.red,
//                  ));
//                });
              },
            ),
          ),
        ),
        Row(
          children: icons,
        )
      ],
    );
  }

}
