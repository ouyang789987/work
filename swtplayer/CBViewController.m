
#import "CBViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CyberPlayerController.h"
@interface CBViewController ()
{
    MPMoviePlayerController *mpPlayerController;
    CyberPlayerController *cbPlayerController;
    NSTimer *timer;
}
@end

@implementation CBViewController
@synthesize mpPlayerView;
@synthesize cbPlayerView;
@synthesize sliderProgress;
@synthesize currentProgress;
@synthesize remainsProgress;
@synthesize playButtonText;
@synthesize playContentText;

- (void)viewDidLoad
{
    mpPlayerView.layer.borderWidth = 2.0;
    mpPlayerView.layer.borderColor = [[UIColor redColor]CGColor];
    cbPlayerView.layer.borderWidth = 2.0;
    cbPlayerView.layer.borderColor = [[UIColor blueColor]CGColor];
    
    mpPlayerController = [[MPMoviePlayerController alloc]init];
    [mpPlayerController.view setFrame:mpPlayerView.frame];
    [self.view addSubview:mpPlayerController.view];
    //CyberPlayerController的显示效果和MPMoviePlayerController的控制类型controlStyle属性为MPMovieControlStyleNone时一致。
    mpPlayerController.controlStyle = MPMovieControlStyleNone;
    //该文本框内容将作为视频输入的URL，apple的访问速度会比较慢，建议替换为其他播放地址。
    //playContentText.text = @"http://119.188.2.50/data2/video04/2013/04/27/00ab3b24-74de-432b-b703-a46820c9cd6f.mp4";
    //playContentText.text = @"http://meta.video.qiyi.com/63/8741c4546d1bb0aaf31defb80e867094.m3u8";
    //playContentText.text = @"http://devimages.apple.com/iphone/samples/bipbop/gear4/prog_index.m3u8";
    playContentText.text = @"rtmp://livertmppc.wasu.cn/live/dfws";
    
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
    [self.view addSubview:cbPlayerController.view];
    
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
    
    [super viewDidLoad];
    sliderProgress.continuous = true;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) onpreparedListener: (NSNotification*)aNotification
{
    //视频文件完成初始化，开始播放视频并启动刷新timer。
    playButtonText.titleLabel.text = @"pause";
    [self startTimer];
}
- (void)seekComplete:(NSNotification*)notification
{
    //开始启动UI刷新
    [self startTimer];
}

- (void)dealloc {
    [cbPlayerController release];    
    [mpPlayerController release];
    [sliderProgress release];
    [currentProgress release];
    [remainsProgress release];
    [playButtonText release];
    [playContentText release];
    [super dealloc];
}
- (IBAction)onClickPlay:(id)sender {
    //当按下播放按钮时，调用startPlayback方法
    [self startPlayback];
}

- (IBAction)onClickStop:(id)sender {
    [self stopPlayback];
}
- (void)startPlayback{
    NSURL *url = [NSURL URLWithString:playContentText.text];
    if (!url)
    {
        url = [NSURL URLWithString:[playContentText.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    switch (mpPlayerController.playbackState) {
        case MPMoviePlaybackStateStopped:
            [mpPlayerController setContentURL:url];
            [mpPlayerController prepareToPlay];
            break;
        case MPMoviePlaybackStatePaused:
            [mpPlayerController play];
            break;
        case MPMoviePlaybackStatePlaying:
            [mpPlayerController pause];
            break;
        default:
            break;
    }
    switch (cbPlayerController.playbackState) {
        case CBPMoviePlaybackStateStopped:
        case CBPMoviePlaybackStateInterrupted:
            [cbPlayerController setContentURL:url];
            //初始化完成后直接播放视频，不需要调用play方法
            cbPlayerController.shouldAutoplay = YES;
            //初始化视频文件
            [cbPlayerController prepareToPlay];
            [playButtonText setTitle:@"pause" forState:UIControlStateNormal];
            break;
        case CBPMoviePlaybackStatePlaying:
            //如果当前正在播放视频时，暂停播放。
            [cbPlayerController pause];
            [playButtonText setTitle:@"play" forState:UIControlStateNormal];
            break;
        case CBPMoviePlaybackStatePaused:
            //如果当前播放视频已经暂停，重新开始播放。
            [cbPlayerController start];
            [playButtonText setTitle:@"pause" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}
- (void)stopPlayback{
    //停止视频播放
    [cbPlayerController stop];
    [mpPlayerController stop];
    [playButtonText setTitle:@"play" forState:UIControlStateNormal];
    [self stopTimer];
}

- (void)timerHandler:(NSTimer*)timer
{
    [self refreshProgress:cbPlayerController.currentPlaybackTime totalDuration:cbPlayerController.duration];
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

+ (NSDictionary*)convertSecond2HourMinuteSecond:(int)second
{
    NSMutableDictionary* dict = [[[NSMutableDictionary alloc] init] autorelease];
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    //设置横屏播放
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    
    return NO;
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
    //    [cbPlayerController setCurrentPlaybackTime:currentTIme];
    [mpPlayerController setCurrentPlaybackTime:currentTIme];
}
- (IBAction)onDragSlideStart:(id)sender {
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
@end

