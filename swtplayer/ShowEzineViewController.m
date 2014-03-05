//
//  ShowEzineViewController.m
//  swtplayer
//
//  Created by oyqg on 14-2-26.
//
//

#import "ShowEzineViewController.h"
#import "CommonFn.h"
#import "UIImageView+WebCache.h"
#import "PSImageViewController.h"
#import "PSPDFPageViewController.h"

@interface ShowEzineViewController ()

@end

@implementation ShowEzineViewController
{
    CGPDFDocumentRef pdf;
}

@synthesize ezinepagesurl;
@synthesize userEntity;
 

#pragma mark - View lifecycle



- (id)initWithImagePage:(NSString *) imageurl
{
    self = [self initWithNibName:nil bundle:nil];
    if ( self ) {
        
        PSimagePageView * imgView = [[PSimagePageView alloc] initWithImagePage:imageurl];
        self.view = imgView;
        
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
    
    // load pdf
    CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("book.pdf"), NULL, NULL);
    pdf=CGPDFDocumentCreateWithURL(pdfURL);
    
    //PSPagesViewController *aController = [[PSPagesViewController alloc] initWithNibName:nil bundle:nil];
    //aController.datasource = self;
    // aController.shouldUseInitialEmptyLeftPage = YES;
    //[self addChildViewController:aController];
    self.shouldUseInitialEmptyLeftPage=NO;
    self.datasource=self;
    
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark -
#pragma mark - PSPagesViewControllerDatasource

- (NSUInteger)pagesNumberOfControllers
{
    NSLog(@"11");
    return [ezinepagesurl count];
}

- (UIViewController*)pagesPageViewControllerAtIndex:(NSUInteger)index
{
    
   // ShowEzineViewController  * controller=[[ShowEzineViewController alloc] initWithImagePage:ezinepagesurl[index]];
    
    //UIImageView * imgview=[[UIImageView alloc]init];
    //[imgview setImageWithURL:[NSURL URLWithString:ezinepagesurl[index+1]]                   placeholderImage:[UIImage imageNamed:@"nopic"]];
    //[imgview setImage:[UIImage imageNamed:@"nopic"]];
    //[controller.view addSubview:imgview];
    CGPDFPageRef page=CGPDFDocumentGetPage(pdf, index+1);
    PSPDFPageViewController * controller=[[PSPDFPageViewController alloc] initwithPDFPage:page];
    NSLog(@"page index %d",index);
    
    return  controller;
    
}


@end
