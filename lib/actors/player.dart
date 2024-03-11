import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_games/pixel_adventure.dart';
import 'package:flutter/cupertino.dart';

enum PlayerState { idle, running }

//used group cause we have lots of animations
class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure> {
  String character;
  Player({ position,  required this.character}) : super(position: position);


  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningani;
  final double stepTime = 0.05;


  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }
  void _loadAllAnimations() {
    idleAnimation = _spriteAnimation('Idle',11);
    runningani = _spriteAnimation('Run',12);
    //list of all the animations
    animations = {PlayerState.idle: idleAnimation,
                  PlayerState.running:runningani,

    };
    current = PlayerState.running;
  }
  SpriteAnimation _spriteAnimation(String state ,int amount){
    return SpriteAnimation.fromFrameData(game.images.fromCache('Main Characters/$character/$state (32x32).png'),
        SpriteAnimationData.sequenced(amount: amount,
            stepTime: stepTime, textureSize: Vector2.all(32)));

  }
}
