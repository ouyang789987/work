//
//  ManagerViewController.h
//  stroyboarddemo
//
//  Created by marcus on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
 
#import "UIImageView+WebCache.h"
#import "UIImage+UIImageExtras.h"
#import "VideodetailController.h"
#import "CustomCell.h"
#import "CommonFn.h"

@interface AreaViewController : CommonUIViewController<UITableViewDelegate, UITableViewDataSource> 

@property (strong, nonatomic) IBOutlet UITableView *videotable;

@property BOOL nibsRegistered ;

@property (strong, nonatomic)  NSString * areastr ;

-(IBAction)onClickButton:(id)sender;

@property (strong, nonatomic) NSMutableArray * videolist;  
@property (strong, nonatomic) NSMutableArray * sectionids;
@property (strong, nonatomic) NSMutableDictionary * sectionDict;
@property (strong, nonatomic) VideodetailController * segueview;
@property (strong, nonatomic) NSString * selectvideoid;  
- (UIImage *)scaleToSize:(UIImage *)img resize:(CGSize)newsize; 
    
@end
