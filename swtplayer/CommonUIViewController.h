//
//  CommonUIViewController.h
//  swtplayer
//
//  Created by ouyang qungang on 21/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CommonUIViewController : UIViewController

 @property (strong, nonatomic)  NSMutableDictionary *  userEntity;
 @property (strong, nonatomic)  MBProgressHUD * HUD;

@end
