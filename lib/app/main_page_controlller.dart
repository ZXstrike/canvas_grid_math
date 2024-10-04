import 'dart:math';

import 'package:canvas_grid_math/app/question_model.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class MainPageControlller extends ChangeNotifier {
  double sliderValueY = 1;
  double sliderValueX = 1;
  GlobalKey canvasKey = GlobalKey();

  ConfettiController confettiController = ConfettiController(
    duration: const Duration(seconds: 1),
  );

  List<List<int>> selectedBox = [];

  int healt = 2;

  Question? currentQuestion;

  int streak = 0;

  bool isTrue = false;
  bool isFalse = false;
  bool isAdd = false;

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
    notifyListeners();
  }

  void checkAnswer() {
    var isAnswerCorrect = false;
    if (selectedBox.isNotEmpty) {
      if (currentQuestion!.type == "fraction") {
        isAnswerCorrect = fractionAnswer();
      } else {
        isAnswerCorrect = decimalAnswer();
      }
      isTrue = isAnswerCorrect;
      if (!isAnswerCorrect) {
        healt--;
        isFalse = true;
        notifyListeners();
        Future.delayed(const Duration(milliseconds: 500), () {
          isFalse = false;
          notifyListeners();
        });
        if (healt == 0) {
          Future.delayed(const Duration(milliseconds: 500), () {
            streak = 0;
            selectNextQuestion();
          });
        }
      } else {
        if (streak < 5) {
          streak++;
        }
        if (streak >= 1) {
          confettiController.play();
        }
      }
      notifyListeners();
    }
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

  void getTapPosition(Offset offset) {
    RenderBox renderBox =
        canvasKey.currentContext!.findRenderObject() as RenderBox;

    final renderBoxSize = renderBox.size;

    final localPosition = offset;
    final x = (localPosition.dx / (renderBoxSize.width / sliderValueX.toInt()))
        .floor();
    final y = (localPosition.dy / (renderBoxSize.height / sliderValueY.toInt()))
        .floor();
    isAdd = containtsBox(x, y);
    selectBox(x, y);
    notifyListeners();
  }

  void getDragPosition(Offset offset) {
    RenderBox renderBox =
        canvasKey.currentContext!.findRenderObject() as RenderBox;

    final renderBoxSize = renderBox.size;

    final localPosition = offset;
    final x = (localPosition.dx / (renderBoxSize.width / sliderValueX.toInt()))
        .floor();
    final y = (localPosition.dy / (renderBoxSize.height / sliderValueY.toInt()))
        .floor();
    selectBox(x, y);
    notifyListeners();
  }

  void selectBox(int x, int y) {
    if (x < sliderValueX.toInt() &&
        y < sliderValueY.toInt() &&
        x >= 0 &&
        y >= 0) {
      if (isAdd) {
        if (containtsBox(x, y)) {
          selectedBox
              .removeWhere((element) => element[0] == x && element[1] == y);
        }
      } else {
        if (!containtsBox(x, y)) {
          selectedBox.add([x, y]);
        }
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
