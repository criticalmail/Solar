//
//  MyAnnotation.m
//  TestStoryboard
//
//  Created by Frank Qian on 12/01/13.
//  Copyright (c) 2013 Frank Qian. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
@synthesize coordinate = _coordinate;
- (id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubTitle{
    self = [super init];
    
    if (self != nil) {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubTitle;
    }
    
    return(self);
}


- (void)dealloc{
    [_title release];
    [_subtitle release];
    [super dealloc];
}
@end
