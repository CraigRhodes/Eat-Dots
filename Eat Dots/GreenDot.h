//
//  GreenDot.h
//  Eat Dots
//
//  Created by Craig Rhodes on 3/23/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

/*A class for a green dot. This is for creating a green dot with
 *specific characteristics, such as the specific green dot sprite.
 */


#import <SpriteKit/SpriteKit.h>

@interface GreenDot : SKSpriteNode

-(CGSize)sizeWithScale:(CGFloat)scale;

+(CGSize)greenDotSize;
+(CGSize)sizeWithScale:(CGFloat)scale;
@end
