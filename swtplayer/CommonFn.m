//
//  CommonFn.m
//  swtplayer
//
//  Created by ouyang qungang on 12/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "CommonFn.h"
#import "JSONKit.h"

static NSString * _jsonfilename=@"alljson.txt";;
static NSString * _siteurl=@"http://android.tvswt.com/";
static NSString * _videodomain=@"http://sj.tvswt.com/";
static NSMutableDictionary * _videojson;
static NSMutableDictionary * _allvList;
static NSMutableDictionary * _catlist;
static NSMutableDictionary * _catvideolist;
static NSMutableDictionary * _areavideolist;
static NSMutableDictionary * _arealist;
static NSMutableDictionary * _ezinelist;
static NSInteger _ezineviewpanstatus;

@implementation CommonFn
 
 

-(id)init{      
    self = [super init];      
    if(nil!=self){     
        //_jsonfilename=@"alljson.txt";
        //_siteurl=@"http://android.tvswt.com/"; 
        //NSLog(@" class init ");
        _ezineviewpanstatus=NO;
    }      
    return self;      
}          

+(void)varbinit
{
    _allvList=[NSMutableDictionary dictionaryWithCapacity:0] ;
    _catlist=[NSMutableDictionary dictionaryWithCapacity:0] ;
    _catvideolist=[NSMutableDictionary dictionaryWithCapacity:0] ;
    _areavideolist=[NSMutableDictionary dictionaryWithCapacity:0] ;
    _arealist=[NSMutableDictionary dictionaryWithCapacity:0] ;
    _ezinelist=[NSMutableDictionary dictionaryWithCapacity:0] ;
    _ezineviewpanstatus=NO;
}

+(NSMutableDictionary *)AllvList
{
    return _allvList;
}

+(NSMutableDictionary *)CatList
{
    return _catlist;
}

+(NSMutableDictionary *)CatVideoList
{
    return _catvideolist;
}

+(NSMutableDictionary *) AreaVideoList
{
    return _areavideolist;
}

+(NSMutableDictionary *) AreaList
{
    return  _arealist;
}

+(NSMutableDictionary *) EzineList
{
    return  _ezinelist;
}


+(NSString *)JsonFileName
{
    return _jsonfilename;
}

+(NSString *)SiteUrl
{
    return  _siteurl;
}


+(NSString *)VideoDomain
{
    return  _videodomain;
}


+(NSString *) GetDocumentsDirectory 
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory) {
        documentsDirectory= NSTemporaryDirectory();
    }
    return documentsDirectory;
}



+(BOOL) writeNSDictData:(NSDictionary *)data  writeFileName:(NSString *)fileName
{
    NSString *documentsDirectory =[self GetDocumentsDirectory];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    return ([data writeToFile:appFile atomically:YES]);
}

+(NSDictionary *) readNSDictData:(NSString *)fileName
{
    NSString *documentsDirectory =[self GetDocumentsDirectory];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSDictionary *myData = [[NSDictionary alloc] initWithContentsOfFile:appFile];
    return myData;
}

+(BOOL) writeNSStringData:(NSString *)data  writeFileName:(NSString *)fileName
{
    NSString *documentsDirectory =[self GetDocumentsDirectory];
   
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    BOOL status= [data writeToFile:appFile atomically:YES];
    return status;
}

+(NSString *) readNSStringData:(NSString *)fileName
{
    NSString *documentsDirectory =[self GetDocumentsDirectory];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSString *myData = [[NSString alloc] initWithContentsOfFile:appFile];
    return myData;
}


+(NSDictionary *) ParseJsonData:(NSString *)data
{
    [self varbinit];   
    NSString * jsontxt= data ;
   
    //NSString * fname=[CommonFn JsonFileName];
    //NSString * jsontxt= [self readNSStringData:fname];
    //jsontxt=@"{\"catjson\":[{\"id\":\"7c5dfa36551c46d1a7087f89b93881fa\",\"organizationid\":\"10000000\",\"title\":\"文化动态\",\"thumbnail\":\"/uploadfile/20121213161655781.jpg\",\"detail\":null,\"level\":null,\"subcat\":{},\"userid\":\"b82bc1eac0ab4ab4928c229f9f219e4b\",\"sortorder\":60,\"status\":\"1\",\"datecreated\":\"\/Date(1355386073046+0800)\/\",\"datemodified\":\"\/Date(1355449192562+0800)\/\"}]}";

    //NSLog(jsontxt);    
    //JSONDecoder *jd=[[JSONDecoder alloc] init]; 
    NSData* jsonData = [jsontxt dataUsingEncoding:NSUTF8StringEncoding]; 
    NSDictionary *ret2 = [jsonData objectFromJSONData];  
   // NSDictionary * ret2 = [jd ob:(const unsigned char *)[jsondata UTF8String] length:(unsigned int)[jsondata length]]; 
    _videojson=(NSMutableDictionary *)ret2; 
    [self FormatJsonDict];
    return ret2;
}


+(NSDictionary *) ParseJsonData
{
    
    NSString * fname=[CommonFn JsonFileName];
    NSString * jsontxt= [self readNSStringData:fname];  
    return [self ParseJsonData:jsontxt];
}

