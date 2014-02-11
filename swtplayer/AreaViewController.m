//
//  ManagerViewController.m
//  stroyboarddemo
//
//  Created by marcus on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AreaViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+UIImageExtras.h"
#import "CustomCell.h"

@implementation AreaViewController

@synthesize videotable;
@synthesize areastr;
@synthesize videolist = _list; 

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
    //areastr=[areastr stringByAppendingFormat:@"ouyang"];
    [[self navigationItem] setTitle:areastr]; 
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"美国", @"菲律宾",  
                      @"黄岩岛", @"中国", @"泰国", @"越南", @"老挝",  
                      @"日本" , nil];   
    self.videolist = array;   
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
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
        
    NSUInteger row = [indexPath row]; 
    cell.textLabel.text = [self.videolist objectAtIndex:row];   
    cell.detailTextLabel.text=[self.videolist objectAtIndex:row];
    [cell.detailTextLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    //UIImage *image = [UIImage imageNamed:@"37x-Checkmark"];   
    //cell.imageView.image = image;     
    //cell.imageView.contentMode = UIViewContentModeScaleAspectFill;    
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://ty.tvsht.com/uploadfile/20131212174612862.jpg"]
                  placeholderImage:[UIImage imageNamed:@"37x-Checkmark"] ];
   
    
    //UIImage *highLighedImage = [UIImage imageNamed:@"37x-Checkmark"];   
    //cell.imageView.highlightedImage = highLighedImage;
    return cell;
    
}  

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{
    
    return [self.videolist count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 91.5;  
}  



- (void)viewDidUnload
{
    [self setVideotable:nil];
    [super viewDidUnload];
    self.videolist = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)onClickButton:(id)sender
{
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"second" bundle:nil];
    [self presentModalViewController:[stryBoard instantiateInitialViewController] animated:YES];
}
@end
