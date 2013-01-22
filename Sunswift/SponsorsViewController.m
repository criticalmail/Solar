//
//  SponsorsViewController.m
//  Sunswift
//
//  Created by Frank Qian on 19/01/13.
//  Copyright (c) 2013 UNSW Solar Racing Team. All rights reserved.
//

#import "SponsorsViewController.h"

@interface SponsorsViewController ()

@end

@implementation SponsorsViewController
@synthesize pageControl;
@synthesize imageView1,imageView2;



- (void)viewDidLoad
{
    
    [imageView1 setImage:[UIImage imageNamed:@"iMac_old.jpeg"]];
    tempImageView = imageView1;
    
    [imageView1 setHidden:NO];
    [imageView2 setHidden:YES];
    
    [pageControl addTarget:self action:@selector(pageTurning:) forControlEvents:UIControlEventValueChanged];
    prevPage = 0;
    [super viewDidLoad];
	
}

- (void)pageTurning: (UIPageControl *) pageController {
    NSInteger nextPage = [pageController currentPage];
    switch (nextPage) {
        case 0:
            [tempImageView setImage:[UIImage imageNamed:@"iMac_old.jpeg"]];
            break;
        case 1:
            [tempImageView setImage:[UIImage imageNamed:@"iMac.jpeg"]];
            break;
        case 2:
            [tempImageView setImage:[UIImage imageNamed:@"Mac8100.jpeg"]];
            break;
        case 3:
            [tempImageView setImage:[UIImage imageNamed:@"MacPlus.jpeg"]];
            break;
        case 4:
            [tempImageView setImage:[UIImage imageNamed:@"MacSE.jpeg"]];
            break;
        default:
            break;
    }
    
    
    if (tempImageView.tag == 0) {
        tempImageView = imageView2;
        bgImageView = imageView1;
    }
    else {
        tempImageView = imageView1;
        bgImageView = imageView2;
    }
    
    UIViewAnimationOptions transitionOption;
    
    if (nextPage > prevPage) {
        transitionOption = UIViewAnimationOptionTransitionCrossDissolve;
    }
    else {
        transitionOption = UIViewAnimationOptionTransitionCrossDissolve;
    }
    
    [UIView transitionWithView:tempImageView duration:0.5 options:transitionOption animations:^{
        [tempImageView setHidden:YES];
    }completion:NULL];
    
    [UIView transitionWithView:bgImageView duration:0.5 options:transitionOption animations:^{
        [bgImageView setHidden:NO];
    }completion:NULL];
    
    prevPage = nextPage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)recognizer
{
    NSInteger currentPage = pageControl.currentPage;

    if (recognizer.direction & UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
        switch (currentPage) {
            case 0:
                pageControl.currentPage = 1;
                break;
            case 1:
                pageControl.currentPage = 2;
                break;
            case 2:
                pageControl.currentPage = 3;
                break;
            case 3:
                pageControl.currentPage = 4;
                break;
            default:
                break;
        }
        if (currentPage != 4) {
            [self pageTurning:pageControl];
        }
    }
    else if (recognizer.direction & UISwipeGestureRecognizerDirectionRight){
        NSLog(@"swipe right");
        switch (currentPage) {
            case 1:
                pageControl.currentPage = 0;
                break;
            case 2:
                pageControl.currentPage = 1;
                break;
            case 3:
                pageControl.currentPage = 2;
                break;
            case 4:
                pageControl.currentPage = 3;
                break;
            default:
                break;
        }
        if (currentPage != 0) {
            [self pageTurning:pageControl];
        }

    }
}

- (void)dealloc
{
    [pageControl release];
    [imageView1 release];
    [imageView2 release];
    [super dealloc];
}
@end
