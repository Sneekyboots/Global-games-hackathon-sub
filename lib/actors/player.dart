import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_games/pixel_adventure.dart';

enum PlayerState {idle, running }
//used group cause we have lots of animations
class Player extends SpriteAnimationGroupComponent with HasGameRef<PixelAdventure>{
  late final SpriteAnimation idleAnimation;
  final double stepTime= 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }
void _loadAllAnimations(){
  idleAnimation =SpriteAnimation.fromFrameData(game.images.fromCache('Main Characters/Ninja Frog/Idle (32x32).png'),
      SpriteAnimationData.sequenced(amount: 11,
          stepTime: stepTime, textureSize: Vector2.all(32)));
  //list of all the animations
  animations = {
    PlayerState.idle :idleAnimation
  };
  //set  current animation
  current =PlayerState.idle;
}}
