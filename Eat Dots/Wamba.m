//
//  Wamba.m
//  Eat Dots
//
//  Created by Craig Rhodes on 3/23/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "Wamba.h"

@implementation Wamba
-(id)init{
    if(self = [super initWithImageNamed:@"wamba"]){
        isInjured = NO;
        self.name = kWambaName;
        
        //Set the size of the Wamba
        self.size = [Wamba wambaSize];
        
        //Create the physics body with a rectangle approximately the size of the wamba
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        
        //Makes Wamba not affected by gravity or other objects
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.xScale = 1.0;
        self.yScale = 1.0;
        
        //Set contact bitMasks
        self.physicsBody.categoryBitMask = wambaCategory;
        self.physicsBody.contactTestBitMask = npcCategory;
        self.physicsBody.collisionBitMask = noCollisionCategory;
        
        
        //Puts Z Position in front
        [self setZPosition:1];

    }
    return self;
}

-(CGSize)sizeWithScale:(CGFloat)scale{
    return CGSizeMake(self.size.width*scale, self.size.height*scale);
}

+(CGSize)wambaSize{
    return CGSizeMake(30, 30);
}
+(CGSize)sizeWithScale:(CGFloat)scale{
    return CGSizeMake([Wamba wambaSize].width*scale, [Wamba wambaSize].height*scale);
}

@end
