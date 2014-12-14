//
//  EDViewController.h
//  Eat Dots
//

//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//


/*Manages the view. This has methods that allow you to know
 * when the view has finished loading, when the view's going 
 * to disappear, etc.
 */

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>

@interface EDViewController : UIViewController <ADBannerViewDelegate>{
    SKView * skView;
}



@property(nonatomic, strong) IBOutlet ADBannerView *banner;

@end
