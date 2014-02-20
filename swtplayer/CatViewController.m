//
//  CatViewController.m
//  swtplayer
//
//  Created by ouyang qungang on 19/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "CatViewController.h"

@implementation CatViewController

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
    NSMutableArray *array=[[NSMutableArray alloc]init];
     
    for(NSString * vid in [CommonFn CatList])
    {
         [array addObjectsFromArray:[[CommonFn CatVideoList]objectForKey:vid] ];        
    }     
    self.videolist = array; 
    self.sectionids=[[CommonFn CatVideoList] allKeys];   
    self.sectionDict=[CommonFn CatVideoList];
    self.videotable.delegate=self;
    self.videotable.dataSource=self;  
        
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sectionids count];
    
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{
    NSInteger num= 0;    
    num=[[self.sectionDict objectForKey:[self.sectionids objectAtIndex:section]] count]; 
    if(num>4)
    {
        num=4;
    }
    return num;
}


- (NSString *)tableView:(UITableView *)tableView

titleForHeaderInSection:(NSInteger)section {
    
    NSString *key = [self.sectionids objectAtIndex:section];
    NSString * title= [[[CommonFn CatList] objectForKey:key]objectForKey:@"title"];
    return title;
    
}


/*
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    return [[CommonFn CatVideoList] allKeys];
    
}
*/


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
