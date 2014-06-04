//
//  ManagerViewController.m
//  stroyboarddemo
//
//  Created by marcus on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AreaViewController.h"


@implementation AreaViewController

@synthesize videotable;
@synthesize areastr;
@synthesize videolist = _list; 
@synthesize nibsRegistered;
@synthesize sectionids;
@synthesize sectionDict;
@synthesize segueview;
@synthesize selectvideoid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         nibsRegistered = NO;
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
    self.navigationController.navigationBar.translucent=NO;
   
    [super viewDidLoad];
    //areastr=[areastr stringByAppendingFormat:@"ouyang"];
    [[self navigationItem] setTitle:areastr]; 
    
    //NSArray *array = [[NSArray alloc] initWithObjects:@"美国", @"菲律宾",@"黄岩岛", @"中国", @"泰国", @"越南", @"老挝",@"日本" , nil];
    
    NSString * curareaid=@"";
    
    for(NSString * areaid in [CommonFn AreaList])
    {
        NSDictionary * ezine=[[CommonFn AreaList] objectForKey:areaid];
        if([[ezine objectForKey:@"title"] isEqualToString:areastr])
        {
            curareaid=[ezine objectForKey:@"id"];
        }
    }
    
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    for(NSString * vid in [CommonFn AllvList])
    {
        NSDictionary * vitem=[[CommonFn AllvList] objectForKey:vid];
        if([[vitem objectForKey:@"videoarea"] isEqualToString:curareaid])
        {
            [array addObject:vitem];
        }
    }
    
    
    
    self.videolist = array;
    self.sectionDict=[CommonFn CatVideoList];
    videotable.delegate=self;
    videotable.dataSource=self;    
    //videotable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //去掉分割线
    
}


- (UIImage *) scaleToSize:(UIImage *)img resize:(CGSize)newsize{  
    
    // 创建一个bitmap的context  
    
    // 并把它设置成为当前正在使用的context  
    
    UIGraphicsBeginImageContext(newsize);  
    
    // 绘制改变大小的图片  
    
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];  
    
    // 从当前context中创建一个改变大小后的图片  
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();  
    
    // 使当前的context出堆栈  
    
    UIGraphicsEndImageContext();  
    
    // 返回新的改变大小后的图片  
    
    return scaledImage;  
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView   
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {   
    
    
    /*
     
    // 默认tablecell样式
    static NSString *TableSampleIdentifier = @"CustomCellIdentifier";   
     UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];   
    
    if (cell == nil) {   
        cell = [[UITableViewCell alloc]   
                initWithStyle:UITableViewCellStyleSubtitle   
                reuseIdentifier:TableSampleIdentifier] ;   
    }   
     
     
     //设置图片大小
     UIImageView * img =cell.imageView;
     
     CGSize imagesize=CGSizeMake(250.0, 150.0);      
     
     [cell.imageView setImage:[img.image ReSizeTo:imagesize]];
     
    */
    
    
    //自定义tablecell
    static NSString * CustomCellIdentifier = @"MyCustomCellIdentifier";
    
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (cell == nil) {   
        cell = [[CustomCell alloc]   
                initWithStyle:UITableViewCellStyleSubtitle   
                reuseIdentifier:CustomCellIdentifier] ;   
    }   
    
    NSDictionary * temvideo;
    
    NSUInteger section = [indexPath section];
   
    NSUInteger row = [indexPath row]; 
    if (self.sectionids==NULL) {
       temvideo =[self.videolist objectAtIndex:row];
    }
    else
    {
       temvideo = [[self.sectionDict objectForKey:[self.sectionids objectAtIndex:section]] objectAtIndex:row];
        
    }
    
    cell.textLabel.text = [temvideo objectForKey:@"title"];   
    cell.detailTextLabel.text=[temvideo objectForKey:@"catname"];
    [cell.detailTextLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    //UIImage *image = [UIImage imageNamed:@"37x-Checkmark"];   
    //cell.imageView.image = image;     
    //cell.imageView.contentMode = UIViewContentModeScaleAspectFill;    
    NSString * thumbnail=[[CommonFn SiteUrl] stringByAppendingString:[temvideo objectForKey:@"thumbnail"]];
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:thumbnail]
                  placeholderImage:[UIImage imageNamed:@"nopic"] ];
  
    
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onVideoClickImage:)]; 
    singleTap.numberOfTapsRequired=1;
    singleTap.numberOfTouchesRequired=1;
    [cell.imageView addGestureRecognizer:singleTap];
    [cell.imageView setUserInteractionEnabled:YES];
    
    //[[singleTap view]setTag:[temvideo objectForKey:@"id"]];
    
    //UIImage *highLighedImage = [UIImage imageNamed:@"37x-Checkmark"];   
    //cell.imageView.highlightedImage = highLighedImage;
    //NSLog(@"row %d ,%@",[indexPath row],[self.videolist objectAtIndex:row]);
    
    return cell;
    
}  




- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{
    NSInteger num= 0;
    if(self.sectionids==NULL)
    {
       num=[self.videolist count];
     }
    else
    {
       num=[[self.sectionDict objectForKey:[self.sectionids objectAtIndex:section]] count];        
    }
    
    if(num>10)
    {
        num=10;
    }
    return num;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 91.5;  
}  


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
}

- (void)viewDidUnload
{
    [self setVideotable:nil];
    [super viewDidUnload];
    self.videolist = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

 

-(IBAction)onClickButton:(id)sender
{
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"second" bundle:nil];
    [self presentModalViewController:[stryBoard instantiateInitialViewController] animated:YES];
}



-(void)onVideoClickImage:(UITapGestureRecognizer *)sender
{
    
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
   // NSLog(@"view class %@",[[[[singleTap view] superview]superview] class]);
   // NSLog(@"view class 2 %@",[[[[[singleTap view] superview]superview]superview] class]);
    
    UIView * curcellview=[[[singleTap view] superview]superview];
    
    if(![curcellview isKindOfClass:[CustomCell class]])
    {
        curcellview=[[[[singleTap view] superview]superview]superview];
    }
    
    NSIndexPath * indexPath= [self.videotable indexPathForCell:(CustomCell *)curcellview ];
    NSDictionary * temvideo;
    
    NSUInteger section = [indexPath section];
    
    NSUInteger row = [indexPath row]; 
    if (self.sectionids==NULL) {
        temvideo =[self.videolist objectAtIndex:row];
    }
    else
    {
        temvideo = [[self.sectionDict objectForKey:[self.sectionids objectAtIndex:section]] objectAtIndex:row];
        
    }    
    self.selectvideoid = [temvideo objectForKey:@"id"];
    //NSLog(@"curid %@",self.selectvideoid);
    [self performSegueWithIdentifier:@"govideodetail" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender  
{  
    
    segueview = segue.destinationViewController; 
    segueview.videoid = self.selectvideoid;
}  


@end
