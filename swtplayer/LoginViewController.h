//
//  LoginViewController.h
//  stroyboarddemo
//
//  Created by marcus on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : CommonUIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailtxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordtxt;
@property  (weak, nonatomic) NSDictionary * actiontype;
@property (weak, nonatomic) IBOutlet UILabel *errormsg;

-(IBAction)onClickButton:(id)sender;

- (IBAction)onRegisterBtClick:(id)sender;
-(void)LoginUser;
@end
