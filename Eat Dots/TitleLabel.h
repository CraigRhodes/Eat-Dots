//
//  TitleLabel.h
//  Eat Dots
//
//  Created by Craig Rhodes on 3/24/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

/*A class that creates a Title Label. These are just labels
 * that do not act as buttons for the menu but just show text.
 */


#import <SpriteKit/SpriteKit.h>



@interface TitleLabel : SKLabelNode
-(id)initWithColor:(Color)color;
-(id)initWithColor:(Color)color text:(NSString *)txt;
-(id)initWithColor:(Color)color text:(NSString *)txt font:(NSString *)fontName;
-(id)initWithColor:(Color)color text:(NSString *)txt font:(NSString *)fontName fontSize:(NSUInteger)fSize;
@end