+(void) FormatJsonDict
{
    
    NSArray * homejson= [_videojson objectForKey:@"homejson"];   
    NSArray * fybjson= [_videojson objectForKey:@"fybjson"];
    NSArray * favjson= [_videojson objectForKey:@"favjson"];
    NSArray * recordjson= [_videojson objectForKey:@"recordjson"];
    NSArray * areajson= [_videojson objectForKey:@"areajson"];
    NSArray * catjson= [_videojson objectForKey:@"catjson"];
    NSArray * ezinejson= [_videojson objectForKey:@"ezinejson"];
    
    //NSLog(@"my parse");
    for(int i=0;i<[homejson count];i++)
    {
        NSDictionary * video=[homejson objectAtIndex:i];  
        NSString * key=[video objectForKey:@"id"];                 
        [_allvList setObject:video forKey:key];
        // NSLog(@"my_ %@",_allvList);
        
    }
    
    for(int i=0;i<[fybjson count];i++)
    {
        NSDictionary * video=[fybjson objectAtIndex:i];        
        [_allvList setObject:video forKey:[video objectForKey:@"id"]];
    }
    
    
     
    for(int i=0;i<[favjson count];i++)
    {
        NSDictionary * video=[favjson objectAtIndex:i];        
        [_allvList setObject:video forKey:[video objectForKey:@"id"]];
    }
    
    
    for(int i=0;i<[recordjson count];i++)
    {
        NSDictionary * video=[recordjson objectAtIndex:i];        
        [_allvList setObject:video forKey:[video objectForKey:@"id"]];
    }
    
    
    for(int i=0;i<[areajson count];i++)
    {
        NSDictionary * area=[areajson objectAtIndex:i];        
        [_arealist setObject:area forKey:[area objectForKey:@"id"]];
    }
    
     
    for(int i=0;i<[catjson count];i++)
    {
        NSDictionary * cat=[catjson objectAtIndex:i];        
        [_catlist setObject:cat forKey:[cat objectForKey:@"id"]];
    }
    
   
    for(int i=0;i<[ezinejson count];i++)
    {
        NSDictionary * ezine=[ezinejson objectAtIndex:i];        
        [_ezinelist setObject:ezine forKey:[ezine objectForKey:@"id"]];
    }
    
    
   
    NSArray * allvalues=[_allvList allValues];
    for(int i=0;i<[allvalues count];i++ )
    {
        //NSLog(@"%@",_catvideolist);
        NSDictionary * v=[allvalues objectAtIndex:i];
        NSString * catid=[v objectForKey:@"catid"];
        NSString * areaid=[v objectForKey:@"videoarea"];
        // BOOL hascat= [[_catvideolist allKeys] containsObject:catid ];
        NSMutableArray * marray= [_catvideolist objectForKey:catid];
        NSMutableArray * area_array= [_areavideolist objectForKey:areaid];
        
        if (marray==NULL) {            
       
            marray = [[NSMutableArray alloc] init]; 
        }
        
        if (area_array==NULL) {
            
            area_array = [[NSMutableArray alloc] init];
        }
        
        
        
        [marray addObject:v];
        [area_array addObject:v];
         
        [_catvideolist setObject:marray forKey:catid];
        [_areavideolist setObject:area_array forKey:areaid];
        
    }
    
    
    
    /*
    NSEnumerator * nsenum =[_catvideolist objectEnumerator];
    for (NSString * key in _catvideolist)
    {
       NSLog(@"%@ ,length %d",key,[[_catvideolist objectForKey:key] count]);
    }
    */
  
    
}


+(BOOL) CheckFileExist:(NSString *)fileName
{
    BOOL statu=NO;
    NSString * documentsDirectory=[self  GetDocumentsDirectory];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    if([fileManager fileExistsAtPath:filePath]) //如果存在
    {
        statu= YES;
    }
    return statu;
}

+(BOOL) CheckJsonFile
{
    BOOL statu=NO;
    NSString * documentsDirectory=[self  GetDocumentsDirectory];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * filePath = [documentsDirectory stringByAppendingPathComponent:[self JsonFileName]];
    if([fileManager fileExistsAtPath:filePath]) //如果存在
    {
        statu= YES;
    }
    return statu;
}


