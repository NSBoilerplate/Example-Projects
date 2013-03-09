//
//  BPAppDelegate.m
//  Boilerplate
//
//  Created by Jeffrey Sambells on 2013-03-04.
//  Copyright (c) 2013 Boilerplate. All rights reserved.
//

#import "BPAppDelegate.h"
#import <UISS/UISS.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

#if RUN_KIF_TESTS
#import "BPUITestController.h"
#endif

#define DEFAULTS_AUTHENTICATION_KEY @"Authentication"

@interface BPAppDelegate()

@end

@implementation BPAppDelegate

#pragma mark - Setters & Getters

- (BOOL)isAuthenicated {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:DEFAULTS_AUTHENTICATION_KEY] boolValue];
}

- (void)setAuthenticated:(BOOL)authenticated {
    [[NSUserDefaults standardUserDefaults] setBool:authenticated
                                            forKey:DEFAULTS_AUTHENTICATION_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Application Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
    [[NSUserDefaults standardUserDefaults] addObserver:self
                                            forKeyPath:DEFAULTS_AUTHENTICATION_KEY
                                               options:NSKeyValueObservingOptionNew
                                               context:NULL];
 
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

    UISS *uiss = [UISS configureWithJSONFilePath:@"appearance.json"];
#if DEBUG
    [uiss setStatusWindowEnabled:YES];
#endif
    
#if RUN_KIF_TESTS
    [[BPUITestController sharedInstance] startTestingWithCompletionBlock:^{
        // Exit after the tests complete so that CI knows we're done
        exit([[BPUITestController sharedInstance] failureCount]);
    }];
#endif

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Authentication

- (void)observeValueForKeyPath:(NSString *) keyPath ofObject:(id) object change:(NSDictionary *) change context:(void *) context
{
    if([keyPath isEqualToString:DEFAULTS_AUTHENTICATION_KEY])
    {
        NSLog(@"%@ change: %@", DEFAULTS_AUTHENTICATION_KEY, change);
        
        if ([change[@"new"] boolValue]) {
            // Hide authentication
            if ([self.window.rootViewController.presentedViewController isKindOfClass:[UIViewController class]]) {
                [self.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
            }
        } else {
            // Show Authentication
            [self.window.rootViewController performSegueWithIdentifier:@"AuthenticateSegue" sender:self];
        }
    }
}

@end
