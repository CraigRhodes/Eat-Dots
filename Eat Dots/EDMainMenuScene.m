//
//  EDMainMenuScene.m
//  Eat Dots
//
//  Created by Craig Rhodes on 3/19/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "EDMainMenuScene.h"
#import "EDMyScene.h"
#import "Wamba.h"
#import "MenuLabel.h"
#import "GreenDot.h"
#import "RedBlock.h"
#import "TitleLabel.h"
#import "EDCreditsScene.h"
#import "EDSettingsScene.h"
#import "EDHowToPlayScene.h"

@implementation EDMainMenuScene
#pragma mark - Init methods
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor whiteColor];
        
        currentCategory = kMainType;
        
        //Adds notifications for the banner loaded notification and not loaded notification
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBannerHeight) name:kBannerLoadedNotification object:nil];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeBannerHeight) name:kBannerNotLoadedNotification object:nil];
        
        [self setUpMainLabels];

        [self positionSprites];
        
    }
    return self;
}



#pragma mark - Ad Events

-(void)addBannerHeight{
    NSLog(@"Add Banner Height");
    CGSize rSize = [RedBlock redBlockSize];
    
    NSInteger bannerHeight = [[NSUserDefaults standardUserDefaults] integerForKey:kBannerHeight];
    
    posYMin = rSize.height/2 + bannerHeight;
    posXMin = rSize.width/2;
    posXRange = self.frame.size.width - rSize.width;
    posYRange = self.frame.size.height - (bannerHeight + rSize.height);
    
    [self positionLabelsOfType:currentCategory];
}
-(void)removeBannerHeight{
    NSLog(@"Remove Banner Height");
    CGSize rSize = [RedBlock redBlockSize];
    
    posYMin = rSize.height/2;
    posXMin = rSize.width/2;
    posXRange = self.frame.size.width - rSize.width;
    posYRange = self.frame.size.height - rSize.height;
    
    [self positionLabelsOfType:currentCategory];
}

#pragma mark - Set Up Labels

-(void)setUpMainLabels{
    [self addTitleLabelWithText:@"Eat Dots"];
    
    [self revealMainLabels];
    
}

-(void)revealMainLabels{
    [self removeLabels];
    
    playLabel = [[MenuLabel alloc] initWithText:@"Play"];
    howToPlayLabel = [[MenuLabel alloc] initWithText:@"How to Play"];
    rateLabel = [[MenuLabel alloc] initWithText:@"Rate"];
    creditsLabel = [[MenuLabel alloc] initWithText:@"Credits"];
    
    playLabel.zPosition = 2;
    rateLabel.zPosition = 2;
    creditsLabel.zPosition = 2;
    howToPlayLabel.zPosition = 2;
    
    [self positionLabelsOfType:kMainType];
    [self addChildren:@[ playLabel, howToPlayLabel, rateLabel, creditsLabel ]];
    
}

-(void)revealDifficulyLabels{
    [self removeLabels];
    
    backLabel = [[MenuLabel alloc] initWithText:@"Back" fontSize:20];
    easyModelabel = [[MenuLabel alloc] initWithText:@"Easy"];
    mediumModelabel = [[MenuLabel alloc] initWithText:@"Medium"];
    hardModelabel = [[MenuLabel alloc] initWithText:@"Hard"];
    
    backLabel.zPosition = 2;
    easyModelabel.zPosition = 2;
    mediumModelabel.zPosition = 2;
    hardModelabel.zPosition = 2;
    
    [self positionLabelsOfType:kDifficultyType];
    [self addChildren: @[ backLabel, easyModelabel , mediumModelabel , hardModelabel ] ];
    
}

#pragma mark - Positioning
-(void)positionLabelsOfType:(NSString *)type{
    currentCategory = type;
    
    if([type isEqualToString:kDifficultyType]){
        easyModelabel.position = CGPointMake(self.scene.frame.size.width/2, titleLabel.position.y-60);
        mediumModelabel.position = CGPointMake(self.scene.frame.size.width/2, easyModelabel.position.y-70);
        hardModelabel.position = CGPointMake(self.scene.frame.size.width/2, mediumModelabel.position.y-70);
        
        NSInteger bannerHeight = [[NSUserDefaults standardUserDefaults] integerForKey:kBannerHeight];
        
        backLabel.position = CGPointMake(40, bannerHeight + 20);
    }
    else if([type isEqualToString:kMainType]){
        CGFloat centerXPos = self.scene.frame.size.width/2;
        

        playLabel.position = CGPointMake(centerXPos, titleLabel.position.y - 60);
        howToPlayLabel.position = CGPointMake(centerXPos, playLabel.position.y - 55);
        rateLabel.position = CGPointMake(centerXPos, howToPlayLabel.position.y - 55);
        creditsLabel.position = CGPointMake(centerXPos, rateLabel.position.y - 55);
        
    }
}


