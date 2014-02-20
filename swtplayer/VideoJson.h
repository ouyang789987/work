//
//  VideoJson.h
//  swtplayer
//
//  Created by ouyang qungang on 24/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//



@interface VideoJson : NSObject
 

@property (strong ,nonatomic) NSDictionary * allvList ;
@property (strong ,nonatomic) NSArray * homeGuide;
@property (strong ,nonatomic) NSDictionary * catList ;
@property (strong ,nonatomic) NSDictionary * areaMap ;
@property (strong ,nonatomic)  NSArray * areaList ;

@property (strong ,nonatomic) NSDictionary * catVideoList ;
@property (strong ,nonatomic) NSArray * sortcatids;
@property (strong ,nonatomic) NSDictionary * allezine ;

@property (strong ,nonatomic) NSString * SITE_URL ;
@property (strong ,nonatomic) NSString * Video_URL ;
@property (strong ,nonatomic) NSString * LogTag;

@property (strong ,nonatomic) NSDictionary * UrlData ;

@property (strong ,nonatomic) NSString * allJsonDataFileName ;
@property (strong ,nonatomic) NSString * loginstatus ;
 
@property (strong ,nonatomic) NSString * SDVideoFolder ;


-(id)GetVideoList:(NSString * )videojsstr;
-(id)GetAreaList:(NSString * )areajsstr;
-(id)GetCatList:(NSString * )catjsstr;
-(id)InitCatList:(NSString * )catjsstr;

@end
