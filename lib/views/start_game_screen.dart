import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/game_screen.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

final levelProvider = StateProvider<int>((ref) => -1);

class StartGameScreen extends StatefulWidget {
  const StartGameScreen({super.key});

  @override
  State<StartGameScreen> createState() => _StartGameScreenState();
}

class _StartGameScreenState extends State<StartGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "台灣記憶料理",
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFF4EBE4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BubbleSpecialOne(
                  text: '選擇今天想料理的美食! ',
                  isSender: true,
                  color: Color.fromARGB(255, 214, 191, 172),
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
            Expanded(
              child: MenuList(),
              flex: 1,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ElevatedButton(
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
                  '回主頁',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              flex: 0,
            )
          ],
        ),
      ),
    );
  }
}

class MenuList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final level = ref.watch(levelProvider).state;

    return Padding(
      padding: EdgeInsets.only(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color(0xFFE2C6C4).withOpacity(0.87),
        ),
        child: ListView.builder(
          itemCount: 5, // 假设有5个关卡
          itemBuilder: (context, index) {
            return LevelChooseCard(
              levelIndex: index + 1,
              // onTap: () {
              //   // 更新选择的关卡状态
              //   //context.read(selectedLevelProvider).state = index;
              // },
            );
          },
        ),
      ),
    );
  }
}
// class MenuList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25.0),
//           color: Color(0xFFE2C6C4),
//         ),
//         child: ListView(
//           padding: const EdgeInsets.all(25),
//           children: [
//             MenuItem(icon: Icons.fastfood, name: 'Dish 1',index:1),
//             MenuItem(icon: Icons.fastfood, name: 'Dish 2',index:2),
//             MenuItem(icon: Icons.fastfood, name: 'Dish 3',index:1),
//             MenuItem(icon: Icons.fastfood, name: 'Dish 4',index:2),
//             MenuItem(icon: Icons.fastfood, name: 'Dish 5',index:1),
//             MenuItem(icon: Icons.fastfood, name: 'Dish 6',index:2),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LevelChooseCard extends ConsumerWidget {
  // @override
  final int levelIndex;

  LevelChooseCard({required this.levelIndex});
// int levelIndex1 = levelIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 25, right: 25, bottom: 12.5, top: 12.5),
      child: CustomListTile(
        // Custom list tile widget with specific height
        // tileColor: const Color.fromARGB(137, 139, 19, 19),
        onTap: () {
          // print("@@@");
          print(levelIndex);
          ref.read(levelProvider.notifier).state = levelIndex;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyFlipCardGame(levelIndex: levelIndex),
            ),
          );
        },
        height: 128, // Set custom height for each list tile
        leading: Image.asset('assets/images/chicken.png'), // Leading image
        title: const Text('三杯雞',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final int index;

  MenuItem({required this.icon, required this.name, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: LevelChooseCard(levelIndex: index));
  }
}

// Custom list tile definition
class CustomListTile extends StatelessWidget {
  final Widget? leading; // Optional leading widget
  final Text? title; // Required title text
  final Text? subTitle; // Optional subtitle text
  final Function? onTap; // Optional tap event handler
  final Function? onLongPress; // Optional long press event handler
  final Function? onDoubleTap; // Optional double tap event handler
  final Widget? trailing; // Optional trailing widget
  final Color? tileColor; // Optional tile background color
  final double? height; // Required height for the custom list tile

  // Constructor for the custom list tile
  const CustomListTile({
    super.key,
    this.leading,
    this.title,
    this.subTitle,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.trailing,
    this.tileColor,
    required this.height, // Make height required for clarity
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFEF4F4),
      borderRadius: BorderRadius.circular(25.0),
      child: InkWell(
        // Tappable area with event handlers
        // splashColor: Colors.blue,
        borderRadius: BorderRadius.circular(25.0),

        onTap: () {
          if (onTap != null) {
            print(context);
            onTap!();
          }
        }, // Tap event handler
        onDoubleTap: () => onDoubleTap, // Double tap event handler
        onLongPress: () => onLongPress, // Long press event handler
        child: Container(

            // color: Colors.red,
            // Constrain the size of the list tile
            height: height, // Set custom height from constructor
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, //
                crossAxisAlignment: CrossAxisAlignment.center,
                // Row layout for list item content
                children: [
                  Padding(
                    // Padding for the leading widget
                    padding: const EdgeInsets.only(left: 0, right: 24.0),
                    child: leading, // Display leading widget
                  ),
                  Container(child: title),
                ],
              ),
            )),
      ),
    );
  }
}
