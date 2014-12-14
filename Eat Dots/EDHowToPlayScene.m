//
//  EDHowToPlayScene.m
//  Eat Dots
//
//  Created by Craig Rhodes on 5/29/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "EDHowToPlayScene.h"
#import "TitleLabel.h"
#import "EDMainMenuScene.h"
#import "Wamba.h"
#import "RedBlock.h"
#import "GreenDot.h"



@implementation EDHowToPlayScene
-(id)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        wambaDragged = NO;
        _didGenerateElements = YES;
        self.scene.backgroundColor = [SKColor whiteColor];
        
        self.physicsWorld.speed = 1;
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        //self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.contactDelegate = self;
        
        [self fillScene];
    }
    return self;
}
-(void)didMoveToView:(SKView *)view {

}
-(void)fillScene{
    
    //Set up title label
    howToPlayLabel = [[TitleLabel alloc] initWithColor:black text:@"How to Play" font:@"Chalkduster" fontSize:45];
    howToPlayLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 60);
    
    //Set up back Label
    backLabel = [[TitleLabel alloc] initWithColor:black text:@"(Tap to go back)" font:@"Menlo-Regular" fontSize:25];
    backLabel.position = CGPointMake(howToPlayLabel.position.x, howToPlayLabel.position.y - 40);
    
    //Set up difficulty label
    TitleLabel *difficultyLabel = [[TitleLabel alloc] initWithColor:black text:@"Easy" font:@"Helvetica" fontSize:25];
    difficultyLabel.zPosition = 2;
    
    difficultyLabel.position = CGPointMake(self.frame.size.width/2, [[NSUserDefaults standardUserDefaults] integerForKey:kBannerHeight] + 20);
    [self addChild:difficultyLabel];
    
    [self setUpWamba];
    [self setUpRedBlock];
    [self setUpGreenDot];
    [self setUpScoreLabel];
    [self setUpTimerLabel];
    [self addDescriptionText];
    
    [self addChildren:@[ howToPlayLabel, backLabel, wamba, redBlock, greenDot, scoreText, remainingLifeText ]];
    
  
    
}
-(void)setUpWamba{
    wamba = [[Wamba alloc] init];
    wamba.size = [Wamba sizeWithScale:pow(1.04, 17)];
	wamba.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wamba.size];
    wamba.position = CGPointMake(self.frame.size.width*.8, self.frame.size.height/1.9);
}
-(void)setUpRedBlock{
    redBlock = [[RedBlock alloc] init];
    redBlock.position = CGPointMake(self.frame.size.width*.3, self.frame.size.height/1.4);
}
-(void)setUpGreenDot{
    greenDot = [[GreenDot alloc] init];
    greenDot.position = CGPointMake(self.frame.size.width*.45, self.frame.size.height/3);

}
-(void)setUpScoreLabel{
    scoreText = [[TitleLabel alloc] initWithColor:black text:@"17" font:@"Helvetica" fontSize:25];
    scoreText.position = CGPointMake(50,[[NSUserDefaults standardUserDefaults] integerForKey:kBannerHeight] + 20);
    
}
-(void)setUpTimerLabel{
    remainingLifeText = [[TitleLabel alloc] initWithColor:black text:@"1.00" font:@"Helvetica" fontSize:25];
    remainingLifeText.position = CGPointMake(self.size.width-35,[[NSUserDefaults standardUserDefaults] integerForKey:kBannerHeight] + 20);
}

-(void)addDescriptionText{
    wambaDesc = [[TitleLabel alloc] initWithColor:black text:@"Drag the Wamba" font:@"Menlo-Regular" fontSize:15];
    wambaDesc.position = CGPointMake(wamba.position.x, wamba.position.y-45);
    
    redBlockDesc = [[TitleLabel alloc] initWithColor:black text:@"Avoid red blocks" font:@"Menlo-Regular" fontSize:15];
    redBlockDesc.position = CGPointMake(redBlock.position.x, redBlock.position.y-40);
    
    greenDotDesc = [[TitleLabel alloc] initWithColor:black text:@"Eat green dots" font:@"Menlo-Regular" fontSize:15];
    greenDotDesc.position = CGPointMake(greenDot.position.x, greenDot.position.y-35);
    
    TitleLabel *remainingLifeTextDesc = [[TitleLabel alloc] initWithColor:black text:@"Remaining time" font:@"Menlo-Regular" fontSize:10];
    remainingLifeTextDesc.position = CGPointMake(remainingLifeText.position.x-15, remainingLifeText.position.y+25);
    
    TitleLabel *difficultyDesc = [[TitleLabel alloc] initWithColor:black text:@"Difficulty" font:@"Menlo-Regular" fontSize:10];
    difficultyDesc.position = CGPointMake(self.frame.size.width/2, [[NSUserDefaults standardUserDefaults] integerForKey:kBannerHeight] + 45);
    
    TitleLabel *scoreTextDesc = [[TitleLabel alloc] initWithColor:black text:@"Current score" font:@"Menlo-Regular" fontSize:10];
    scoreTextDesc.position = CGPointMake(scoreText.position.x, scoreText.position.y+25);
    
    [self addChildren:@[ wambaDesc, redBlockDesc, greenDotDesc, remainingLifeTextDesc, scoreTextDesc, difficultyDesc ]];
}


