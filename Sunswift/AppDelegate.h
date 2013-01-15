//
//  AppDelegate.h
//  Sunswift
//
//  Created by Joshua CHIN on 7/01/13.
//  Copyright (c) 2013 UNSW Solar Racing Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveData.h"
#import "Weather.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    LiveData *liveData;
    Weather *weather;
}
@property (nonatomic, readonly) LiveData *liveData;
@property (nonatomic, readonly) Weather *weather;


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarContoller;

@end
