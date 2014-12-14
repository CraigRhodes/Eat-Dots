//
//  GreenDot.m
//  Eat Dots
//
//  Created by Craig Rhodes on 3/23/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "GreenDot.h"

@implementation GreenDot
-(id)init{
    if(self = [super initWithImageNamed:@"green-dot"]){
        self.name = (NSString *) kGreenDotName;
        self.size = [GreenDot greenDotSize];
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:15];
        self.physicsBody.dynamic = NO;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.categoryBitMask = npcCategory;
        self.xScale = 1.0;
        self.yScale = 1.0;
        self.physicsBody.contactTestBitMask = wambaCategory;
        self.physicsBody.collisionBitMask = 0x1 << 5;
        self.zPosition = 0;
    }
    return self;
}

-(CGSize)sizeWithScale:(CGFloat)scale{
    return CGSizeMake(self.size.width*scale, self.size.height*scale);
}

+(CGSize)greenDotSize{
    return CGSizeMake(30, 30);
}
+(CGSize)sizeWithScale:(CGFloat)scale{
    return CGSizeMake([GreenDot greenDotSize].width*scale, [GreenDot greenDotSize].height*scale);
}

@end
