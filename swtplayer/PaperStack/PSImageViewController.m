//
//  PSImageViewController.m
//  swtplayer
//
//  Created by oyqg on 14-3-5.
//
//

#import "PSImageViewController.h"
#import "PSimagePageView.h"

@interface PSImageViewController ()

@end

@implementation PSImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImagePage:(NSString *) imageurl
{
    self = [self initWithNibName:nil bundle:nil];
    if ( self ) {
        
        PSimagePageView *pdfView = [[PSimagePageView alloc] initWithImagePage:imageurl];
        self.view = pdfView;
        NSLog(@"init imageurl %@",imageurl);
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
