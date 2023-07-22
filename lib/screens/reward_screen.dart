import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizz/commons/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardScreen extends ConsumerStatefulWidget {
  const RewardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RewardScreenState();
}

class _RewardScreenState extends ConsumerState<RewardScreen> {
  Future<int> _getScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userScore = prefs.getInt('userScore');
    return userScore ??
        0; // Return 0 if the score is not found in SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 10,
        title: CustomText(shadow: [
          Shadow(
            blurRadius: 50,
            color: Colors.blue,
          )
        ], text: 'Reward Screen', fontSize: 20),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wallet_giftcard,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Your Points',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FutureBuilder<int>(
              future: _getScore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    '${snapshot.data}',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
