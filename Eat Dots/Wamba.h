//
//  Wamba.h
//  Eat Dots
//
//  Created by Craig Rhodes on 3/23/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

/*A class for the Wamba. This is for creating a Wamba with 
 *specific characteristics, such as the specific Wamba image.
 */

#import <SpriteKit/SpriteKit.h>

@interface Wamba : SKSpriteNode{
    BOOL isInjured;
}


-(CGSize)sizeWithScale:(CGFloat)scale;

+(CGSize)wambaSize;
+(CGSize)sizeWithScale:(CGFloat)scale;


@end
