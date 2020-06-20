import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'dart:async';
//import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quizBrain.dart';

void main() => runApp(Quizzler());

QuizBrain quizBrain = new QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  int score=0;


  void checkAnswer(bool userPickedAnwser) {
    bool correctAns = quizBrain.getAnswerText();
    int y = quizBrain.end();
    setState(() {
      if (userPickedAnwser == correctAns) {
        print("the user got it right");
        score++;
        if (y==1) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        }
      } else {
        print('the user got it wrong');
        if (y==1) {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
      }
      if(y==0){
        Alert(
          context: context,
          type: AlertType.error,
          title: "Quiz completed!",
          desc: "You have reached the end of the quiz. Your score was $score out of 13! Good Game.",
          buttons: [
            DialogButton(
              child: Text(
                "Okay",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: (){

                Navigator.pop(context);
              } ,
              width: 120,
            )
          ],
        ).show();
        quizBrain.reset();
        scoreKeeper=[];
      }
    });
      quizBrain.nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

// /*
// question1: 'You can lead a cow down stairs but not up stairs.', false,
// question2: 'Approximately one quarter of human bones are in the feet.', true,
// question3: 'A slug\'s blood is green.', true,
// */
