//
//  EDMyScene.m
//  Eat Dots
//
//  Created by Craig Rhodes on 3/13/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "EDMyScene.h"
#import "EDGameOverScene.h"
#import "Wamba.h"
#import "RedBlock.h"
#import "GreenDot.h"


@implementation EDMyScene

#pragma mark - Init methods
-(id)initWithSize:(CGSize)size gameMode:(GameMode)mode{

    if (self = [super initWithSize:size]) {
		
        self.backgroundColor = [SKColor whiteColor];
        gameMode = mode;
		
		//Create label to display mode
        modeLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        modeLabel.position = CGPointMake(self.frame.size.width/2, [[NSUserDefaults standardUserDefaults] integerForKey:kBannerHeight] + 20);
        modeLabel.zPosition = 5;
        modeLabel.fontSize = 25;
        modeLabel.fontColor = [SKColor blackColor];
		modeLabel.text = [NSString stringWithFormat:@"%@",gameMode == easy ? @"Easy" : (gameMode == medium ? @"Medium" : @"Hard")];
        [self addChild:modeLabel];
		
        [self initializeVariables];
		
		
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {

}

#pragma mark - Touch methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    
    CGPoint touch = [(UITouch *)touches.anyObject locationInNode:self];
    
    //If the wamba is first touched inside
    if([wamba containsPoint:touch] && !_gameIsRunning){
        _gameIsRunning = YES;
        return;
    }
   
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!_gameIsRunning)return;
    //Game is running
    
    CGPoint touch = [(UITouch *)touches.anyObject locationInNode:self];
    CGPoint prevTouch = [(UITouch *)touches.anyObject previousLocationInNode:self];
    
    if([wamba containsPoint:prevTouch]){
        _offset = CGPointMake(touch.x-prevTouch.x, touch.y-prevTouch.y);
        wamba.position = CGPointMake(wamba.position.x + _offset.x, wamba.position.y + _offset.y);
    }
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!_gameIsRunning)return;
    //Game is Running

 
    
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!_gameIsRunning)return;
    //Game is running

}

#pragma mark - Update loop
//Run loop - runs 60 times a second
-(void)update:(CFTimeInterval)currentTime {
 
    
    if(!_gameIsRunning)return; //If the game isn't running, it's pointless to even run through the update method.
    
    
    timeLabel.text = [NSString stringWithFormat:@"%.2f",--_timeCount/60.0]; //Adjust the timelabel with a lower value.
    
    if(_timeCount == 0){
        [self gameOver];
        return;
    } //If it has to, do a Game Over before the elements get regenerated if the elements are about to be regenerated
    
    //Generate the elements if they haven't already been generated
    if(!_didGenerateElements){
        if(level == 0)[self generateRedBlobs:1 ofSize:[RedBlock sizeWithScale:[self hasSmallScreen] ? 0.9 : 1.1] greenDots:1];
        else if(level == 1){
            [self generateRedBlobs:1 ofSize:[RedBlock sizeWithScale:[self hasSmallScreen] ? 1 : 1.3] greenDots:1];
        }
        else if(level == 2){
            [self generateRedBlobs:1 ofSize:[RedBlock sizeWithScale:[self hasSmallScreen] ? 1.2 : 1.5] greenDots:1];
        }
        else if(level >= 3){
            [self generateRedBlobs:1 ofSize:[RedBlock sizeWithScale:[self hasSmallScreen] ? 1.35 : 1.7] greenDots:1];
        }
    }
    

}

