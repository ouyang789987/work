//
//  VideodetailController.h
//  swtplayer
//
//  Created by ouyang qungang on 19/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "PlayVideoController.h"
#import "CommonFn.h"

@interface VideodetailController : CommonUIViewController
@property (weak, nonatomic)  NSString * videoid ; 
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *videotitle;

@property (weak, nonatomic) IBOutlet UILabel *cattitle;

- (IBAction)GoToPlayVideo:(id)sender;

@end
