//
//  LoginViewController.h
//  stroyboarddemo
//
//  Created by marcus on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : CommonUIViewController

@property (strong, nonatomic) IBOutlet UITextField *emailtxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordtxt;
@property  (strong, nonatomic) NSDictionary * actiontype;
@property (strong, nonatomic) IBOutlet UILabel *errormsg;

-(IBAction)onClickButton:(id)sender;

- (IBAction)onRegisterBtClick:(id)sender;
-(void)LoginUser;
@end
