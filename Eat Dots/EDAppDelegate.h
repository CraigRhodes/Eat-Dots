//
//  EDAppDelegate.h
//  Eat Dots
//
//  Created by Craig Rhodes on 3/25/14.
//  Copyright (c) 2014 Callisto Game Studios. All rights reserved.
//

/*This class provides a way for the application to receive messages such as
 * when the application is about to close, or when the application finished loading,
 * or even when the app is about to be in the background
 */

#import <UIKit/UIKit.h>

@interface EDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
