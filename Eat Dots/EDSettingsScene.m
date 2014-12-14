//
//  EDSettingsScene.m
//  Eat Dots
//
//  Created by Craig Rhodes on 3/19/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//


/*
#import "EDSettingsScene.h"

@implementation EDSettingsScene

#pragma mark - Init methods

-(id)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        [self setUpLabels];
    }
    return self;
}

-(void)setUpLabels{
    
    //        Title Label Starts
    
    titleLabel = [[TitleLabel alloc] init];
    titleLabel.text = @"Options";
    titleLabel.position = CGPointMake(self.frame.size.width/2,self.frame.size.height - 70);
    titleLabel.fontColor = [SKColor whiteColor];
    
    
    //Adjusts the label size to a size that fits on the screen.
    while(titleLabel.frame.size.width >= self.frame.size.width)titleLabel.fontSize--;
    
    //     END TITLE LABEL
    
    
    
    
    
    
    
    
    //Finally, add the labels to the screen.
    [self addChildren:@[ titleLabel ] ];
    
}

//Helper method to add an array of labels/objects at the same time
-(void)addChildren:(NSArray *)children{
    for(SKNode * child in children){
        [self addChild:child];
    }
}

#pragma mark - Touch methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        CGPoint touch = [touches.anyObject locationInNode:self];
        MenuLabel *label = (MenuLabel *)node;
        
        //If label is the one touched, set touched property to YES.
        if([label containsPoint:touch]){
            [label setTouched:YES];
            *stop = YES;
        }
    }];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        CGPoint touch = [touches.anyObject locationInNode:self];
        MenuLabel *label = (MenuLabel *)node;
        if([label touched] && [label containsPoint:touch]){
            if([label.text isEqualToString:@"Music Volume"]){
                
            }
            else if([label.text isEqualToString:@"SFX Volume"]){
                
            }
        }
    }];
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        [(MenuLabel *)node setTouched:NO];
    }];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self enumerateChildNodesWithName:kMenuLabelName usingBlock:^(SKNode *node, BOOL *stop) {
        [(MenuLabel *)node setTouched:NO];
    }];
}

#pragma mark - Update loop
-(void)update:(CFTimeInterval)currentTime {
    
}

#pragma mark - Functions

@end
*/
