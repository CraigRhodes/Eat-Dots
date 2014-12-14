//
//  MenuLabel.h
//  Eat Dots
//
//  Created by Craig Rhodes on 3/24/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

/*A class that creates a Menu Label. These are labels
 * that can act as buttons on the menu.
 */


#import <SpriteKit/SpriteKit.h>


@interface MenuLabel : SKLabelNode

@property(nonatomic) BOOL touched;

-(id)initWithColor:(Color)color;
-(id)initWithText:(NSString *)text;
-(id)initWithText:(NSString *)text fontSize:(NSUInteger)fSize;
-(id)initWithColor:(Color)color andText:(NSString *)text;

@end
