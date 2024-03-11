import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_games/pixel_adventure.dart';
import 'package:flutter/services.dart';


enum PlayerState { idle, running }
enum PlayerDirection {left,right,none}

//used group cause we have lots of animations
class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>,KeyboardHandler {
  String character;
  Player({ position, this.character='Ninja Frog'}) : super(position: position);


  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningani;
  final double stepTime = 0.05;

  PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed=100;
  Vector2 velocity= Vector2.zero();
  bool isFacingRight=true;


  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }
  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed =keysPressed.contains(LogicalKeyboardKey.keyA)||keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed =keysPressed.contains(LogicalKeyboardKey.keyD)||keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if(isLeftKeyPressed && isRightKeyPressed){
      playerDirection=PlayerDirection.none;
    }else if (isLeftKeyPressed){
      playerDirection=PlayerDirection.left;
    }else if(isRightKeyPressed){
      playerDirection=PlayerDirection.right;
    }
    else{
      playerDirection=PlayerDirection.none;
    }
    return super.onKeyEvent(event, keysPressed);
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
  void _updatePlayerMovement(double dt) {
    double dirX=0.0;
    switch(playerDirection){
      case PlayerDirection.left:
        if(isFacingRight){
          flipHorizontallyAroundCenter();
          isFacingRight= false;
        }
        current=PlayerState.running;
        dirX -= moveSpeed;
        break;
      case PlayerDirection.right:
        if(!isFacingRight){
          flipHorizontallyAroundCenter();
          isFacingRight= true;
        }
        current=PlayerState.running;
        dirX += moveSpeed;
        break;
      case PlayerDirection.none:
        current=PlayerState.idle;
        break;
      default:
    }
    velocity =Vector2(dirX,0.0 );
    position +=velocity*dt;
  }

  SpriteAnimation _spriteAnimation(String state ,int amount){
    return SpriteAnimation.fromFrameData(game.images.fromCache('Main Characters/$character/$state (32x32).png'),
        SpriteAnimationData.sequenced(amount: amount,
            stepTime: stepTime, textureSize: Vector2.all(32)));

  }

}


