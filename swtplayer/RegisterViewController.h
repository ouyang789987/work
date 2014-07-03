//
//  LoginViewController.h
//  stroyboarddemo
//
//  Created by marcus on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface RegisterViewController : CommonUIViewController

@property (strong, nonatomic) IBOutlet UITextField *emailtxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordtxt;

@property (strong, nonatomic) IBOutlet UITextField *repassword;

@property  (strong, nonatomic) NSDictionary * actiontype;
@property (strong, nonatomic) IBOutlet UILabel *errormsg;




-(IBAction)onClickButton:(id)sender;

- (IBAction)onRegisterBtClick:(id)sender;
-(void)LoginUser;
@end
