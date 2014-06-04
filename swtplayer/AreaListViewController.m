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




- (void)viewDidUnload
{
    [self setVideotable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)viewDidLoad
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    for(NSString * vid in [CommonFn AreaList])
    {
        [array addObjectsFromArray:[[CommonFn AreaVideoList]objectForKey:vid] ];
    }
    self.videolist = array;
    self.sectionids=[[CommonFn AreaVideoList] allKeys];
    self.sectionDict=[CommonFn AreaVideoList];
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
    NSString * title= [[[CommonFn AreaList] objectForKey:key]objectForKey:@"title"];
    return title;
    
}


/*
 - (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
 
 return [[CommonFn CatVideoList] allKeys];
 
 }
 */





@end
