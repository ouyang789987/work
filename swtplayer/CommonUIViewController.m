//
//  CommonUIViewController.m
//  swtplayer
//
//  Created by ouyang qungang on 21/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "CommonUIViewController.h"


@implementation CommonUIViewController
 

@synthesize userEntity;
@synthesize HUD;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.translucent=NO;
    self.tabBarController.tabBar.translucent=NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [super viewDidLoad];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL) shouldAutorotate
{
    
    return NO;
}

-(NSUInteger) supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
}


@end
