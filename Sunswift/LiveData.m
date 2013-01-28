//
//  LiveData.m
//  LiveData
//
//  Created by Frank Qian on 10/01/13.
//  Copyright (c) 2013 Frank Qian. All rights reserved.
//

#import "LiveData.h"

@implementation LiveData
@synthesize dataID;
@synthesize speed;
@synthesize batterypower;
@synthesize arraypower;
@synthesize motorpower;
@synthesize motortemp;
@synthesize heatsinktemp;
@synthesize latitude;
@synthesize longitude;

@synthesize firstUpdate;
@synthesize inProcess;
//update information online
- (void) updateData{
    @autoreleasepool {
        if (inProcess == 1) {
            return;
        }
        inProcess = 1;
        //release version
        NSString *queryURL = [NSString stringWithFormat:@"http://sunswift.com/pass.php?get=SELECT * FROM log where id > %ld order by id desc LiMIT 1",self.dataID];
        
        //test version
        /*
        static long testID = 2124;
        NSString *queryURL = [NSString stringWithFormat:@"http://sunswift.com/pass.php?get=SELECT * FROM log where id = %ld ",testID++];
        */
        
        NSString *strURL = [queryURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //NSLog(strURL);
        NSURL *url = [NSURL URLWithString:strURL];
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
        /*if (conn != nil) {
         return;
         }
         
         
         conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
         if(conn) {
         webData = [[NSMutableData data] retain];
         }*/
        NSError *error = nil;
        NSURLResponse *resp = nil;
        webData = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&error];
        
        if (error == nil && [webData length] > 0) {
            
            
            NSLog(@"Received: %d", [webData length]);
            //NSString *strResult = [[NSString alloc] initWithBytes:[webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
            NSError *jsonerror = nil;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:webData options:NSJSONReadingAllowFragments error:&jsonerror];
            if (jsonObject != nil && jsonerror == nil){
                //NSLog(@"Successful");
                NSArray *deserializedArray = (NSArray *)jsonObject;
                //NSLog(@"Array = %@",deserializedArray);
                if ([deserializedArray count] > 0) {
                    
                    
                    NSDictionary *temp = [deserializedArray objectAtIndex:0];
                    //NSLog(@"Dic = %@",temp);
                    if ([[temp objectForKey:@"id"] longLongValue] != self.dataID) {
                        self.dataID = [[temp objectForKey:@"id"] longLongValue];
                        self.speed = [[temp objectForKey:@"speed"] doubleValue];
                        self.batterypower = [[temp objectForKey:@"batterypower"] doubleValue];
                        self.arraypower = [[temp objectForKey:@"arraypower"] doubleValue];
                        self.motorpower = [[temp objectForKey:@"motorpower"] doubleValue];
                        self.motortemp = [[temp objectForKey:@"motortemp"] doubleValue];
                        self.heatsinktemp = [[temp objectForKey:@"heatsinktemp"] doubleValue];
                        self.latitude = [[temp objectForKey:@"latitude"] doubleValue]/60000;
                        self.longitude = [[temp objectForKey:@"longitude"] doubleValue]/60000;
                        
                    }
                }
            }
        }
        else {
            NSLog(@"error");
        }
        firstUpdate = 1;
        inProcess = 0;
    }
}


@end
