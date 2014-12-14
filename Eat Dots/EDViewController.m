//
//  EDViewController.m
//  Eat Dots
//
//  Created by Craig Rhodes on 3/19/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

#import "EDViewController.h"
#import "EDMyScene.h"
#import "EDMainMenuScene.h"
#import "EDHowToPlayScene.h"

@implementation EDViewController

#pragma mark - Ad Banner
-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    [_banner setHidden:NO];
    //[[NSNotificationCenter defaultCenter] postNotificationName:kBannerLoadedNotification object:nil];
    
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{

    [_banner setHidden:YES];
    //[[NSNotificationCenter defaultCenter] postNotificationName:kBannerNotLoadedNotification object:nil];
    
}
-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    
}



#pragma mark - View methods
- (void)viewDidLoad
{
    [super viewDidLoad];

    /*
    //Add the banner
    _banner = [[ADBannerView alloc] initWithFrame:CGRectZero];
    _banner.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:_banner];
    */
    [_banner setHidden:YES];
    self.banner.delegate = self;
    
    
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)viewDidLayoutSubviews{
   /*
    if (self.banner.bannerLoaded) {
        CGRect contentFrame = self.view.bounds;
        CGRect bannerFrame = self.banner.frame;
        contentFrame.size.height -= self.banner.frame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
        self.banner.frame = bannerFrame;
    }
    */
}
-(void)viewWillLayoutSubviews{
    // Configure the view.
    skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    [[NSUserDefaults standardUserDefaults] setInteger:_banner.frame.size.height forKey:kBannerHeight];
  
  
    
    SKScene * scene = [[EDMainMenuScene alloc] initWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;

    
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
