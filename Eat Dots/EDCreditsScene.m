//
//  EDCreditsScene.m
//  Eat Dots
//
//  Created by Craig Rhodes on 4/2/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "EDCreditsScene.h"
#import "TitleLabel.h"
#import "MenuLabel.h"
#import "EDMainMenuScene.h"

@implementation EDCreditsScene 

-(id)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        self.backgroundColor = [SKColor blackColor];
        
        [self setUpLabels];
       
    }
    return self;
}
-(void) didMoveToView:(SKView *)view {
	
}

-(void)setUpLabels{
    //Initialize the labels
    title1 = [[TitleLabel alloc] initWithColor:white text:@"Credits" font:@"Chalkduster" fontSize:72];
    title2 = [[TitleLabel alloc] initWithColor:white text:@"Developed by:" font:@"Chalkduster" fontSize:33];

    TitleLabel *devName = [[TitleLabel alloc] initWithColor:white text:@"Developed by Craig Rhodes" font:@"Chalkduster" fontSize:20];
    
    logoImg = [[SKSpriteNode alloc] initWithImageNamed:@"callistoLogo"];
    logoImg.size = [self sizeWithScale:0.6 currentSize:logoImg.size];
    
    urlText = [[TitleLabel alloc] initWithColor:white text:@"http://callistogames.github.io" font:@"Menlo-Regular" fontSize:16];
    

    
    name1 = [[TitleLabel alloc] initWithColor:white text:@"Invented by Nathan Estock" font:@"Chalkduster" fontSize:20];

    
    backBtn = [[MenuLabel alloc] initWithText:@"<- Back"];
    backBtn.fontSize = 25;
    backBtn.fontColor = [SKColor whiteColor];
    
    //Position the labels
    int centerX = self.frame.size.width/2;
    
    title1.position = CGPointMake(centerX, self.frame.size.height/1.15);
    
    logoImg.position = CGPointMake(centerX, title1.position.y-90);
    urlText.position = CGPointMake(centerX, logoImg.position.y-80);

    name1.position = CGPointMake(centerX, urlText.position.y - 60);
    devName.position = CGPointMake(centerX, name1.position.y - 50);
    
    backBtn.position = CGPointMake(60, 80);
    

    
    
    //Add the labels to the view

    [self addChildren:@[title1, devName,logoImg,urlText,name1]];
    
    [self addChild:backBtn];
    
}
-(CGSize)sizeWithScale:(CGFloat)scale currentSize:(CGSize)size{
    return CGSizeMake(size.width*scale, size.height*scale);
}
-(void)addChildren:(NSArray *)children{
    for(SKNode *node in children){
        [self addChild:node];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        CGPoint touch = [touches.anyObject locationInNode:self];
        
        if([node containsPoint:touch]){
            [(MenuLabel *)node setTouched:YES];
            *stop = YES;
        }
    }];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        MenuLabel *label = (MenuLabel *)node;
        if([label touched] && [node containsPoint:[touches.anyObject locationInNode:self]]){
            [label setTouched:NO];
            [self transitionToMainMenu];
        }
    }];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        [(MenuLabel *)node setTouched:NO];
    }];
}
-(void)transitionToMainMenu{
    SKScene *scene = [[EDMainMenuScene alloc] initWithSize:self.scene.size];
    [self.scene.view presentScene:scene transition:[SKTransition fadeWithColor:[SKColor blackColor] duration:0.4]];
}

@end