#pragma mark - Contact
-(void)didBeginContact:(SKPhysicsContact *)contact{
    if([self contactedEnemy:contact]){
        //Wamba contacted enemy
      [self gameOver];
        
    }
    else if([self contactedGreenDot:contact]){
        //Wamba contacted green dot
        
        
        [self changeScoreBy:1];
        [self enumerateChildNodesWithName:kRedEnemyName usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        [self enumerateChildNodesWithName:kGreenDotName usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        if([wamba hasActions] && score == 51){
            [wamba removeAllActions];
            wamba.size = [Wamba sizeWithScale:[self hasSmallScreen] ? 1.04 : 1.06];
        }
        else{
            wamba.size = [wamba sizeWithScale:[self hasSmallScreen] ? 1.04 : 1.06];
        }
        wamba.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:wamba.size];
        _didGenerateElements = NO;
        _timeCount = _timeStartValue;

    }
    
    
}
/*-(void)didEndContact:(SKPhysicsContact *)contact{
   
}*/
#pragma mark - Contact Helper Methods
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

#pragma mark - Generate Elements
-(void)generateRedBlobs:(NSUInteger)numRedBlobs
                 ofSize:(CGSize)size
              greenDots:(NSUInteger)numGreenDots{
    
    //Generate the enemy blobs
    for(int i = 0; i < numRedBlobs; i++){
        SKSpriteNode *blob = [[RedBlock alloc] initWithSize: size];
        blob.position = [self randomPositionPointForSize:blob.size];
        [self addChild:blob];
    }

    
    //Generate the green dots
    for(int i = 0; i < numGreenDots; i++){
        SKSpriteNode *dot = [[GreenDot alloc] init];
        dot.position = [self randomPositionPointForSize:dot.size];
        [self addChild:dot];
    }

    
    _didGenerateElements = YES;

}

#pragma mark - Generate Elements Helper Methods

//Returns a point at a random valid position
-(CGPoint)randomPositionPointForSize:(CGSize)nodeSize{
    CGPoint randomPoint;
    do{
        randomPoint = CGPointMake(arc4random_uniform(posXRange) + posXMin, arc4random_uniform(posYRange) + posYMin);
    }while(![self isValidPoint:randomPoint forSize:nodeSize]);
    
    return randomPoint;
}

//Checks if a sprite placed at this point might intersect with a currently placed sprite
-(BOOL)isValidPoint:(CGPoint)point forSize:(CGSize)nodeSize{
    
    //Sets up a node for comparison to make sure the object placed at this point won't intersect with another nearby
    SKNode *compNode = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:[EDMyScene add:30 toSize:nodeSize]];
    
    compNode.position = point;
    for(SKNode *node in [self children]){
        if([node intersectsNode:compNode] || [EDMyScene distanceBetweenNode:wamba andNode:compNode] < 60){
            return NO;
        }
        
        
    }
    
    
    //CHECK FOR IF THE DISTANCE BETWEEN RED BLOCKS IS LESS THAN THE MAX SIZE OF THE WAMBA (diagonal)
    

    
    return YES;
}

#pragma mark - Setter Methods
//Changes the score and updates level if necessary
-(void)changeScoreBy:(NSInteger)amt{
    if((NSInteger)score + amt < 0)score = 0;
    else{
    score += amt;
    }
    
    //Update score label
    [scoreLabel setText:[NSString stringWithFormat:@"%lu",(unsigned long)score]];
    
    //Update the difficulty if needed.
    [self updateLevel];
}
-(void)updateLevel{
    if(score%50 == 0){
        //wamba.size = [Wamba wambaSize];
        [wamba runAction:[SKAction scaleTo:[Wamba wambaSize].width/wamba.size.width duration:0.2]];
        
    }
    
    if(score == 50){
        level = 1;
    }
    else if(score == 100 && level == 1){
        level = 2;
    }
    else if(score == 150 && level == 2){
        level = 3;
    }
}

