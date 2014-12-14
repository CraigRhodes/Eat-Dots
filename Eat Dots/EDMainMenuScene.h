//
//  EDMainMenuScene.h
//  Eat Dots
//
//  Created by Craig Rhodes on 3/19/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

/*The main menu for the game.
 * 
 */

#import <SpriteKit/SpriteKit.h>
@class Wamba, MenuLabel, RedBlock, GreenDot, TitleLabel;



@interface EDMainMenuScene : SKScene <UIAlertViewDelegate>{
    Wamba *wamba;
    RedBlock *enemy;
    GreenDot *greenDot;
    
    MenuLabel *easyModelabel, *mediumModelabel, *hardModelabel, *backLabel;
    MenuLabel *playLabel, *howToPlayLabel, *optionsLabel, *rateLabel, *creditsLabel;
    TitleLabel *titleLabel;
    int count, posXMin, posYMin, posXRange, posYRange;
    
    NSString *currentCategory;
	
    BOOL isMoving; //Says whether or not wamba is moving
}

-(id)initWithSize:(CGSize)size;

-(void)addBannerHeight;
-(void)removeBannerHeight;


@end
