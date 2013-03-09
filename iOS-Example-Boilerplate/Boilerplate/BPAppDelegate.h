//
//  BPAppDelegate.h
//  Boilerplate
//
//  Created by Jeffrey Sambells on 2013-03-04.
//  Copyright (c) 2013 Boilerplate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, getter=isAuthenicated) BOOL authenticated;

@end
