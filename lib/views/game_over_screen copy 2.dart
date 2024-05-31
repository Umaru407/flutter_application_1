import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatefulWidget {
  final int duration;
  const GameOverScreen({super.key, required this.duration});

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  bool isConfettiPlaying = true;
  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 6),
  );

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              SizedBox(height:  100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Image.asset("assets/images/complete_dish.png"),
                  SizedBox(width: 30),
                  Text(
                    "料理完成！",
                    style: TextStyle(fontSize: 32, color: Color(0XFF5F4D37)),
                  ),
                ],
              ),

              

              const SizedBox(
                height: 10,
              ),

              Container(
                color: Color(0XFFFFFFFF),
                padding: EdgeInsets.all(60),
                child: Column(
                  children: [
                    Image.asset("assets/images/chicken.png"),
                    Text(
                      "三杯雞",
                      style: TextStyle(fontSize: 32, color: Color(0XFF5F4D37)),
                    )
                  ],
                ),
              ),

              
              const SizedBox(
                height: 20,
              ),

              // Navigator.popUntil(context, (route) => route.isFirst);

              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC6CCC0),
                    foregroundColor: Color(0xFF705E51),

                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15), // 調整內邊距
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 調整圓角
                    ),
                  ),
                  child: Text(
                    '記錄到料理日記',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    // Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE2C6C4),
                    foregroundColor: Color(0xFF705E51),

                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15), // 調整內邊距
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 調整圓角
                    ),
                  ),
                  child: Text(
                    '回主頁',
                    style: TextStyle(fontSize: 24),
                  ),
                )
              ])
            ]),
          ),
          ConfettiWidget(
            numberOfParticles: 30,
            minBlastForce: 10,
            maxBlastForce: 20,
            blastDirectionality: BlastDirectionality.explosive,
            confettiController: _confettiController,
            gravity: 0.1,
          ),
        ],
      ),
    );
  }
}
