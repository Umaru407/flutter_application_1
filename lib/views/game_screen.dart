import 'dart:async';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/data.dart';
import 'package:flutter_application_1/views/game_over_screen.dart';
import 'package:flutter_application_1/views/start_game_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyFlipCardGame extends ConsumerStatefulWidget {
  final int levelIndex;
  const MyFlipCardGame({required this.levelIndex}); //

  @override
  ConsumerState<MyFlipCardGame> createState() => _MyFlipCardGameState();
}

class _MyFlipCardGameState extends ConsumerState<MyFlipCardGame> {
  @override

  // final int levelIndex
  // _MyFlipCardGameState({required this.levelIndex});

  int _previousIndex = -1;
  int _time = 3;
  int gameDuration = -3;
  bool _flip = false;
  bool _start = false;
  bool _wait = false;
  late bool _isFinished;
  late Timer _timer;
  late Timer _durationTimer;
  late int _left;
  late List _data;
  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _time = (_time - 1);
      });
    });
  }

  void startDuration() {
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        gameDuration = (gameDuration + 1);
      });
    });
  }

  void startGameAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  void initializeGameData(levelIndex) {
    _data = createShuffledListFromImageSource(levelIndex);
    _cardFlips = getInitialItemStateList();
    _cardStateKeys = createFlipCardStateKeysList();
    _time = 3;
    _left = (_data.length ~/ 2);
    _isFinished = false;
  }

  @override
  void initState() {
    final levelIndex = ref.read(levelProvider);
    startTimer();
    startDuration();
    startGameAfterDelay();
    initializeGameData(levelIndex);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _durationTimer.cancel();
  }

  Widget getItem(int index) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // color: Color(0XFFD9D9D9),
        image: DecorationImage(image: AssetImage(_data[index])),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return _isFinished
        ? GameOverScreen(
            duration: gameDuration,
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text("第一關\n食材記憶配對",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  )),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BubbleSpecialOne(
                          text: '找到相同食材點擊形成配對!',
                          isSender: true,
                          color: Color(0xffD6C3B4),
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Color(0xffffffff),

                            // fontStyle: FontStyle.italic,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset('assets/images/chef1.png')
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Text(
                    //       'Remaining: $_left',
                    //       style: theme.bodyMedium,
                    //     ),
                    //     Text(
                    //       'Duration: ${gameDuration}s',
                    //       style: theme.bodyMedium,
                    //     ),
                    //     Text(
                    //       'Countdown: $_time',
                    //       style: theme.bodyMedium,
                    //     )
                    //   ],
                    // ),
                  ),
                  // const SizedBox(
                  //   height:100,
                  // ),
                  GridView.builder(
                    padding: const EdgeInsets.only(right: 84, left: 84),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) => _start
                        ? FlipCard(
                            key: _cardStateKeys[index],
                            onFlip: () {
                              if (!_flip) {
                                _flip = true;
                                _previousIndex = index;
                              } else {
                                _flip = false;
                                if (_previousIndex != index) {
                                  if (_data[_previousIndex] != _data[index]) {
                                    _wait = true;
                                    print(_data[_previousIndex]);
                                    print(_data[index]);
                                    Future.delayed(
                                        const Duration(milliseconds: 1500), () {
                                      _cardStateKeys[_previousIndex]
                                          .currentState!
                                          .toggleCard();
                                      _previousIndex = index;
                                      _cardStateKeys[_previousIndex]
                                          .currentState!
                                          .toggleCard();

                                      Future.delayed(
                                          const Duration(milliseconds: 160),
                                          () {
                                        setState(() {
                                          _wait = false;
                                        });
                                      });
                                    });
                                  } else {
                                    _cardFlips[_previousIndex] = false;
                                    _cardFlips[index] = false;
                                    debugPrint("$_cardFlips");

                                    // print("@@@");
                                    setState(() {
                                      _left -= 1;
                                    });
                                    if (_cardFlips.every((t) => t == false)) {
                                      debugPrint("Won");
                                      Future.delayed(
                                          const Duration(milliseconds: 160),
                                          () {
                                        setState(() {
                                          _isFinished = true;
                                          _start = false;
                                        });
                                        _durationTimer.cancel();
                                      });
                                    }
                                  }
                                }
                              }
                              setState(() {});
                            },
                            flipOnTouch: _wait ? false : _cardFlips[index],
                            direction: FlipDirection.HORIZONTAL,
                            front: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffC2ADAD),
                              ),
                              margin: const EdgeInsets.all(8.0),
                            ),
                            back: getItem(index))
                        : getItem(index),
                    itemCount: _data.length,
                  ),

                  Container(
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xffD6C3B4),
                      // color: Color(0xFFE2C6C4).withOpacity(0.87),
                    ),
                    // padding: EdgeInsets.all(0),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Recipe(),
                  ),
                ],
              ),
            ),
          );
  }
}

class Recipe extends StatelessWidget {
  // final Map<String, dynamic> recipe;
  // const Recipe({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Container(
          // padding: EdgeInsets.all(20),
          child: Container(
            margin: EdgeInsets.all(26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/chicken.png'),
                Text(
                  '三杯雞',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
        )),
        SizedBox(
          width: 30,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 12,
            // ),
            Text(
              '食材',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("雞肉300克", style: TextStyle(fontSize: 14)),
                  Text("醬油3大匙", style: TextStyle(fontSize: 14)),
                  Text("冰糖一大匙", style: TextStyle(fontSize: 14)),
                  Text("九層塔適量", style: TextStyle(fontSize: 14)),
                  Text("薑片適量", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            SizedBox(
              height: 38,
            ),
          ],
        ))
      ],
    );
  }
}
// StatelessWidget  Image.asset('assets/images/chicken.png')