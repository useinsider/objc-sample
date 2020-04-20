//
//  AppDelegate.h
//  InsiderDemo
//
//  Created by Insider on 30.03.2020.
//  Copyright © 2020 Insider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <InsiderMobile/Insider.h>
#import <UserNotifications/UserNotifications.h>
#import <InsiderMobile/InsiderCallbackTypeEnum.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>
@property (strong, nonatomic) UIWindow * window;

@end

