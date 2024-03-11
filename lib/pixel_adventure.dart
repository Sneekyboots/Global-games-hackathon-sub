import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_games/levels/level.dart';

class PixelAdventure extends FlameGame{
  @override
  Color backgroundColor()=> const Color(0xFF211F30);
  late final CameraComponent cam;

  @override
  final world=Level(levelName: 'Level02');

  @override
  FutureOr<void> onLoad() async {
    //we will be loading all the images of the character for now in cache

    await images.loadAllImages();


    cam= CameraComponent.withFixedResolution(world:world, width: 640, height:360 );
    cam.viewfinder.anchor=Anchor.topLeft;
    addAll([cam,world]);


    return super.onLoad();
  }
}