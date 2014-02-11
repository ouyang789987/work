//
//  VideoJson.m
//  swtplayer
//
//  Created by ouyang qungang on 24/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "VideoJson.h"

@implementation VideoJson

@synthesize   allvList ;
@synthesize   homeGuide;
@synthesize   catList ;
@synthesize   areaMap ;
@synthesize   areaList ;

@synthesize   catVideoList ;
@synthesize   sortcatids;
@synthesize   allezine ;

@synthesize   SITE_URL ;
@synthesize   Video_URL ;
@synthesize   LogTag;

@synthesize   UrlData ;

@synthesize   allJsonDataFileName ;
@synthesize   loginstatus ;

@synthesize   SDVideoFolder ;


- (id)init {
    self = [super init];
    if (self) {
        SDVideoFolder=@"/SDTempVideo/";
        loginstatus = @"status.txt";
        allJsonDataFileName = @"alljson.txt";
    }
    return self;
}





-(id)GetVideoList:(NSString * )videojsstr
{
    
    return @"";
}

-(id)GetAreaList:(NSString * )areajsstr
{
    return @"";
}

-(id)GetCatList:(NSString * )catjsstr
{
    return @"";
}

-(id)InitCatList:(NSString * )catjsstr
{
    return @"";
}


@end
