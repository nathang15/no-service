import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_collection/Wordle/constants/answer_stages.dart';
import 'package:game_collection/Wordle/data/keys_map.dart';
import 'package:game_collection/Wordle/models/tile_model.dart';

class Controller extends ChangeNotifier {
  bool checkLine = false, isBackOrEnter = false, gameWon = false;
  String correctWord = "";
  int currentTile = 0;
  int currentRow = 0;
  List<TileModel> tilesEntered = [];
  bool gameCompleted = false;
  bool notEnoughLetters = false;

  setCorrectWord({required String word}) => correctWord = word;

  setKeyTapped({required String value}){

    if(value == 'ENTER'){
      if(currentTile == 5 * (currentRow + 1)){
        isBackOrEnter = true;
        checkWord();
      }

    }
    else if(value == 'BACK'){
      if(currentTile > 5 * (currentRow + 1) - 5){
        isBackOrEnter = true;
        currentTile--;
        tilesEntered.removeLast();
      }
    }

    else{
      if(currentTile < 5 * (currentRow + 1)){
        tilesEntered.add(TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
        isBackOrEnter = false;
      }
    }
    notifyListeners();
  }

  checkWord(){
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";
    for(int i = currentRow * 5; i < (currentRow * 5) + 5; i++){
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if(guessedWord == correctWord) {
      for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
      }
    }
    else{
      for(int i = 0; i < 5; i++){
        if(guessedWord[i] == correctWord[i]){
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 5)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }

      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < 5; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * 5)].letter) {
            if (tilesEntered[j + (currentRow * 5)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * 5)].answerStage =
                  AnswerStage.contains;
            }

            final resultKey = keysMap.entries.where((element) =>
            element.key == tilesEntered[j + (currentRow * 5)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keysMap.update(
                  resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }
    }

    for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      if(tilesEntered[i].answerStage == AnswerStage.notAnswered){
        tilesEntered[i].answerStage = AnswerStage.incorrect;

        final results = keysMap.entries.where((element) => element.key == tilesEntered[i].letter);
        if(results.single.value == AnswerStage.notAnswered){
          keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.incorrect);
        }
      }
    }

    currentRow++;
    checkLine = true;
    if (currentRow == 6) {
      gameCompleted = true;
    }
    notifyListeners();
  }
}
