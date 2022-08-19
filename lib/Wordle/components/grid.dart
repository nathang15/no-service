import 'package:flutter/material.dart';
import 'package:game_collection/Wordle/animations/bounce.dart';
import 'package:game_collection/Wordle/animations/dance.dart';
import 'package:game_collection/Wordle/components/tile.dart';
import 'package:game_collection/Wordle/controller.dart';
import 'package:provider/provider.dart';

class Grid extends StatelessWidget {
  const Grid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(36, 20, 36, 20),
      itemCount: 30,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        crossAxisCount: 5,
      ),
      itemBuilder: (context, index){
        return Consumer<Controller>(
          builder: (_, notifier, __) {
            bool animate = false;
            bool animateDance = false;
            int danceDelay = 1600;
            if(index == notifier.currentTile - 1 && !notifier.isBackOrEnter){
              animate = true;
            }
            if(notifier.gameWon) {
              for (int i = notifier.tilesEntered.length - 5; i <
                  notifier.tilesEntered.length; i++) {
                if (index == i) {
                  animateDance = true;
                  danceDelay += 100 * (i - ((notifier.currentRow - 1)*5));
                }
              }
            }
            return Dance(
              delay: danceDelay,
              animate: animateDance,
              child: Bounce(
              animate: animate,
                child: Tile(index: index,)),
            );
          },
        );
      },
    );
  }
}


