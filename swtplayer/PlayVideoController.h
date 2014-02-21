//
//  PlayVideoController.h
//  swtplayer
//
//  Created by ouyang qungang on 20/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFn.h"


@interface PlayVideoController : CommonUIViewController
@property (weak, nonatomic)  NSString * videoid ; 
- (IBAction)closeView:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *closebutton;

@property (weak, nonatomic) IBOutlet UIView *topcontrolbar;

@property (weak, nonatomic) IBOutlet UIView *controlbox;


@property (retain, nonatomic) IBOutlet UIView *cbPlayerView;
- (IBAction)onClickPlay:(id)sender;

@property (retain, nonatomic) IBOutlet UILabel *currentProgress;
@property (retain, nonatomic) IBOutlet UILabel *remainsProgress;
@property (retain, nonatomic) IBOutlet UISlider *sliderProgress;
- (IBAction)onDragSlideValueChanged:(id)sender;
- (IBAction)onDragSlideDone:(id)sender;
- (IBAction)onDragSlideStart:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton * playButton;
@property (retain, nonatomic) NSString *playurl;


@end
