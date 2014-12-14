//
//  EDMyScene.h
//  Eat Dots
//

//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@class Wamba;

typedef enum{
    easy, medium, hard
} GameMode;

@interface EDMyScene : SKScene <SKPhysicsContactDelegate>{
    Wamba *wamba;
    NSUInteger score, highScore, posXMin, posYMin;
    unsigned int posXRange, posYRange, gameMode, level;
    
    BOOL _gameIsRunning, _didGenerateElements;
    CGPoint _offset;
    float _timeStartValue, _timeCount;
	SKLabelNode *scoreLabel, *timeLabel, *modeLabel;
}

-(id)initWithSize:(CGSize)size gameMode:(GameMode)mode;

/*@property(atomic) BOOL didGenerateElements;
@property(atomic) float timeCount;*/


@end
