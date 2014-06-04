//
//  IosPageViewController.m
//  swtplayer
//
//  Created by oyqg on 14-3-5.
//
//

#import "IosPageViewController.h"
#import "CommonFn.h"
#import "UIImageView+WebCache.h"


@interface IosPageViewController ()

@end

@implementation IosPageViewController
@synthesize userEntity;
@synthesize ezinepagesurl;
@synthesize pagesview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * ezineid= [self.userEntity objectForKey:@"ezineid"];
    
    NSDictionary * ezine= [[CommonFn EzineList]objectForKey:ezineid];
    
    NSArray * ezinepages = [ezine objectForKey:@"pages"];
    ezinepagesurl = [[NSMutableArray alloc] init];
    for (int i=0;i<[ezinepages count];i++) {
        NSString * turl=[[CommonFn SiteUrl]stringByAppendingString:[ezinepages[i] objectForKey:@"bigimg"]];
        [ezinepagesurl addObject:turl];
        //NSLog(turl);
        
    }
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    pagesview=[[NSMutableArray alloc]init];
   
   
    
    
    for (int i=0; i<[ezinepagesurl count]; i++) {
        
        UIViewController *mCtrl = [[UIViewController alloc] init];
        //mCtrl.view.backgroundColor = [UIColor blueColor];
        
        UIImageView * img=[[UIImageView alloc]init];
        [img setImageWithURL:[NSURL URLWithString:ezinepagesurl[i]]];
         mCtrl.view =img;    
        [mCtrl.view setTag:i];
        [CommonFn addGestureRecognizerToView:mCtrl.view CanRotate:NO CanPinch:YES Canpan:YES Cantap:YES] ;
        UILongPressGestureRecognizer * longtap= [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongTapToView:)];
        longtap.minimumPressDuration=2;
        [mCtrl.view addGestureRecognizer:longtap];
        [mCtrl.view setUserInteractionEnabled:YES];
        [mCtrl.view setMultipleTouchEnabled:YES];
        [pagesview addObject:mCtrl];
        
    }
    
    if([pagesview count]==0)
    {
        return;
    }
    
    self.delegate = self;
    self.dataSource = self;
    
    [self setViewControllers:[NSArray arrayWithObject:pagesview[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger index= viewController.view.tag;
    if(index==NSNotFound)
    {
        return  nil;
        
    }
    index++;
    if(index==[pagesview count])
    {
        return nil;
    }
    
    return pagesview[index];
     
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
 
    
    NSInteger index= viewController.view.tag;
    if(index==0 || index==NSNotFound)
    {
        return  nil;
        
    }
    index--;
    return pagesview[index];
    
}



- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation{
    
   
    if(UIInterfaceOrientationIsLandscape(orientation))
    {
        return UIPageViewControllerSpineLocationMid;
    }
    else
    {
        return UIPageViewControllerSpineLocationMin;
    }
}


- (IBAction)closeEzine:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void) LongTapToView:(UILongPressGestureRecognizer *)longGestureRecognizer
{
    if(longGestureRecognizer.state==UIGestureRecognizerStateEnded)
    {
         //NSLog(@"EXIT VIEW oooo");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
