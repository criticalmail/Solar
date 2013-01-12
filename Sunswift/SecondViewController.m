//
//  SecondViewController.m
//  Sunswift
//
//  Created by Joshua CHIN on 7/01/13.
//  Copyright (c) 2013 UNSW Solar Racing Team. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
- (void)viewDidLoad
{

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 2;
    label.font = [UIFont boldSystemFontOfSize: 14.0f];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];

    label.textColor = [UIColor blackColor];
    label.text = @"This is a\nmultiline string";
    
    self.navigationController.navigationItem.titleView = label;

    
    
    [label release];
    

    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 **/
@end
