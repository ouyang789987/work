//
//  PlayVideoAllViewController.m
//  swtplayer
//
//  Created by oyqg on 14-2-25.
//
//

#import "PlayVideoAllViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Vitamio.h"

@implementation PlayVideoAllViewController
{
    
    VMediaPlayer * cbPlayerController;
    NSTimer *timer;
    BOOL didPrepared;
    
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
    //playurl=@"mms://42.96.198.211/bj";
    [self addEventToPlayView];
    
    NSLog(@"this is play videoid %@",playurl);
    
    
    
    //将视频显示view添加到当前view中
    //[cbPlayerController setVideoFillMode:VMVideoFillModeStretch];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationchanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [self initplay];
    
    
    [self startPlayback];
    [CommonFn ShowTextInfo:@"正在连接....." OntheView:self SleepTime:2];
    
    sliderProgress.continuous = true;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}



-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(playurl)
    {
        [self prepareVideo];
    }
    
}


-(void) prepareVideo
{
    
    if(playurl)
    {
        [self startPlayback];
    }
    
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
    didPrepared=NO;
    [cbPlayerController reset];
    [cbPlayerController unSetupPlayer];
    cbPlayerController =nil;
    [self dismissModalViewControllerAnimated:NO];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    //NSLog(@"set layer out to henping");
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

-(void)orientationchanged:(NSNotification *) note
{
    //NSLog(@"orientation changed");
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
    [cbPlayerController reset];
    didPrepared=NO;
    [cbPlayerController unSetupPlayer];
    [self setClosebutton:nil];
    [self setControlbox:nil];
    [self setTopcontrolbar:nil];
    [self setVideoboxview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (IBAction)onClickPlay:(id)sender {
    //当按下播放按钮时，调用startPlayback方法
    
    BOOL isPlaying = [cbPlayerController isPlaying];
    if (isPlaying) {
        [cbPlayerController pause];
        
    } else {
        if(didPrepared)
            [cbPlayerController start];
        else
            [self prepareVideo];         
    }
    //controlbox.hidden=!controlbox.hidden;
}

-(void)initplay
{
    if(!cbPlayerController)
    {
        cbPlayerController = [VMediaPlayer sharedInstance];
        [cbPlayerController setupPlayerWithCarrierView:cbPlayerView withDelegate:self];
        
    }
    
}


- (void)startPlayback{
    
    
    NSURL *url = [NSURL URLWithString:playurl];
    /*
    if (!url)
    {
        url = [NSURL URLWithString:[playurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
     */
    [UIApplication sharedApplication].idleTimerDisabled=YES;
    [cbPlayerController setDataSource:url];
    [cbPlayerController prepareAsync];
    [self startTimer];
        
}

- (void)stopPlayback{
    //停止视频播放
    
    [cbPlayerController pause];
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
    
    [self refreshProgress:[cbPlayerController getCurrentPosition ]/1000 totalDuration:[cbPlayerController getDuration]/1000];
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
    [self refreshProgress:sliderProgress.value totalDuration:[cbPlayerController getDuration]];
    
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

#pragma mark VMediaPlayerDelegate Implement / Required

- (void)mediaPlayer:(VMediaPlayer *)player didPrepared:(id)arg
{
	 
	didPrepared = YES;
    [player start];
   
}

- (void)mediaPlayer:(VMediaPlayer *)player playbackComplete:(id)arg
{
	 
	[player reset];
	didPrepared = NO;
	[UIApplication sharedApplication].idleTimerDisabled = NO;
}


- (void)mediaPlayer:(VMediaPlayer *)player error:(id)arg
{
	NSLog(@"VMediaPlayer Error: %@", arg);
}

 

@end
