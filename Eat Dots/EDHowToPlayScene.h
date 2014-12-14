//
//  EDHowToPlayScene.h
//  Eat Dots
//
//  Created by Craig Rhodes on 5/29/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class TitleLabel, Wamba, GreenDot, RedBlock;

@interface EDHowToPlayScene : SKScene <SKPhysicsContactDelegate>{
    TitleLabel *howToPlayLabel, *backLabel, *wambaText, *wambaGrowText, *redBlockText, *remainingLifeText, *greenDotText, *scoreText, *wambaDesc, *redBlockDesc, *greenDotDesc, *commentLabel;
    Wamba *wamba;
    GreenDot *greenDot;
    RedBlock *redBlock;
    BOOL wambaDragged;
    NSUInteger score;
}

@property(atomic) BOOL didGenerateElements;

@end
