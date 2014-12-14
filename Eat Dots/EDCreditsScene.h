//
//  EDCreditsScene.h
//  Eat Dots
//
//  Created by Craig Rhodes on 4/2/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class TitleLabel, MenuLabel;

@interface EDCreditsScene : SKScene < UIAlertViewDelegate >{
    TitleLabel *title1, *title2;
    TitleLabel *name1;
    TitleLabel *urlText;
    SKSpriteNode *logoImg;
    MenuLabel *backBtn;
}

-(id)initWithSize:(CGSize)size;
@end
