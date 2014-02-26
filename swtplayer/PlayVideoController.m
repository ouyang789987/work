//
//  PlayVideoController.m
//  swtplayer
//
//  Created by ouyang qungang on 20/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "PlayVideoController.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CyberPlayerController.h"

@implementation PlayVideoController
{
   
    CyberPlayerController *cbPlayerController;
    NSTimer *timer;
}
@synthesize videoid;


@synthesize closebutton;
@synthesize topcontrolbar;
@synthesize controlbox;
@synthesize cbPlayerView;
@synthesize sliderProgress;
@synthesize currentProgress;
@synthesize remainsProgress;
@synthesize playButton;
@synthesize playurl;


/*


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    if(self.videoid==NULL)
    {
        self.videoid= [[self userEntity]objectForKey:@"videoid"];
    }
    
    NSDictionary * curvideo=[[CommonFn AllvList]objectForKey:self.videoid];
    NSString * vtempurl=[curvideo objectForKey:@"videopath"];
    
    if([vtempurl rangeOfString:@"://" options:NSCaseInsensitiveSearch].length>0)
    {
        playurl=vtempurl;
    }
    else
    {
        playurl =[[CommonFn VideoDomain] stringByAppendingString:vtempurl];
    }
    //playurl=@"http://42.96.198.211:8081/bj";
    [self addEventToPlayView];
    
    NSLog(@"this is play videoid %@",playurl);
    
    
    
    
    
    cbPlayerView.layer.borderWidth = 2.0;
    cbPlayerView.layer.borderColor = [[UIColor blueColor]CGColor];
    
    
    
    //playContentText.text = @"rtmp://livertmppc.wasu.cn/live/dfws";
    
    //请添加您百度开发者中心应用对应的APIKey和SecretKey。
    NSString* msAK=@"zj3xmff1oQicdHOaeN9UlYqK";
    NSString* msSK=@"aOgUBfG6Fxw779oLm0SGazg8U5GnRcfe";
    
    
     
    //添加开发者信息
    [[CyberPlayerController class ]setBAEAPIKey:msAK SecretKey:msSK ];
    //当前只支持CyberPlayerController的单实例
    cbPlayerController = [[CyberPlayerController alloc] init];
    //设置视频显示的位置
    [cbPlayerController.view setFrame: cbPlayerView.frame];
    
    //将视频显示view添加到当前view中
    [self.videoboxview addSubview:cbPlayerController.view];
    
    //注册监听，当播放器完成视频的初始化后会发送CyberPlayerLoadDidPreparedNotification通知，
    //此时naturalSize/videoHeight/videoWidth/duration等属性有效。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onpreparedListener:)
                                                 name: CyberPlayerLoadDidPreparedNotification
                                               object:nil];
    //注册监听，当播放器完成视频播放位置调整后会发送CyberPlayerSeekingDidFinishNotification通知，
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(seekComplete:)
                                                 name:CyberPlayerSeekingDidFinishNotification
                                               object:nil];
    
    [self startPlayback];
    
  
    sliderProgress.continuous = true;
    
    // Do any additional setup after loading the view, typically from a nib.
     
     
    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


 



- (IBAction)closeView:(id)sender {
    
    [self stopPlayback];
    [self dismissModalViewControllerAnimated:NO];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    NSLog(@"set layer out to henping");
    //设置横屏播放
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    
    return NO;
}


-(BOOL) shouldAutorotate
{
   
    return YES;
}

-(NSUInteger) supportedInterfaceOrientations
{
       
    return UIInterfaceOrientationMaskLandscapeRight;
}
 

-(void) addEventToPlayView
{
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onVideoClickToShowControlBox:)]; 
    singleTap.numberOfTapsRequired=2;
    singleTap.numberOfTouchesRequired=1;
    [cbPlayerView addGestureRecognizer:singleTap];
}


-(void)onVideoClickToShowControlBox:(UITapGestureRecognizer *)sender
{
    
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender; 
    controlbox.hidden=!controlbox.hidden;
    topcontrolbar.hidden=!topcontrolbar.hidden;
}




- (void)viewDidUnload
{
    [self stopPlayback];
    [self setClosebutton:nil];
    [self setControlbox:nil];
    [self setTopcontrolbar:nil];
    [self setVideoboxview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void) onpreparedListener: (NSNotification*)aNotification
{
    //视频文件完成初始化，开始播放视频并启动刷新timer。
    playButton.titleLabel.text = @"pause";
    [self startTimer];
}

- (void)seekComplete:(NSNotification*)notification
{
    //开始启动UI刷新
    [self startTimer];
}



- (IBAction)onClickPlay:(id)sender {
    //当按下播放按钮时，调用startPlayback方法
   
    if(cbPlayerController.playbackState==CBPMoviePlaybackStatePlaying)
    {
        [self stopPlayback];
    }
    else
    {
         [self startPlayback];
    }
    //controlbox.hidden=!controlbox.hidden;
}



- (void)startPlayback{
    
     
    NSURL *url = [NSURL URLWithString:playurl];
    if (!url)
    {
        url = [NSURL URLWithString:[playurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    switch (cbPlayerController.playbackState) {
        case CBPMoviePlaybackStateStopped:
        case CBPMoviePlaybackStateInterrupted:
            [cbPlayerController setContentURL:url];
            //初始化完成后直接播放视频，不需要调用play方法
            cbPlayerController.shouldAutoplay = YES;
            //初始化视频文件
            [cbPlayerController prepareToPlay];
            [playButton setTitle:@"pause" forState:UIControlStateNormal];
            break;
        case CBPMoviePlaybackStatePlaying:
            //如果当前正在播放视频时，暂停播放。
            [cbPlayerController pause];
            [playButton setTitle:@"play" forState:UIControlStateNormal];
            break;
        case CBPMoviePlaybackStatePaused:
            //如果当前播放视频已经暂停，重新开始播放。
            [cbPlayerController start];
            [playButton setTitle:@"pause" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
}

- (void)stopPlayback{
    //停止视频播放
    
    [cbPlayerController stop];    
    
    [playButton setTitle:@"play" forState:UIControlStateNormal];
    [self stopTimer];
     
}



- (void)startTimer{
    //为了保证UI刷新在主线程中完成。
    [self performSelectorOnMainThread:@selector(startTimeroOnMainThread) withObject:nil waitUntilDone:NO];
}
- (void)startTimeroOnMainThread{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
}

- (void)stopTimer{
    if ([timer isValid])
    {
        [timer invalidate];
    }
    timer = nil;
}




 



- (void)timerHandler:(NSTimer*)timer
{
    [self refreshProgress:cbPlayerController.currentPlaybackTime totalDuration:cbPlayerController.duration];
}



+ (NSDictionary*)convertSecond2HourMinuteSecond:(int)second
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    int hour = 0, minute = 0;
    
    hour = second / 3600;
    minute = (second - hour * 3600) / 60;
    second = second - hour * 3600 - minute *  60;
    
    [dict setObject:[NSNumber numberWithInt:hour] forKey:@"hour"];
    [dict setObject:[NSNumber numberWithInt:minute] forKey:@"minute"];
    [dict setObject:[NSNumber numberWithInt:second] forKey:@"second"];
    
    return dict;
}




- (NSString*)getTimeString:(NSDictionary*)dict prefix:(NSString*)prefix
{
    int hour = [[dict objectForKey:@"hour"] intValue];
    int minute = [[dict objectForKey:@"minute"] intValue];
    int second = [[dict objectForKey:@"second"] intValue];
    
    NSString* formatter = hour < 10 ? @"0%d" : @"%d";
    NSString* strHour = [NSString stringWithFormat:formatter, hour];
    
    formatter = minute < 10 ? @"0%d" : @"%d";
    NSString* strMinute = [NSString stringWithFormat:formatter, minute];
    
    formatter = second < 10 ? @"0%d" : @"%d";
    NSString* strSecond = [NSString stringWithFormat:formatter, second];
    
    return [NSString stringWithFormat:@"%@%@:%@:%@", prefix, strHour, strMinute, strSecond];
}



- (void)refreshProgress:(int) currentTime totalDuration:(int)allSecond{
    
    NSDictionary* dict = [[self class] convertSecond2HourMinuteSecond:currentTime];
    NSString* strPlayedTime = [self getTimeString:dict prefix:@""];
    currentProgress.text = strPlayedTime;
    
    NSDictionary* dictLeft = [[self class] convertSecond2HourMinuteSecond:allSecond - currentTime];
    NSString* strLeft = [self getTimeString:dictLeft prefix:@"-"];
    remainsProgress.text = strLeft;
    sliderProgress.value = currentTime;
    sliderProgress.maximumValue = allSecond;
    
}
 
 
 


 
  


- (IBAction)onDragSlideValueChanged:(id)sender {
    NSLog(@"slide changing, %f", sliderProgress.value);
  [self refreshProgress:sliderProgress.value totalDuration:cbPlayerController.duration];
    
}


- (IBAction)onDragSlideDone:(id)sender {
    float currentTIme = sliderProgress.value;
    NSLog(@"seek to %f", currentTIme);
    //实现视频播放位置切换，
    [cbPlayerController seekTo:currentTIme];
    //两种方式都可以实现seek操作
    //[cbPlayerController setCurrentPlaybackTime:currentTIme];
    
}

- (IBAction)onDragSlideStart:(id)sender {
    [self stopTimer];
}
 
*/

@end

