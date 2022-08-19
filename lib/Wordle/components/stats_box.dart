import 'package:flutter/material.dart';
import 'package:game_collection/Wordle/constants/answer_stages.dart';
import 'package:game_collection/Wordle/data/keys_map.dart';
import 'package:game_collection/Wordle/wordle.dart';
import 'package:game_collection/homepage.dart';

class StatsBox extends StatelessWidget {
  const StatsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AlertDialog(
        insetPadding: EdgeInsets.fromLTRB(size.width * 0.08, size.height * 0.12,
            size.width * 0.08, size.height * 0.12),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
                alignment: Alignment.centerRight,
                onPressed: () {
                  Navigator.maybePop(context);
                },
                icon: const Icon(Icons.clear)),
            Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade500,
                      ),
                      onPressed: () {
                        keysMap.updateAll(
                                (key, value) => value = AnswerStage.notAnswered);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) =>  HomePage()),
                                (route) => false);
                      },
                      child: const Text(
                        'Again?',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}