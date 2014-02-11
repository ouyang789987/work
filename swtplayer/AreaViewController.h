//
//  ManagerViewController.h
//  stroyboarddemo
//
//  Created by marcus on 12-1-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
 
#import "UIImageView+WebCache.h"


@interface AreaViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> 

@property (weak, nonatomic) IBOutlet UITableView *videotable;

@property (weak, nonatomic)  NSString * areastr ; 

-(IBAction)onClickButton:(id)sender;

@property (strong, nonatomic) NSArray *videolist;  

- (UIImage *)scaleToSize:(UIImage *)img resize:(CGSize)newsize; 
    
@end
