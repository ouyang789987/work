//
//  VideoJson.h
//  swtplayer
//
//  Created by ouyang qungang on 24/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//



@interface VideoJson : NSObject
 

@property (weak ,nonatomic) NSDictionary * allvList ;
@property (weak ,nonatomic) NSArray * homeGuide;
@property (weak ,nonatomic) NSDictionary * catList ;
@property (weak ,nonatomic) NSDictionary * areaMap ;
@property (weak ,nonatomic)  NSArray * areaList ;

@property (weak ,nonatomic) NSDictionary * catVideoList ;
@property (weak ,nonatomic) NSArray * sortcatids;
@property (weak ,nonatomic) NSDictionary * allezine ;

@property (weak ,nonatomic) NSString * SITE_URL ;
@property (weak ,nonatomic) NSString * Video_URL ;
@property (weak ,nonatomic) NSString * LogTag;

@property (weak ,nonatomic) NSDictionary * UrlData ;

@property (weak ,nonatomic) NSString * allJsonDataFileName ;
@property (weak ,nonatomic) NSString * loginstatus ;
 
@property (weak ,nonatomic) NSString * SDVideoFolder ;


-(id)GetVideoList:(NSString * )videojsstr;
-(id)GetAreaList:(NSString * )areajsstr;
-(id)GetCatList:(NSString * )catjsstr;
-(id)InitCatList:(NSString * )catjsstr;

@end
