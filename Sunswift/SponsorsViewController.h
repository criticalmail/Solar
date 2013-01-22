//
//  SponsorsViewController.h
//  Sunswift
//
//  Created by Frank Qian on 19/01/13.
//  Copyright (c) 2013 UNSW Solar Racing Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SponsorsViewController : UIViewController
{
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIImageView *imageView1;
    IBOutlet UIImageView *imageView2;
    UIImageView *tempImageView, *bgImageView;
    
    int prevPage;
}
- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)recognizer;

@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIImageView *imageView1;
@property (nonatomic, retain) UIImageView *imageView2;
@end
