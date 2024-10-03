import 'dart:math';

import 'package:canvas_grid_math/app/question_model.dart';
import 'package:flutter/material.dart';

class MainPageControlller extends ChangeNotifier {
  double sliderValueY = 1;
  double sliderValueX = 1;
  GlobalKey canvasKey = GlobalKey();
  List<List<int>> selectedBox = [];

  int healt = 2;

  Question? currentQuestion;

  bool isTrue = false;

  List<Question> questions = [
    Question(value1: 10, value2: 100, type: "fraction"),
    Question(value1: 5, value2: 10, type: "fraction"),
    Question(value1: 5, value2: 40, type: "fraction"),
    Question(value1: 8, value2: 24, type: "fraction"),
    Question(value1: 3, value2: 9, type: "fraction"),
    Question(value1: 4, value2: 8, type: "fraction"),
    Question(value1: 6, value2: 12, type: "fraction"),
    Question(value1: 7, value2: 14, type: "fraction"),
    Question(value1: 9, value2: 18, type: "fraction"),
    Question(value1: 0.8, type: "decimal"),
    Question(value1: 0.5, type: "decimal"),
    Question(value1: 0.5, type: "decimal"),
    Question(value1: 0.8, type: "decimal"),
    Question(value1: 0.3, type: "decimal"),
    Question(value1: 0.4, type: "decimal"),
  ];

  void setQuestionRandom() {
    currentQuestion = questions[Random().nextInt(questions.length)];
  }

  void checkAnswer() {
    var isAnswerCorrect = false;
    if (currentQuestion!.type == "fraction") {
      isAnswerCorrect = fractionAnswer();
    } else {
      isAnswerCorrect = decimalAnswer();
    }
    isTrue = isAnswerCorrect;
    if (!isAnswerCorrect) {
      healt--;
      if (healt == 0) {
        selectNextQuestion();
      }
    }
    notifyListeners();
  }

  bool fractionAnswer() {
    if (currentQuestion!.value1 == selectedBox.length &&
        currentQuestion!.value2 ==
            sliderValueX.toInt() * sliderValueY.toInt()) {
      return true;
    }
    return false;
  }

  bool decimalAnswer() {
    if (currentQuestion!.value1 ==
        (selectedBox.length / (sliderValueX.toInt() * sliderValueY.toInt()))) {
      return true;
    }
    return false;
  }

  void getBoxPosition(TapDownDetails details) {
    RenderBox renderBox =
        canvasKey.currentContext!.findRenderObject() as RenderBox;

    final renderBoxSize = renderBox.size;

    final localPosition = details.localPosition;
    final x = (localPosition.dx / (renderBoxSize.width / sliderValueX.toInt()))
        .floor();
    final y = (localPosition.dy / (renderBoxSize.height / sliderValueY.toInt()))
        .floor();
    selectBox(x, y);
    notifyListeners();
  }

  void selectBox(int x, int y) {
    if (x <= sliderValueX && y <= sliderValueY) {
      if (containtsBox(x, y)) {
        selectedBox
            .removeWhere((element) => element[0] == x && element[1] == y);
      } else {
        selectedBox.add([x, y]);
      }
    }
    notifyListeners();
  }

  bool containtsBox(int x, int y) {
    for (var box in selectedBox) {
      if (box[0] == x && box[1] == y) {
        return true;
      }
    }
    return false;
  }

  void selectNextQuestion() {
    healt = 2;
    isTrue = false;
    currentQuestion = questions[Random().nextInt(questions.length)];
    sliderValueX = 1;
    sliderValueY = 1;
    selectedBox.clear();
    notifyListeners();
  }

  void setSliderValueY(double value) {
    sliderValueY = value;
    selectedBox.clear();
    notifyListeners();
  }

  void setSliderValueX(double value) {
    sliderValueX = value;
    selectedBox.clear();
    notifyListeners();
  }
}
