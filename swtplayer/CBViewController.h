//
//  CBViewController.h
//  swtplayer
//
//  Copyright Baidu All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CBViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIView *mpPlayerView;
@property (retain, nonatomic) IBOutlet UIView *cbPlayerView;
- (IBAction)onClickPlay:(id)sender;
- (IBAction)onClickStop:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *currentProgress;
@property (retain, nonatomic) IBOutlet UILabel *remainsProgress;
@property (retain, nonatomic) IBOutlet UISlider *sliderProgress;
- (IBAction)onDragSlideValueChanged:(id)sender;
- (IBAction)onDragSlideDone:(id)sender;
- (IBAction)onDragSlideStart:(id)sender;
- (void)viewDidLoad;
@property (retain, nonatomic) IBOutlet UIButton *playButtonText;
@property (retain, nonatomic) IBOutlet UITextField *playContentText;
@end
