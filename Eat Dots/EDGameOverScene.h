//
//  EDGameOverScene.h
//  Eat Dots
//
//  Created by Craig Rhodes on 3/19/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class MenuLabel,TitleLabel;

@interface EDGameOverScene : SKScene < UIAlertViewDelegate >{
    TitleLabel *gameOverLabel;
    MenuLabel *scoreLabel, *startOverLabel, *highScoreLabel, *mainMenuLabel;
    int lastGameMode;
}

-(id)initWithSize:(CGSize)size score:(NSUInteger)score gameMode:(int)mode;



@end
