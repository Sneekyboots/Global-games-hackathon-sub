import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_games/levels/level.dart';

class PixelAdventure extends FlameGame{
  //issues
  late final CameraComponent cam;
  @override
  final world=Level();
  @override
  FutureOr<void> onLoad() {
    cam= CameraComponent.withFixedResolution(world:world, width: 640, height:360 );
    addAll([cam,world]);
    return super.onLoad();
  }
}