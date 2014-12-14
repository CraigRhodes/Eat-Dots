//
//  RedBlock.m
//  Eat Dots
//
//  Created by Craig Rhodes on 3/23/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "RedBlock.h"

@implementation RedBlock
-(id)init{
    return [self initWithSize:[RedBlock redBlockSize]];
}
-(id)initWithSize:(CGSize) size{
    if(self = [super initWithImageNamed:@"enemy-blob"]){
        self.name = (NSString *)kRedEnemyName;
        self.size = size;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.categoryBitMask = npcCategory;
        self.xScale = 1.0;
        self.yScale = 1.0;
        self.physicsBody.contactTestBitMask = wambaCategory;
        self.physicsBody.collisionBitMask = 0x1 << 6;
        self.zPosition = 0;
    }
    return self;
}

-(CGSize)sizeWithScale:(CGFloat)scale{
    return CGSizeMake(self.size.width*scale, self.size.height*scale);
}

+(CGSize)redBlockSize{
    return CGSizeMake(30, 30);
}
+(CGSize)sizeWithScale:(CGFloat)scale{
    return CGSizeMake([RedBlock redBlockSize].width*scale, [RedBlock redBlockSize].height*scale);
}

@end
