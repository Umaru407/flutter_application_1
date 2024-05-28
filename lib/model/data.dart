import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

List<String> imageSource(levelIndex) {
  return [
    'assets/images/image_${levelIndex}-1.png',
    'assets/images/image_${levelIndex}-2.png',
    'assets/images/image_${levelIndex}-3.png',
    'assets/images/image_${levelIndex}-4.png',
    'assets/images/image_${levelIndex}-1.png',
    'assets/images/image_${levelIndex}-2.png',
    'assets/images/image_${levelIndex}-3.png',
    'assets/images/image_${levelIndex}-4.png',
  ];
}

List createShuffledListFromImageSource(levelIndex) {
  List shuffledImages = [];
  List sourceArray = imageSource(levelIndex);
  for (var element in sourceArray) {
    shuffledImages.add(element);
  }
  shuffledImages.shuffle();
  return shuffledImages;
}

List<bool> getInitialItemStateList() {
  List<bool> initialItem = <bool>[];
  for (int i = 0; i < 8; i++) {
    //8
    initialItem.add(true);
  }
  return initialItem;
}

List<GlobalKey<FlipCardState>> createFlipCardStateKeysList() {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  for (int i = 0; i < 8; i++) {
    //8
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}