#pragma mark - Change Difficulty
-(void)setUpEasy{
    highScore = [[NSUserDefaults standardUserDefaults] integerForKey:kHighScoreKeyEasy];
    _timeStartValue = [self hasSmallScreen] ? 90.00 : 105.00;
}
-(void)setUpMedium{
    highScore = [[NSUserDefaults standardUserDefaults] integerForKey:kHighScoreKeyMedium];
    _timeStartValue = [self hasSmallScreen] ? 60.00 : 75.00;
}
-(void)setUpHard{
    highScore = [[NSUserDefaults standardUserDefaults] integerForKey:kHighScoreKeyHard];
    _timeStartValue = [self hasSmallScreen] ? 45.00 : 60.00;
    
}
-(BOOL)hasSmallScreen{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}
#pragma mark - Scene Change
-(void)gameOver{
    _gameIsRunning = NO;
    if(score > highScore){
        highScore = score;
        
        if(gameMode == easy){
            [[NSUserDefaults standardUserDefaults] setInteger:highScore forKey:kHighScoreKeyEasy];
        }
        else if(gameMode == medium){
            [[NSUserDefaults standardUserDefaults] setInteger:highScore forKey:kHighScoreKeyMedium];
        }
        else if(gameMode == hard){
            [[NSUserDefaults standardUserDefaults] setInteger:highScore forKey:kHighScoreKeyHard];
        }
        
    }
    [self presentGameOverScene];
}
-(void)presentGameOverScene{
    // Create and configure the scene.
    SKScene * scene = [[EDGameOverScene alloc] initWithSize:self.view.bounds.size score:score gameMode:gameMode];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.view.backgroundColor = [SKColor greenColor];
    
    // Present the scene.
    [self.view presentScene:scene transition:[SKTransition fadeWithColor:[SKColor grayColor] duration:0.4]];

}

#pragma mark - Setup Methods
//Initialize variables
-(void)initializeVariables{
    level = 0;
 
    _gameIsRunning = NO;
    
    [self initializeWamba];
    
    [self setUpPhysicsWorld];
	
    [self addScoreLabel];

    NSInteger bannerHeight = [[NSUserDefaults standardUserDefaults] integerForKey:kBannerHeight];
	
    SKSpriteNode *blob = [[RedBlock alloc] init];
    posYMin = blob.size.height/2 + bannerHeight;
    posXMin = blob.size.width/2;
    posXRange = self.frame.size.width - blob.size.width;
    posYRange = self.frame.size.height - (bannerHeight + blob.size.height);
	
    score = 0;
	
    
    switch (gameMode) {
        case easy:
            [self setUpEasy];
            break;
        case medium:
            [self setUpMedium];
            break;
        case hard:
            [self setUpHard];
            break;
        default:
            break;
    }
	

    _timeCount = _timeStartValue;
    
    [self addTimerLabel];
}

//Set up Physics World
-(void)setUpPhysicsWorld{
    self.physicsWorld.speed = 1;
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    //self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.contactDelegate = self;
}

//Creates and sets up the Wamba
-(void)initializeWamba{
    wamba = [[Wamba alloc] init];
    wamba.position = CGPointMake(self.size.width/2,self.size.height/2);

    //Adds the Wamba to the screen
    [self addChild:wamba];
}

//Adds a timer label
/* TODO -- make dynamically sized/position timer label */
-(void)addTimerLabel{
    timeLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    timeLabel.fontColor = [SKColor blackColor];
    timeLabel.fontSize = 25;
   //Should add text here
	timeLabel.text = [NSString stringWithFormat:@"%.2f", _timeCount/60];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSUInteger bannerHeight = [standardUserDefaults integerForKey:kBannerHeight];
    
    timeLabel.position = CGPointMake(self.size.width-35, 20 + bannerHeight );
    
    timeLabel.zPosition = 10;
    [self addChild:timeLabel];
}

//Adds a score label
/* TODO -- make dynamically sized/position score label */
-(void)addScoreLabel{
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    scoreLabel.fontColor = [SKColor blackColor];
    scoreLabel.fontSize = 25;
	scoreLabel.text = @"0";
	
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSUInteger bannerHeight = [standardUserDefaults integerForKey:kBannerHeight];
    
    scoreLabel.position = CGPointMake(50, 20 + bannerHeight );
    
    
    
    scoreLabel.zPosition = 10;
    [self addChild:scoreLabel];
}

#pragma mark - Other Helper Methods
+(NSInteger)distanceBetweenNode:(SKNode *)node1 andNode:(SKNode *)node2{
    return sqrt(pow(node2.position.x-node1.position.x,2) + pow(node2.position.y-node1.position.y,2));
}
+(CGSize)scaleSize:(CGSize)size by:(CGFloat)scale{
    return CGSizeMake(size.width*scale,size.height*scale);
}
+(CGSize)add:(NSInteger)addNum toSize:(CGSize)size{
    return CGSizeMake(size.width + addNum, size.height + addNum);
}

@end