-(void)positionSprites{
    wamba = [[Wamba alloc] init];
    wamba.zPosition = 1;
    enemy = [[RedBlock alloc] init];
    enemy.zPosition = 0;
    greenDot = [[GreenDot alloc] init];
    greenDot.zPosition = 0;
    
    NSInteger bannerHeight = [[NSUserDefaults standardUserDefaults] integerForKey:kBannerHeight];
    
    posYMin = enemy.size.height/2 + bannerHeight;
    posXMin = enemy.size.width/2;
    posXRange = self.frame.size.width - enemy.size.width;
    posYRange = self.frame.size.height- (bannerHeight + enemy.size.height);
    
    enemy.position = [self randomPositionPoint];
    greenDot.position = [self randomPositionPoint];
    
    [self addChildren:@[ wamba , enemy , greenDot] ];
    

}





#pragma mark - Touch methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //Set the touched label's touched boolean value to YES if touched.
    
    CGPoint touch = [touches.anyObject locationInNode:self];
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        if([node containsPoint:touch]){
            ((MenuLabel *)node).touched = YES;
            *stop = YES;
        }
    }];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Button actions for when touch ends
    
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        MenuLabel *label;
        
        //If the label was tapped
        if([(label = (MenuLabel *)node) touched] && [label containsPoint:[touches.anyObject locationInNode:self]]){
            [label setTouched:NO];
            SKAction *tapAction = [SKAction sequence: @[[SKAction scaleBy:1.2 duration:.02],[SKAction scaleBy:.8 duration:.02] ]];
            
            //A MenuLabel was pressed
            if([label.text isEqualToString:@"Play"]){
                [label runAction:[SKAction sequence:@[tapAction,[SKAction performSelector:@selector(revealDifficulyLabels) onTarget:self]]]];
        
            }
            else if([label.text isEqualToString:@"How to Play"]){
                [label runAction:[SKAction sequence:@[tapAction,[SKAction performSelector:@selector(transitionToHowToPlayScene) onTarget:self]]]];
            }
            /*else if([label.text isEqualToString:@"Options"]){
                [label runAction:[SKAction sequence:@[tapAction,[SKAction performSelector:@selector(transitionToSettingsScene) onTarget:self]]]];
            }*/
            else if([label.text isEqualToString:@"Rate"]){
                //Code to link to the app store rating
                [label runAction:[SKAction sequence:@[tapAction,[SKAction performSelector:@selector(appRateAlert) onTarget:self]]]];
            }
            else if([label.text isEqualToString:@"Credits"]){
                [label runAction:[SKAction sequence:@[tapAction,[SKAction performSelector:@selector(transitionToCreditsScene) onTarget:self]]]];
            }
            else if([label.text isEqualToString: @"Easy"]){
                [label runAction:[SKAction sequence:@[tapAction,[SKAction runBlock:^{
                    [self startGamewithMode:easy];
                }]] ]];
                
            }
            else if([label.text isEqualToString: @"Medium"]){
                [label runAction:[SKAction sequence:@[tapAction,[SKAction runBlock:^{
                    [self startGamewithMode:medium];
                }]] ]];
            }
            else if([label.text isEqualToString: @"Hard"]){
                [label runAction:[SKAction sequence:@[tapAction,[SKAction runBlock:^{
                    [self startGamewithMode:hard];
                }]] ]];
            }
            else if([label.text isEqualToString: @"Back"]){
                
                [label runAction:[SKAction sequence:@[ tapAction , [SKAction performSelector:@selector(revealMainLabels) onTarget:self] ]]];
            }
            else{
                [label runAction:tapAction];
            }

            *stop = YES;
        }
    }];
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        MenuLabel *label = (MenuLabel *) node;
        [label setTouched:NO];

    }];

}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        MenuLabel *label = (MenuLabel *) node;
        [label setTouched:NO];
        
    }];
}

#pragma mark - Rate Alert
-(void)appRateAlert{
    //Show the alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rate Eat Dots" message:@"Would you like to rate Eat Dots?" delegate:self cancelButtonTitle:@"Rate it!" otherButtonTitles:@"No thanks", nil];
    [alert show];
}
-(NSURL *)appIDPath{
    //NSString *str = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/eat-dots/id880486464?ls=1&mt=8"];

    return url;
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    //Said to rate the app
    if(buttonIndex == 0){
        //Add link to app store HERE
        [[UIApplication sharedApplication] openURL:[self appIDPath]];
    }
    //Said "No Thanks"
    else{
        
    }
}

