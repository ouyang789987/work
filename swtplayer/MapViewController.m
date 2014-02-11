//
//  MapViewController.m
//  swtplayer
//
//  Created by ouyang qungang on 21/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController
@synthesize webview;
@synthesize areadata;
@synthesize segueview;
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
    webview.delegate=self;
    webview.scalesPageToFit=YES;
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"html" inDirectory:@"/"]; 
    //NSLog(htmlPath);
    NSURL * htmlUrl = [NSURL fileURLWithPath:htmlPath];  
    //NSURL* url = [NSURL URLWithString:@"http://www.youku.com"];   
    [webview loadRequest:[NSURLRequest requestWithURL:htmlUrl]]; 
    
}




- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[webView stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom=0.8"];
    //webview.scrollView.scrollEnabled  = NO ;
    webview.scalesPageToFit=YES;  
    webview.autoresizesSubviews=YES;
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   
    NSURL * url = [request URL];
    if ([[url scheme] isEqualToString:@"mapurl"] || [[url scheme] isEqualToString:@"javascript"]) {
        // 在这里做js调native的事情
        areadata=[[url path] stringByReplacingOccurrencesOfString:@"/" withString:@""];
        
        [self ShowAreaListClick];        
        
        // 做完之后用如下方法调回js
        
        [webView stringByEvaluatingJavaScriptFromString:@"iosNotify('methodIdentifier', ['args1', 'args2'])"];
        
        return NO; // 取消对本次请求的导航
    }
    return YES; // 继续对本次请求进行导航
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender  
{  
    segueview = segue.destinationViewController; 
    segueview.areastr=areadata;
}  

- (void)viewDidUnload
{
   
    webview.delegate = nil;   
    webview=nil;
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)GoBackBtClick:(id)sender {
    
    [webview goBack];
    
}

- (void)ShowAreaListClick
{
    
   [self performSegueWithIdentifier:@"goshowareadata" sender:self];
     
}
@end
