//
//  LiveData.h
//  LiveData
//
//  Created by Frank Qian on 10/01/13.
//  Copyright (c) 2013 Frank Qian. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LiveData : NSObject

{
    long dataID;
    double speed;
    double batterypower;
    double arraypower;
    double motorpower;
    double motortemp;
    double heatsinktemp;
    double latitude;
    double longitude;
    //NSURLConnection *conn;
    NSData *webData;
    
    int firstUpdate;
    int inProcess;
}
@property (nonatomic,assign) long dataID;
@property (nonatomic,assign) double speed;
@property (nonatomic,assign) double batterypower;
@property (nonatomic,assign) double arraypower;
@property (nonatomic,assign) double motorpower;
@property (nonatomic,assign) double motortemp;
@property (nonatomic,assign) double heatsinktemp;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;
-(void) updateData;

@property (nonatomic,assign) int firstUpdate;
@property (nonatomic,assign) int inProcess;
@end
