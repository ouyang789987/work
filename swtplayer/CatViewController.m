//
//  CatViewController.m
//  swtplayer
//
//  Created by ouyang qungang on 19/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "CatViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation CatViewController



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



- (IBAction)refreshdata:(id)sender {
    
    NSString * actionurl=[[CommonFn SiteUrl] stringByAppendingString:@"ajax.aspx?action=getvideojson&type=getalldataontime"];
    NSURL  *url = [NSURL URLWithString:actionurl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    [CommonFn ShowTextInfo:@"正在更新" OntheView:self];
    
}


-(void)requestFinished:(ASIHTTPRequest *)request

{
    //  Use when fetching text data
    
    
   
    NSLog(@"code %d OK 222",[request responseStatusCode]);
    //    Use when fetching binary data
    //NSData   * responseData = [request responseData];
    if([request responseStatusCode]==200)
    {
       NSString  *responseString = [request responseString];
       NSString * fname=[CommonFn JsonFileName];
       [CommonFn writeNSStringData:responseString writeFileName:fname];
       [CommonFn ParseJsonData:responseString];
    }
    
    [CommonFn ShowTextInfo:@"更新成功" OntheView:self];
 
}



-(void)requestFailed:(ASIHTTPRequest  *)request
{
    
    [CommonFn ShowTextInfo:@"网络错误" OntheView:self];
}

@end
