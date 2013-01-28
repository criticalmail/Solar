//
//  Weather.m
//  TestStoryboard
//
//  Created by Frank Qian on 13/01/13.
//  Copyright (c) 2013 Frank Qian. All rights reserved.
//

#import "Weather.h"
#import "AppDelegate.h"
@implementation Weather
@synthesize weatherIcon;
@synthesize weatherDesc;
@synthesize iconURL;
@synthesize winddir;
@synthesize temp;
@synthesize windspeed;
@synthesize firstUpdate;
- (void)dealloc{
    [weatherIcon release];
    [weatherDesc release];
    [iconURL release];
    [winddir release];
    [super dealloc];
}
- (void)updateWeather{
    @autoreleasepool {
        
        
        AppDelegate *dele = [[UIApplication sharedApplication] delegate];
        LiveData *liveData = dele.liveData;
        double latitude;
        double longitude;
        
        while (!liveData.firstUpdate) {
            ;
        }
        if (liveData.latitude == 0 || liveData.longitude == 0) {
            latitude = -33.916869;
            longitude = 151.229916;
        }
        else{
            latitude = liveData.latitude;
            longitude = liveData.longitude;
        }
        NSString *queryURL = [NSString stringWithFormat:@"http://free.worldweatheronline.com/feed/weather.ashx?q=%f,%f&format=json&num_of_days=1&fx=no&key=16c149d515032400131301",latitude,longitude];
        
        
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
            NSError *jsonerror = nil;
            
            
            id jsonObject = [NSJSONSerialization JSONObjectWithData:webData options:NSJSONReadingAllowFragments error:&jsonerror];
            if (jsonObject != nil && jsonerror == nil){
                //NSLog(@"Successful");
                NSDictionary *deserializedDic = (NSDictionary *)jsonObject;
                //NSLog(@"Array = %@",deserializedArray);
                if ([deserializedDic count] > 0) {
                    
                    
                    NSDictionary *data = [deserializedDic objectForKey:@"data"];
                    //NSLog(@"Dic = %@",temp);
                    if ([data count] > 1) {
                        NSArray *currentCondition = [data objectForKey:@"current_condition"];
                        if ([currentCondition count] > 0) {
                            NSDictionary *tempData = [currentCondition objectAtIndex:0];
                            if ([tempData count] > 0) {
                                self.temp = [[tempData objectForKey:@"temp_C"] intValue];
                                self.windspeed = [[tempData objectForKey:@"windspeedKmph"] intValue];
                                self.winddir = [tempData objectForKey:@"winddir16Point"];
                                NSArray *wDC = [tempData objectForKey:@"weatherDesc"];
                                if ([wDC count]>0) {
                                    NSDictionary *wDCtemp = [wDC objectAtIndex:0];
                                    if ([wDCtemp count]>0) {
                                        self.weatherDesc = [wDCtemp objectForKey:@"value"];
                                    }
                                }
                                wDC = [tempData objectForKey:@"weatherIconUrl"];
                                
                                if ([wDC count]>0) {
                                    NSDictionary *wDCtemp = [wDC objectAtIndex:0];
                                    if ([wDCtemp count]>0) {
                                        self.iconURL = [wDCtemp objectForKey:@"value"];
                                        NSLog(@"data received.");
                                        if (self.iconURL != nil) {
                                            NSString *strURL = [self.iconURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                            
                                            NSURL *url = [NSURL URLWithString:strURL];
                                            
                                            NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
                                            NSError *error = nil;
                                            NSURLResponse *resp = nil;
                                            webData = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&error];
                                            if (error == nil && [webData length] > 0) {
                                                
                                                
                                                
                                                self.weatherIcon = [UIImage imageWithData:webData];
                                                self.firstUpdate = 1;
                                                NSLog(@"icon received");
                                            }
                                            
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
        else{
            
            NSLog(@"error");
        }
    }
}

@end