-(void)update:(NSTimeInterval)currentTime{
    
    wambaDesc.position = CGPointMake(wamba.position.x, wamba.position.y-45);
    redBlockDesc.position = CGPointMake(redBlock.position.x, redBlock.position.y-40);
    greenDotDesc.position = CGPointMake(greenDot.position.x, greenDot.position.y-35);
    
    //Generate the elements if they haven't already been generated
    if(!_didGenerateElements){
            [self generateStuff];
    }
    
}

-(void)generateStuff{
    
    //Generate the enemy blobs
    redBlock.position = CGPointMake(self.frame.size.width/1.3, self.frame.size.height/1.3);

    //Generate the green dots
    greenDot.position = CGPointMake(self.frame.size.width/1.5, self.frame.size.height/2);
    
    _didGenerateElements = YES;
	
}

-(void)addCommentLabelWithText: (NSString *)txt {
	if(![self childNodeWithName:@"Comment"]) {
		commentLabel = [[TitleLabel alloc] initWithColor:black text:txt font:@"Helvetica" fontSize:45];
		commentLabel.name = @"Comment";
		commentLabel.zPosition = 2;
		commentLabel.position = CGPointMake(self.frame.size.width/2,self.frame.size.height/1.7);
		[self addChild:commentLabel];
	} else {
		[[self childNodeWithName:@"Comment"] removeFromParent];
		commentLabel.text = txt;
		[self addChild:commentLabel];
	}
}

-(void)addChildren:(NSArray *)children {
    for(SKNode * child in children)
        [self addChild:child];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touch = [(UITouch *)touches.anyObject locationInNode:self];
    CGPoint prevTouch = [(UITouch *)touches.anyObject previousLocationInNode:self];
    
    if([wamba containsPoint:prevTouch]){
        if(!wambaDragged)wambaDragged = YES;
        CGPoint _offset = CGPointMake(touch.x-prevTouch.x, touch.y-prevTouch.y);
        wamba.position = CGPointMake(wamba.position.x + _offset.x, wamba.position.y + _offset.y);
    }
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!wambaDragged){ //Transition back to menu if the wamba wasn't dragged
    SKTransition *transition = [SKTransition fadeWithColor:[SKColor whiteColor] duration:.4];
    SKScene *theScene = [[EDMainMenuScene alloc] initWithSize:self.scene.size];
    [self.scene.view presentScene:theScene transition:transition];
    }
    wambaDragged = NO;
}
-(void)didEndContact:(SKPhysicsContact *)contact {
	if([self contactedEnemy:contact]){
		//Wamba contacted enemy
		[wamba runAction:[SKAction rotateToAngle:0 duration:0.1 shortestUnitArc:YES]];
	}
	
}
-(void)didBeginContact:(SKPhysicsContact *)contact {
    if([self contactedEnemy:contact]){
        //Wamba contacted enemy
		[self addCommentLabelWithText:@"Wrong!"];
    }
    else if([self contactedGreenDot:contact]){
        //Wamba contacted green dot
        if(score <= 17){
        wamba.size = [wamba sizeWithScale:[self hasSmallScreen] ? 1.04 : 1.06];
        wamba.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wamba.size];
        _didGenerateElements = NO;
        
        [self changeScoreBy:1];
		wamba.zPosition = 1;
		redBlock.zPosition = 0;
		greenDot.zPosition = 0;
            
		[self addCommentLabelWithText:@"Now you get it!"];
		wamba.physicsBody.dynamic = NO;
            
        }
    } // End green dot contact
}
-(void)changeScoreBy:(NSInteger)amt{
    if((NSInteger)score + amt < 0)score = 0;
    else{
        score += amt;
    }
    
    //Update score label
    score = 18;
    [scoreText setText:@"18"];
}
-(BOOL)hasSmallScreen{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}
/*
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{

}*/

-(BOOL)contactedGreenDot:(SKPhysicsContact *)contact{
    NSString *name1 = [NSString stringWithString:contact.bodyA.node.name];
    NSString *name2 = [NSString stringWithString:contact.bodyB.node.name];
    
    return ([name1 isEqualToString:kWambaName] && [name2 isEqualToString:kGreenDotName]) || ([name2 isEqualToString:kWambaName] && [name1 isEqualToString:kGreenDotName]);
}
-(BOOL)contactedEnemy:(SKPhysicsContact *)contact{
    NSString *name1 = [NSString stringWithString:contact.bodyA.node.name];
    NSString *name2 = [NSString stringWithString:contact.bodyB.node.name];
    
    return ([name1 isEqualToString:kWambaName] && [name2 isEqualToString:kRedEnemyName]) || ([name2 isEqualToString:kWambaName] && [name1 isEqualToString:kRedEnemyName]);
}

@end
