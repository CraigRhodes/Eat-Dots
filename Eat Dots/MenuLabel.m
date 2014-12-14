//
//  MenuLabel.m
//  Eat Dots
//
//  Created by Craig Rhodes on 3/24/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "MenuLabel.h"

@implementation MenuLabel
-(id)init{
    return [self initWithColor:black andText:@""];
}
-(id)initWithText:(NSString *)text fontSize:(NSUInteger)fSize{
    return [self initWithText:text fontSize:fSize color:black];
}
-(id)initWithText:(NSString *)text fontSize:(NSUInteger)fSize color:(Color)color{
    if(self = [super init]){
        switch (color) {
                
            case white:
                self.fontColor = [SKColor whiteColor];
                break;
            case green:
                self.fontColor = [SKColor greenColor];
                break;
            case blue:
                self.fontColor = [SKColor blueColor];
                break;
            case black:
                self.fontColor = [SKColor blackColor];
                break;
            case gray:
                self.fontColor = [SKColor grayColor];
                break;
            case yellow:
                self.fontColor = [SKColor yellowColor];
                break;
            case purple:
                self.fontColor = [SKColor purpleColor];
                break;
            default:
                self.fontColor = [SKColor blackColor];
                break;
        }
        
        self.fontName = @"Chalkduster";
        self.touched = NO;
        self.zPosition = 1;
        self.fontSize = fSize;
        self.text = text;
        self.name = kMenuLabelName;
    }
    
    return self;

}

-(id)initWithColor:(Color)color{
    return [self initWithColor:color andText:@""];
}

-(id)initWithColor:(Color)color andText:(NSString *)text{
    return [self initWithText:text fontSize:30 color:color];
}
-(id)initWithText:(NSString *)text{
    return [self initWithColor:black andText:text];
}


@end
