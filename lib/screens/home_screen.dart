import 'package:flutter/material.dart';
import 'package:quizz/screens/reward_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int score = 0;

  Future<void> _saveScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userScore', score);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RewardScreen(),
            ),
          );
        },
        child: Icon(
          Icons.wallet_giftcard_outlined,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Quiz App'),
      ),
      body: _buildQuizBody(),
    );
  }

  Widget _buildQuizBody() {
    return PageView.builder(
      controller: _pageController,
      itemCount: quizQuestions.length,
      itemBuilder: (context, index) {
        return _buildQuestionCard(index);
      },
    );
  }

  Widget _buildQuestionCard(int index) {
    // final size = MediaQuery.of(context).size;
    return Expanded(
      // height: 200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Question ${index + 1}/${quizQuestions.length}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                quizQuestions[index].question,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ..._buildOptions(index),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitAnswer(index),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOptions(int index) {
    final options = quizQuestions[index].options;
    return List.generate(options.length, (optionIndex) {
      return RadioListTile<int>(
        value: optionIndex,
        groupValue: _selectedOptionIndex,
        onChanged: (value) {
          setState(() {
            _selectedOptionIndex = value;
          });
        },
        title: Text(options[optionIndex]),
      );
    });
  }

  int? _selectedOptionIndex;

  void _submitAnswer(int index) async {
    if (_selectedOptionIndex != null) {
      if (_selectedOptionIndex == quizQuestions[index].correctOptionIndex) {
        // Show correct answer animation
        _showAnimation(isCorrect: true);

        setState(() {
          score++;
        });
      } else {
        // Show wrong answer animation
        _showAnimation(isCorrect: false);
      }

      await _saveScore(score);

      if (index + 1 < quizQuestions.length) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // End of quiz, show the final score.
        _showQuizEndDialog();
      }

      setState(() {
        _selectedOptionIndex = null;
      });
    }
  }

  void _showAnimation({required bool isCorrect}) {
    // Add your beautiful animation here, for example:
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? 'Correct Answer!' : 'Wrong Answer!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _showQuizEndDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Ended'),
          content: Text('Your Score: $score/${quizQuestions.length}'),
          actions: [
            TextButton(
              onPressed: () async {
                // Save the score and go back to the first question.
                await _saveScore(score);
                setState(() {
                  score = 0;
                  _pageController.jumpToPage(0);
                });
                Navigator.pop(context);
              },
              child: Text('Restart Quiz'),
            ),
          ],
        );
      },
    );
  }
}
