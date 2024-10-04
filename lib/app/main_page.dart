import 'package:canvas_grid_math/app/canvas_grid.dart';
import 'package:canvas_grid_math/app/main_page_controlller.dart';
import 'package:canvas_grid_math/app/slider_component/slider_thumb.dart';
import 'package:canvas_grid_math/app/slider_component/slider_track.dart';
import 'package:confetti/confetti.dart';
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
  late final ConfettiController confettiController;

  @override
  void initState() {
    controller = Provider.of<MainPageControlller>(context, listen: false);
    controller.setQuestionRandom();
    confettiController = controller.confettiController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        body: Stack(
          children: [
            Consumer<MainPageControlller>(
              builder: (context, value, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.greenAccent,
                              Colors.cyanAccent,
                              Colors.blueAccent,
                              Colors.purpleAccent,
                              Colors.redAccent,
                              Colors.orangeAccent,
                              Colors.yellowAccent,
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: screenWidth - ((screenWidth / 5) * value.streak),
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.grey[900],
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.keyboard_arrow_up_rounded,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: IconButton(
                            onPressed: () {
                              controller.setQuestionRandom();
                            },
                            icon: const Icon(
                              Icons.refresh_sharp,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                value.healt == 2
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                size: 45,
                                color: value.healt < 2
                                    ? Colors.red
                                    : Colors.greenAccent,
                              ),
                              Icon(
                                value.healt >= 1
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                size: 45,
                                color: value.healt < 1
                                    ? Colors.red
                                    : Colors.greenAccent,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        SizedBox(
                          width: 60,
                          child: IconButton(
                            onPressed: () {
                              if (value.isTrue) controller.selectNextQuestion();
                            },
                            icon: Icon(
                              Icons.chevron_right_rounded,
                              size: 50,
                              color: value.isTrue
                                  ? Colors.greenAccent
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: () {
                          if (value.currentQuestion!.type == "fraction") {
                            return SizedBox(
                              width: 100,
                              height: 150,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${value.currentQuestion!.value1.toInt()}",
                                    style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w100,
                                      color: value.isTrue
                                          ? Colors.greenAccent
                                          : Colors.white,
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 2,
                                    color: value.isTrue
                                        ? Colors.greenAccent
                                        : Colors.white,
                                  ),
                                  Center(
                                    child: Text(
                                      "${value.currentQuestion!.value2!.toInt()}",
                                      style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.w100,
                                        color: value.isTrue
                                            ? Colors.greenAccent
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 150,
                              child: Text(
                                "${value.currentQuestion!.value1}",
                                style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w100,
                                  color: value.isTrue
                                      ? Colors.greenAccent
                                      : Colors.white,
                                ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: SfSlider(
                                trackShape: CustomSliderTrack(),
                                thumbShape: CustomSliderThumb(
                                  direction: ThumbDirection.up,
                                  sliderValue: value.sliderValueX.toInt(),
                                ),
                                value: value.sliderValueX,
                                min: 1,
                                max: 10,
                                onChanged: (sliderValue) => !value.isTrue
                                    ? controller.setSliderValueX(sliderValue)
                                    : null,
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
                                    onChanged: (sliderValue) => !value.isTrue
                                        ? controller
                                            .setSliderValueY(sliderValue)
                                        : null,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: double.infinity,
                                      child: GestureDetector(
                                        onPanStart: (details) {
                                          if (!value.isTrue) {
                                            controller.getTapPosition(
                                                details.localPosition);
                                          }
                                        },
                                        onPanUpdate: (details) {
                                          if (!value.isTrue) {
                                            controller.getDragPosition(
                                                details.localPosition);
                                          }
                                        },
                                        child: CanvasGrid(
                                          key: value.canvasKey,
                                          sliderValueY: value.sliderValueY,
                                          sliderValueX: value.sliderValueX,
                                          selectedBox: value.selectedBox,
                                          selectedColor: value.isTrue
                                              ? Colors.greenAccent
                                              : Colors.cyanAccent,
                                          isFalse: value.isFalse,
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
                                    onChanged: (sliderValue) => !value.isTrue
                                        ? controller
                                            .setSliderValueY(sliderValue)
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: SfSlider(
                                trackShape: CustomSliderTrack(),
                                thumbShape: CustomSliderThumb(
                                  direction: ThumbDirection.down,
                                  sliderValue: value.sliderValueX.toInt(),
                                ),
                                value: value.sliderValueX,
                                min: 1,
                                max: 10,
                                onChanged: (sliderValue) => !value.isTrue
                                    ? controller.setSliderValueX(sliderValue)
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        width: 180,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                          ),
                          onPressed: () {
                            if (value.isTrue) {
                              controller.selectNextQuestion();
                            } else {
                              controller.checkAnswer();
                            }
                          },
                          child: Icon(
                            value.isTrue
                                ? Icons.chevron_right_rounded
                                : Icons.check_rounded,
                            size: 40,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                maxBlastForce: 50,
                minBlastForce: 10,
                numberOfParticles: 300,
                gravity: 0.5,
                emissionFrequency: 0.1,
                colors: const [
                  Colors.greenAccent,
                  Colors.cyanAccent,
                  Colors.blueAccent,
                  Colors.purpleAccent,
                  Colors.redAccent,
                  Colors.orangeAccent,
                  Colors.yellowAccent,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
