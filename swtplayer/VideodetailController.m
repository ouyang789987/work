//
//  VideodetailController.m
//  swtplayer
//
//  Created by ouyang qungang on 19/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "VideodetailController.h"

@implementation VideodetailController
@synthesize videoid;
@synthesize thumbnail;
@synthesize videotitle;
@synthesize cattitle;

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
    [super viewDidLoad];
    NSDictionary * videoobj= [[CommonFn AllvList] objectForKey:self.videoid];
    if(videoobj!=NULL)
    {
         NSString * thumbnailimg=[[CommonFn SiteUrl] stringByAppendingString:[videoobj objectForKey:@"thumbnail"]];
       [thumbnail setImageWithURL:[NSURL URLWithString:thumbnailimg]
                       placeholderImage:[UIImage imageNamed:@"nopic"] ];
        [videotitle setText:[videoobj objectForKey:@"title"]];
        [cattitle setText:[videoobj objectForKey:@"catname"]];
    }
     
}


- (void)viewDidUnload
{
    [self setThumbnail:nil];
    [self setVideotitle:nil];
    [self setCattitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





- (IBAction)GoToPlayVideo:(id)sender {
    
    //根据关系线跳转
    //[self performSegueWithIdentifier:@"goplayview" sender:self];
    
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];
    [dict setObject:self.videoid forKey:@"videoid"];
    
     NSDictionary * curvideo= [[CommonFn AllvList] objectForKey:self.videoid];
    
    NSString * vtempurl=[curvideo objectForKey:@"videopath"];
    BOOL islive=[vtempurl rangeOfString:@"://" options:NSCaseInsensitiveSearch].length>0;
    if(YES)
    {
        
     [CommonFn GoToShowView:self WithIdentifier:@"playallvideos" WithUserEntity:dict];
   
    }
    else
    {
        [CommonFn GoToShowView:self WithIdentifier:@"playcontrollerview" WithUserEntity:dict];
    
    }
    
    
}


- (IBAction)showEzine:(id)sender {
    
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];    
    
    NSDictionary * curvideo= [[CommonFn AllvList] objectForKey:self.videoid];
    [dict setObject:[curvideo objectForKey:@"ezineid"] forKey:@"ezineid"];
   [CommonFn GoToShowView:self WithIdentifier:@"goshowezine" WithUserEntity:dict];
        
     
}



- (IBAction)showEzine2:(id)sender {
    
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]init];    
    
    NSDictionary * curvideo= [[CommonFn AllvList] objectForKey:self.videoid];
    NSString * ezinelist=[curvideo objectForKey:@"ezinelist"];
    NSArray * ezineids= [ezinelist componentsSeparatedByString:@","];
    NSString * ezineid=[curvideo objectForKey:@"ezineid"];
    if([ezineids count]>0)
    {
        ezineids=ezineids[0];
    }
    [dict setObject:ezineid forKey:@"ezineid"];
    
   
    [CommonFn GoToShowView:self WithIdentifier:@"goshowezine" WithUserEntity:dict];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender  
{  
    
    PlayVideoController * segueview = segue.destinationViewController; 
    segueview.videoid = self.videoid;
}  

@end
