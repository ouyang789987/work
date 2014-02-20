//
//  PlayVideoController.m
//  swtplayer
//
//  Created by ouyang qungang on 20/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "PlayVideoController.h"

@implementation PlayVideoController
@synthesize videoid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
 
}
*/

 
- (void)viewDidLoad
{
    [super viewDidLoad];
     NSLog(@"this is play videoid %@",self.videoid);
    /*
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    CGPoint center = CGPointMake(frame.origin.x + ceil(frame.size.width/2), frame.origin.y + ceil(frame.size.height/2));
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
    [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationLandscapeRight animated:YES];
    
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    
    //（获取当前电池条动画改变的时间）
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView commitAnimations];
     */
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (IBAction)closeView:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
