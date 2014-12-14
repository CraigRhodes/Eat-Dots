//
//  TitleLabel.m
//  Eat Dots
//
//  Created by Craig Rhodes on 3/24/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "TitleLabel.h"



@implementation TitleLabel
-(id)init{

    return [self initWithColor:black];
}

-(id)initWithColor:(Color)color text:(NSString *)txt font:(NSString *)fontName fontSize:(NSUInteger)fSize{
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
        self.fontName = fontName;
        self.zPosition = 1;
        self.fontSize = fSize;
        self.name = kTitleLabelName;
        self.text = txt;
    }
    
    return self;
}
-(id)initWithColor:(Color)color text:(NSString *)txt font:(NSString *)fontName{
    return [self initWithColor:color text:txt font:fontName fontSize:67];
}
-(id)initWithColor:(Color)color text:(NSString *)txt{
    return [self initWithColor:color text:txt font:@"Chalkduster"];
}

-(id)initWithColor:(Color)color{
    return [self initWithColor:color text:@"" font:@"Chalkduster"];
}
@end
