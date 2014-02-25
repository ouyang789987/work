//
//  PlayVideoAllViewController.h
//  swtplayer
//
//  Created by oyqg on 14-2-25.
//
//

#import <UIKit/UIKit.h>
#import "CommonFn.h"

@interface PlayVideoAllViewController : CommonUIViewController

@property (strong, nonatomic)  NSString * videoid ;
- (IBAction)closeView:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *videoboxview;

@property (strong, nonatomic) IBOutlet UIButton *closebutton;

@property (strong, nonatomic) IBOutlet UIView *topcontrolbar;

@property (strong, nonatomic) IBOutlet UIView *controlbox;


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