#pragma mark - Update Loop

-(void)update:(CFTimeInterval)currentTime {
    
    //Replace these after a certain amount of time.
    if(++count == 30){
        count = 0;
        enemy.position = [self randomPositionPoint];
        greenDot.position = [self randomPositionPoint];
    }
    
    //Handle the wamba's movement
    if(!isMoving){
        wamba.size = [Wamba sizeWithScale:((arc4random_uniform(260)+40)/100.0)];
        wamba.position = CGPointMake(-wamba.size.width/2+1, arc4random_uniform(posYRange) + posYMin);
        
        
        SKAction *moveRight = [SKAction moveByX:30*((arc4random_uniform(17)+10)/20.0) y:0 duration:.2];
        SKAction *moveRightAlways = [SKAction repeatActionForever:moveRight];
        [wamba runAction:moveRightAlways];
        isMoving = YES;
    }
    else{
        //If it reaches the end of the screen
        if(wamba.position.x >= self.frame.size.width + wamba.size.width/2){
            isMoving = NO;
            [wamba removeAllActions];
        }
    }
    
}




#pragma mark - Helper Methods

-(void)removeLabels{
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        //Remove all but the title label
            [node removeFromParent];
    }];
}

//Returns a point at a random valid position
-(CGPoint)randomPositionPoint{
    CGPoint randomPoint;
    do{
        randomPoint = CGPointMake(arc4random_uniform(posXRange) + posXMin, arc4random_uniform(posYRange) + posYMin);
    }while(![self isValidPoint:randomPoint]);
    
    return randomPoint;
}

-(BOOL)isValidPoint:(CGPoint)point{
    SKNode *compNode = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(45, 45)];
    compNode.position = point;
    for(SKNode *node in [self children]){
        if([node intersectsNode:compNode] && ![node.name isEqualToString:kMenuLabelName]){
            return NO;
        }
    }
    return YES;
}

-(void)changeTitleWithText:(NSString *)txt{
    titleLabel.text = txt;
}

-(void)addChildren:(NSArray *)children{
    for(SKNode * child in children){
        [self addChild:child];
    }
}

/*
-(BOOL)hasSmallScreen{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}*/

-(void)addTitleLabelWithText:(NSString *)txt{
    titleLabel = [[TitleLabel alloc] init];
	//titleLabel.fontName = @"ChalkboardSE-Regular";
    titleLabel.position = CGPointMake(self.scene.frame.size.width/2, self.scene.frame.size.height/1.5);
    titleLabel.text = txt;
    titleLabel.zPosition = 2;
    [self addChild:titleLabel];
}

#pragma mark - Transition
/*
-(void)transitionToSettingsScene{
    //Transition to the settings scene
    SKScene *scene = [[EDSettingsScene alloc] initWithSize:self.scene.size];
    [self.scene.view presentScene:scene transition:[SKTransition fadeWithColor:[SKColor grayColor] duration:.5]];
}*/
-(void)transitionToCreditsScene{
    
    SKScene *scene = [[EDCreditsScene alloc] initWithSize:self.scene.size];
    [self.scene.view presentScene:scene transition:[SKTransition fadeWithColor:[SKColor grayColor] duration:0.4]];
}
-(void)transitionToHowToPlayScene{
    SKScene *scene = [[EDHowToPlayScene alloc] initWithSize:self.scene.size];
    [self.scene.view presentScene:scene transition:[SKTransition fadeWithColor:[SKColor whiteColor] duration:0.4]];
}
-(void)startGamewithMode:(GameMode)mode{
	[self removeLabels];
	
    //self.scene.backgroundColor = [SKColor colorWithRed:120 green:232 blue:255 alpha:1];
    titleLabel.text = @"Loading...";
	//titleLabel.fontName = @"System";
	titleLabel.fontSize = 55;
    titleLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);

	[wamba removeAllActions];
	wamba.size = [Wamba sizeWithScale:2.5];
    wamba.position = CGPointMake(titleLabel.position.x, titleLabel.position.y-100);
	
	//Remove the sprites before the transition
    [self enumerateChildNodesWithName:kRedEnemyName usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
    [self enumerateChildNodesWithName:kGreenDotName usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
	
	//Sets up for transition
	SKScene *gameScene = [[EDMyScene alloc] initWithSize:self.scene.size gameMode:mode];
    SKTransition *gameTransition = [SKTransition fadeWithColor:[SKColor blackColor] duration:1.0];

    //Transition to game scene
    [self.scene.view presentScene:gameScene transition:gameTransition];
}
-(void)willMoveFromView:(SKView *)view{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];

}

-(void)didMoveToView:(SKView *)view{

}

@end
