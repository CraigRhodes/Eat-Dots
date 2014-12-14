//
//  RedBlock.h
//  Eat Dots
//
//  Created by Craig Rhodes on 3/23/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

/*A class for a red enemy. This is for creating a red enemy with
 *specific characteristics, such as the specific red block sprite.
 */

#import <SpriteKit/SpriteKit.h>

@interface RedBlock : SKSpriteNode

-(CGSize)sizeWithScale:(CGFloat)scale;
-(id)initWithSize:(CGSize)size;

+(CGSize)redBlockSize;
+(CGSize)sizeWithScale:(CGFloat)size;
@end
