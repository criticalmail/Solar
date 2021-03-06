//
//  Weather.h
//  TestStoryboard
//
//  Created by Frank Qian on 13/01/13.
//  Copyright (c) 2013 Frank Qian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

{
    int temp;
    NSString *weatherDesc;
    NSString *iconURL;
    NSString *winddir;
    int windspeed;
    
    NSData *webData;
    UIImage *weatherIcon;
    
    //if the first update is successful, firstUpdate will be set to 1. Otherwise, it's 0.
    int firstUpdate;

}
@property (nonatomic,assign) int temp;
@property (nonatomic,assign) int windspeed;
@property (nonatomic,retain) NSString *weatherDesc;
@property (nonatomic,retain) NSString *iconURL;
@property (nonatomic,retain) NSString *winddir;
@property (nonatomic,retain) UIImage *weatherIcon;
- (void)updateWeather;

@property (nonatomic,assign) int firstUpdate;
@end
