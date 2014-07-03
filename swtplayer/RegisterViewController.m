//
//  LoginViewController.m
//  stroyboarddemo
//
//  Created by marcus on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

#import "CommonFn.h"

@implementation RegisterViewController
@synthesize emailtxt;
@synthesize passwordtxt;
@synthesize repassword;
@synthesize actiontype;

@synthesize errormsg;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    emailtxt.delegate=self;
    passwordtxt.delegate=self;
    repassword.delegate=self;
    // Do any additional setup after loading the view from its nib.
}


-(void) viewDidAppear:(BOOL)animated
{
    
    /*
     
    if([CommonFn CheckJsonFile])
    {
        [CommonFn ParseJsonData];
        [CommonFn GoHome:self];      
    }
    
    */
    
}

- (void)viewDidUnload
{
    [self setEmailtxt:nil];
    [self setPasswordtxt:nil];
    [self setErrormsg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
 



-(void)GetJsonData

{
    
    NSString * actionurl=[[CommonFn SiteUrl] stringByAppendingString:@"ajax.aspx?action=getvideojson&type=getalldataontime"];
    NSURL  *url = [NSURL URLWithString:actionurl];    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTag:2];
    //[self.actiontype setValue:[request requestID] forKey:@"getjson"];
    [request setDelegate:self];    
    [request startAsynchronous];    
}


-(void)LoginUser
{
    
    
    LoginViewController *loginViewController=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    self.view.window.rootViewController=loginViewController;
    
    
}


-(void)requestFinished:(ASIHTTPRequest *)request

{    
      //  Use when fetching text data    
    
   
    NSString  *responseString = [request responseString];   
    //    Use when fetching binary data    
    //NSData   * responseData = [request responseData];
   
    switch ([request tag]) 
    {
        case 1:
        {
            if([responseString isEqualToString:@"1"])
            {
                errormsg.text=@"注册成功";
                if(![CommonFn CheckJsonFile])
                {
                   [self GetJsonData];
                }
                else
                {
                   [CommonFn ParseJsonData];
                   [CommonFn GoHome:self];
                }
                 NSLog(@"register ok");
            }
            else
            {
                errormsg.text=@"邮箱已经被注册";
            }
           
        }
            break;
            
        case 2:
     
        {        
             NSString * fname=[CommonFn JsonFileName];
            //NSLog(@"jsondata_");
            //NSLog(responseString);
            [CommonFn writeNSStringData:responseString writeFileName:fname];
            [CommonFn ParseJsonData:responseString];            
            [CommonFn GoHome:self];
            
        }
            break;
            
        default:
            
        break;
            
        
    }
            
             
   
}



-(void)requestFailed:(ASIHTTPRequest  *)request
{
    
    NSError  *error = [request error];
    NSLog(@"%@",[error localizedDescription]);
}



-(IBAction)onClickButton:(id)sender
{
    [self LoginUser];
    
}

- (IBAction)onRegisterBtClick:(id)sender {
    
    
    //[CommonFn ParseJsonData];
    //[CommonFn GoHome:self];
    
    BOOL emailnil=[emailtxt.text isEqualToString:@""];
    BOOL passwordnil=[passwordtxt.text isEqualToString:@""];
    
    if(emailnil || passwordnil )
    {
        errormsg.text=@"用户名或密码不能为空";
        return;
    }
    else
    {
        NSString * ismacth=passwordtxt.text;
        
        if(![ismacth isEqualToString:repassword.text])
        {
            errormsg.text=@"密码不一致";
            return;
        }
        else
        {
            errormsg.text=@"";
        }
    }
    
    NSString * actionurl=[[CommonFn SiteUrl] stringByAppendingString:@"ajax.aspx"];
    
    NSURL  *url = [NSURL URLWithString:actionurl];
    
    ASIFormDataRequest * request=[ASIFormDataRequest requestWithURL:url];
    NSString * tempemail = [emailtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * temppassword = [passwordtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [request setTag:1];
    //[self.actiontype setValue:[request requestID] forKey:@"login"];
    [request setPostValue:@"registeruser" forKey:@"action"];
    [request setPostValue:tempemail forKey:@"email"];
    [request setPostValue:temppassword forKey:@"password"];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [repassword resignFirstResponder];
    [emailtxt resignFirstResponder];
    [passwordtxt resignFirstResponder];
}

-(void)dealloc
{
    NSLog(@"LoginViewController dealloc");
}
@end
