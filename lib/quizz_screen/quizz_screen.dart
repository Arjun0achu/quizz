

import 'package:flutter/material.dart';
import 'package:linear_timer/linear_timer.dart';

import 'package:quizz/rating_screen/rating_screen.dart';

class HomeScreen extends StatefulWidget {
  final dynamic datashare;
  HomeScreen({super.key, required this.datashare});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int questionIndex = 0;
  int? selectedAnswerIndex;
  int totalScore = 0;

  void goToNextQuestion() {
    if (questionIndex < widget.datashare.length - 1) {
      setState(() {
        questionIndex++;
        selectedAnswerIndex = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RatingScreen(
            answercount: totalScore,
            questionrating: widget.datashare,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.datashare[questionIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Quiz App"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${questionIndex + 1}/${widget.datashare.length}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearTimer(
            key: ValueKey(questionIndex),
            duration: Duration(seconds: 10),
            onTimerEnd: () {
              if (selectedAnswerIndex == null) {
                goToNextQuestion();
              }
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                currentQuestion['question'],
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
             
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: List.generate(
              currentQuestion['options'].length,
              (index) => InkWell(
                onTap: selectedAnswerIndex == null
                    ? () {
                        selectedAnswerIndex = index;
                        if (currentQuestion['answer'] == index) {
                          totalScore++;
                        }
                        setState(() {});
                      }
                    : null,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
            color: selectedAnswerIndex == index
                ? (index == currentQuestion['answer']
                    ? Colors.green 
                    : Colors.red) 
                : (index == currentQuestion['answer'] &&
                        selectedAnswerIndex != null
                    ? Colors.green 
                    
                    : Colors.white), 
            width: 2,
          ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentQuestion['options'][index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        selectedAnswerIndex == index &&
                                index == currentQuestion['answer']
                            ? Icons.check
                            : Icons.circle_outlined,
                        color: selectedAnswerIndex == index
                            ? Colors.green
                            : Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
           SizedBox(height: 20),
         if (selectedAnswerIndex != null)
  Container(
    width: double.infinity,
    height: 40,
    margin: const EdgeInsets.symmetric(horizontal: 20), // Optional margin
    decoration: BoxDecoration(
      color: Colors.blue, // Button background color
      borderRadius: BorderRadius.circular(8), // Rounded corners
    ),
    child: InkWell(
      onTap: goToNextQuestion, // Trigger the `goToNextQuestion` function on tap
      child: Center(
        child: Text(
          "Next",
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
