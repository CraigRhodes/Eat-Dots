//
//  EDGameOverScene.m
//  Eat Dots
//
//  Created by Craig Rhodes on 3/19/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "EDGameOverScene.h"
#import "MenuLabel.h"
#import "EDMainMenuScene.h"
#import "TitleLabel.h"
#import "EDMyScene.h"

@implementation EDGameOverScene
#pragma mark - Init methods
-(id)initWithSize:(CGSize)size score:(NSUInteger)score gameMode:(int)mode{
    if (self = [super initWithSize:size]) {
        
        lastGameMode = mode;
        
        self.backgroundColor = [SKColor blackColor];
    
        TitleLabel *modeText = [[TitleLabel alloc] initWithColor:white text:[NSString stringWithFormat:@"%@ Mode",lastGameMode == easy ? @"Easy" : (lastGameMode == medium ? @"Medium" : @"Hard") ] font:@"Chalkduster" fontSize:40];
        modeText.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/1.15);
        [self addChild:modeText];
        
        
        gameOverLabel = [[TitleLabel alloc] init];
		gameOverLabel.fontName = @"ChalkboardSE-Regular";
        gameOverLabel.fontColor = [SKColor whiteColor];
        gameOverLabel.text = @"Game Over";
        gameOverLabel.position = CGPointMake(self.scene.frame.size.width/2, self.scene.frame.size.height/1.4);
        
        //Adjust Game Over label font size to fit screen if necessary.
        while(gameOverLabel.frame.size.width >= self.scene.size.width)gameOverLabel.fontSize--;
        
        [self addChild:gameOverLabel];
        
        
        
        highScoreLabel = [[MenuLabel alloc] init];
		highScoreLabel.fontName = @"ChalkboardSE-Regular";
        highScoreLabel.fontColor = [SKColor whiteColor];
     if(mode == easy){
         highScoreLabel.text = [NSString stringWithFormat:@"Best Score: %ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:kHighScoreKeyEasy]];
        }
     else if(mode == medium){
         highScoreLabel.text = [NSString stringWithFormat:@"Best Score: %ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:kHighScoreKeyMedium]];
     }
     else if(mode == hard){
         highScoreLabel.text = [NSString stringWithFormat:@"Best Score: %ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:kHighScoreKeyHard]];
     }
        highScoreLabel.position = CGPointMake(gameOverLabel.position.x,gameOverLabel.position.y-50);
        
        [self addChild:highScoreLabel];
        
        scoreLabel = [[MenuLabel alloc] init];
		scoreLabel.fontName = @"ChalkboardSE-Regular";
        scoreLabel.fontColor = [SKColor whiteColor];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %d",(int)score];
        scoreLabel.position = CGPointMake(gameOverLabel.position.x, highScoreLabel.position.y-40);
        [self addChild:scoreLabel];
        
        mainMenuLabel = [[MenuLabel alloc] init];
		mainMenuLabel.fontName = @"ChalkboardSE-Regular";
        mainMenuLabel.fontColor = [SKColor whiteColor];
        mainMenuLabel.text = @"Main Menu";
        mainMenuLabel.position = CGPointMake(gameOverLabel.position.x, 100);
        mainMenuLabel.fontSize = 40;
        [self addChild:mainMenuLabel];
        
        startOverLabel = [[MenuLabel alloc] init];
		startOverLabel.fontName = @"ChalkboardSE-Regular";
        startOverLabel.fontColor = [SKColor whiteColor];
        startOverLabel.text = @"Try Again?";
        startOverLabel.position = CGPointMake(gameOverLabel.position.x, mainMenuLabel.position.y+60);
        startOverLabel.fontSize = 32;
        [self addChild:startOverLabel];
        
        

    }
    return self;
}

-(void) didMoveToView:(SKView *)view {

}

// This method is to make a label (in a more compact manner). Not in use at the moment.
/*
-(MenuLabel *)makeLabel:(MenuLabel *)label withText:(NSString *)txt atPosition:(CGPoint)pos{
    
    label = [[MenuLabel alloc] init];
    label.text = [NSString stringWithFormat:@"Best Score: %ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:kHighScoreKey]];
    label.position = CGPointMake(gameOverLabel.position.x,gameOverLabel.position.y-50);
    return label;
}*/

#pragma mark - Touch methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        MenuLabel *label = (MenuLabel *) node;
        label.touched = NO;
    }];
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        CGPoint touch = [[touches anyObject] locationInNode:self];
        MenuLabel *label = (MenuLabel *) node;
        
        if([label containsPoint:touch]){
            [label setTouched:YES];
            *stop = YES;
        }
    }];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        
        CGPoint touch = [[touches anyObject] locationInNode:self];
        
        MenuLabel *label = (MenuLabel *) node;
        
        if([label touched] && [label containsPoint:touch]){
            if([label.text isEqualToString:@"Main Menu"]){
                [self goToMainMenu];
                label.touched = NO;
                *stop = YES;
            }
            else if([label.text isEqualToString:@"Try Again?"]){
                [self restartGame];
                label.touched = NO;
                *stop = YES;
            }
            else{
                label.touched = NO;
            }
        }
        
    }];
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        ((MenuLabel *) node).touched = NO;
    }];
}

-(void)restartGame{
    SKScene *gameScene = [[EDMyScene alloc] initWithSize:self.scene.size gameMode:lastGameMode];
    SKTransition *transition = [SKTransition fadeWithColor:[SKColor whiteColor] duration:1];
	
    [self.scene.view presentScene:gameScene transition:transition];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        ((MenuLabel *) node).touched = NO;
    }];
}

#pragma mark - Update loop
-(void)update:(CFTimeInterval)currentTime {
    
}
-(void)goToMainMenu{
    SKScene *mainScene = [[EDMainMenuScene alloc] initWithSize:self.scene.size];
    SKTransition *transition = [SKTransition fadeWithColor:[SKColor whiteColor] duration:0.4];
    [self.scene.view presentScene:mainScene transition:transition];
}

@end
