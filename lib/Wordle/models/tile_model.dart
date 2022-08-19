import 'package:game_collection/Wordle/constants/answer_stages.dart';

class TileModel{
  final String letter;
  AnswerStage answerStage;

  TileModel({required this.letter, required this.answerStage});
}