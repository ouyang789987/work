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


-(BOOL) shouldAutorotate
{
    
    return NO;
}

-(NSUInteger) supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
}


@end
