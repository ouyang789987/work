//
//  AreaListViewController.m
//  swtplayer
//
//  Created by ouyang qungang on 23/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "AreaListViewController.h"

@implementation AreaListViewController
@synthesize videotable;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
     NSLog(@"area list count %d",[[CommonFn CatList] count]);
    for(NSString * vid in [CommonFn CatList])
    {
        NSDictionary * vcat=[[CommonFn CatList] objectForKey:vid];
        NSRange foundObj=[[vcat objectForKey:@"title"] rangeOfString:@"直播" options:NSCaseInsensitiveSearch]; 
        if(foundObj.length<1)
        {
            [array addObjectsFromArray:[[CommonFn CatVideoList]objectForKey:vid] ];
        }
    }
    NSLog(@"area list count %d",[array count]);
    self.videolist = array; 
    self.videotable.delegate=self;
    self.videotable.dataSource=self;  
    
}


- (void)viewDidUnload
{
    [self setVideotable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

 

@end
