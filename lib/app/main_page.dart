import 'dart:math';

import 'package:canvas_grid_math/app/canvas_grid.dart';
import 'package:canvas_grid_math/app/main_page_controlller.dart';
import 'package:canvas_grid_math/app/slider_component/slider_thumb.dart';
import 'package:canvas_grid_math/app/slider_component/slider_track.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MainPageControlller controller;

  @override
  void initState() {
    controller = Provider.of<MainPageControlller>(context, listen: false);
    controller.setQuestionRandom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              children: [],
            ),
            Consumer<MainPageControlller>(
              builder: (context, value, child) => SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: () {
                        if (value.currentQuestion!.type == "fraction") {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${value.currentQuestion!.value1.toInt()}",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: value.isTrue
                                      ? Colors.greenAccent
                                      : Colors.white,
                                ),
                              ),
                              Divider(
                                height: 10,
                                thickness: 2,
                                color: value.isTrue
                                    ? Colors.greenAccent
                                    : Colors.white,
                              ),
                              Center(
                                child: Text(
                                  "${value.currentQuestion!.value2!.toInt()}",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: value.isTrue
                                        ? Colors.greenAccent
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Text(
                            "${value.currentQuestion!.value1}",
                            style: TextStyle(
                              fontSize: 30,
                              color: value.isTrue
                                  ? Colors.greenAccent
                                  : Colors.white,
                            ),
                          );
                        }
                      }(),
                    ),
                    SizedBox(
                      height: screenWidth,
                      width: screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: SfSlider(
                              trackShape: CustomSliderTrack(),
                              thumbShape: CustomSliderThumb(
                                direction: ThumbDirection.up,
                                sliderValue: value.sliderValueX.toInt(),
                              ),
                              value: value.sliderValueX,
                              min: 1,
                              max: 10,
                              onChanged: (value) =>
                                  controller.setSliderValueX(value),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SfSlider.vertical(
                                  trackShape: CustomSliderTrack(),
                                  thumbShape: CustomSliderThumb(
                                      sliderValue: value.sliderValueY.toInt(),
                                      direction: ThumbDirection.left),
                                  value: value.sliderValueY,
                                  min: 1,
                                  max: 10,
                                  onChanged: (value) =>
                                      controller.setSliderValueY(value),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: double.infinity,
                                    child: GestureDetector(
                                      onTapDown: (details) {
                                        controller.getBoxPosition(details);
                                      },
                                      child: CanvasGrid(
                                        key: value.canvasKey,
                                        sliderValueY: value.sliderValueY,
                                        sliderValueX: value.sliderValueX,
                                        selectedBox: value.selectedBox,
                                        selectedColor: value.isTrue
                                            ? Colors.greenAccent
                                            : Colors.cyanAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                SfSlider.vertical(
                                  trackShape: CustomSliderTrack(),
                                  thumbShape: CustomSliderThumb(
                                    sliderValue: value.sliderValueY.toInt(),
                                    direction: ThumbDirection.right,
                                  ),
                                  value: value.sliderValueY,
                                  min: 1,
                                  max: 10,
                                  onChanged: (value) =>
                                      controller.setSliderValueY(value),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: SfSlider(
                              trackShape: CustomSliderTrack(),
                              thumbShape: CustomSliderThumb(
                                direction: ThumbDirection.down,
                                sliderValue: value.sliderValueX.toInt(),
                              ),
                              value: value.sliderValueX,
                              min: 1,
                              max: 10,
                              onChanged: (value) =>
                                  controller.setSliderValueX(value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {
                        if (value.isTrue) {
                          controller.selectNextQuestion();
                        } else {
                          controller.checkAnswer();
                        }
                      },
                      child: Text(
                        value.isTrue ? "Next Question" : "Check Answer",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
