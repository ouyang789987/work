//
//  MapViewController.h
//  swtplayer
//
//  Created by ouyang qungang on 21/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaViewController.h"

@interface MapViewController : CommonUIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic)  NSString * areadata ;
@property (strong, nonatomic) AreaViewController * segueview;
- (IBAction)GoBackBtClick:(id)sender;

- (void) ShowAreaListClick;

@end