+(void) GoHome:(UIViewController *) curview
{
    
    UIStoryboard * stryBoard=[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    curview.view.window.rootViewController=[stryBoard instantiateInitialViewController];
    
}

+(void) GoToShowView:(UIViewController *) curview WithIdentifier:(NSString *) showviewIdentifier WithUserEntity:(NSMutableDictionary *)param HasNavController:(BOOL) status 
{
    
    //全代码跳转
    
    UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    //获取SecondViewController实例，参数是StoryBoard ID,选中View Controller,在Identity Inspector中
    CommonUIViewController * playview=[mainStoryBoard instantiateViewControllerWithIdentifier:showviewIdentifier];
    
    //设置过渡的样式，和显示的样式
    playview.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    playview.modalPresentationStyle=UIModalPresentationCurrentContext;
    playview.userEntity=param;
    if(status==YES)
    {
      //在导航状态下显示
      [[curview navigationController]pushViewController:playview animated:YES];
     
    }
    else
    {
      //直接显示
      [curview presentViewController:playview animated:NO completion:nil];
         
    }
    
    
}

+(void) GoToShowView:(UIViewController *) curview WithIdentifier:(NSString *) showviewIdentifier WithUserEntity:(NSMutableDictionary *)param
{
    [self GoToShowView:curview WithIdentifier:showviewIdentifier WithUserEntity:param HasNavController:NO];
}

+(void) GoToShowView:(UIViewController *) curview WithIdentifier:(NSString *) showviewIdentifier 
{
    [self GoToShowView:curview WithIdentifier:showviewIdentifier WithUserEntity:nil HasNavController:NO];
}

+(void) ShowTextInfo:(NSString *) txt OntheView:(CommonUIViewController *) rootview
{
    
    [self ShowTextInfo:txt OntheView:rootview SleepTime:2];
    
}

+(void) ShowTextInfo:(NSString *) txt OntheView:(CommonUIViewController *) rootview SleepTime:(unsigned int)time
{
    
    rootview.HUD =  [[MBProgressHUD alloc] initWithView:rootview.view];
    [rootview.view addSubview:rootview.HUD];
    rootview.HUD.dimBackground=YES;
    rootview.HUD.labelText=txt;
    [rootview.HUD showAnimated:YES whileExecutingBlock:^{
        sleep(time);
    } completionBlock:^{
        [rootview.HUD removeFromSuperview];
    }];
    
}


+(void) ChangeOrientation
{
    /*
     UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
     CGRect frame = [UIScreen mainScreen].applicationFrame;
     CGPoint center = CGPointMake(frame.origin.x + ceil(frame.size.width/2), frame.origin.y + ceil(frame.size.height/2));
     if (orientation == UIInterfaceOrientationLandscapeLeft) {
     return CGAffineTransformMakeRotation(M_PI*1.5);
     } else if (orientation == UIInterfaceOrientationLandscapeRight) {
     return CGAffineTransformMakeRotation(M_PI/2);
     } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
     return CGAffineTransformMakeRotation(-M_PI);
     } else {
     return CGAffineTransformIdentity;
     }
     [[UIApplication sharedApplication] setStatusBarOrientation:UIDeviceOrientationLandscapeRight animated:YES];
     
     CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
     
     //（获取当前电池条动画改变的时间）
     [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:duration];
     [UIView commitAnimations];
     */
}


+(void) addGestureRecognizerToView:(UIView *)view CanRotate:(BOOL) rotatestatus CanPinch:(BOOL) pinchstatu Canpan:(BOOL)panstatu Cantap:(BOOL) tapstatus
{
   
    
    if(rotatestatus)
    {
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    }
    if(pinchstatu)
    {
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    }
    if(panstatu)
    {
        // 移动手势
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        panGestureRecognizer.enabled=NO;
        [view addGestureRecognizer:panGestureRecognizer];
        
    }
    if(tapstatus)
    {
    UITapGestureRecognizer * tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleclickfordisableGesture:)];
    tapGestureRecognizer.numberOfTapsRequired=2;
    [view addGestureRecognizer:tapGestureRecognizer];
    }
    
    /*
    UILongPressGestureRecognizer * longtap= [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongTapToView:)];
    longtap.numberOfTouchesRequired=1;
    longtap.minimumPressDuration=2;
    [view addGestureRecognizer:longtap];
     */
    
}


+(void) LongTapToView:(UILongPressGestureRecognizer *)rotationGestureRecognizer
    {
                UIStoryboard *mainStoryBoard=[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        
        //获取SecondViewController实例，参数是StoryBoard ID,选中View Controller,在Identity Inspector中
        CommonUIViewController * playview=[mainStoryBoard instantiateViewControllerWithIdentifier:@"goshowezine"];
        [playview dismissViewControllerAnimated:YES completion:nil];
        
  }


+(void) addGestureRecognizerToView:(UIView *)view
{
    [self addGestureRecognizerToView:(UIView *)view CanRotate:YES CanPinch:YES Canpan:YES Cantap:YES];
}


// 处理旋转手势
+(void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
+(void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
        
        
    }
}

// 处理拖拉手势
+(void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
        UIView *view = panGestureRecognizer.view;
        if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
            CGPoint translation = [panGestureRecognizer translationInView:view.superview];
            [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
            [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
        }
    
}


+(void)doubleclickfordisableGesture:(UITapGestureRecognizer * ) tapGestureRecognizer 
{
    UIView *view = tapGestureRecognizer.view;
    NSArray * list= [view gestureRecognizers];
    for (int i=0; i<[list count]; i++) {
        if([list[i] isKindOfClass:[UIPanGestureRecognizer class]])
        {
            UIPanGestureRecognizer * tpan=list[i];             
            [tpan setEnabled:!tpan.enabled];
            break;
        }
    }
}

+(BOOL) ezineviewpanstatus
{
    return _ezineviewpanstatus;
}

@end
