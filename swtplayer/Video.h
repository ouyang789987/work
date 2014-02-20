//
//  Video.h
//  swtplayer
//
//  Created by ouyang qungang on 24/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//



@interface Video : NSObject

@property (strong, nonatomic) NSString * vid;
@property (strong, nonatomic) NSString * organizationid;
@property (strong, nonatomic) NSString * channelid;
@property (strong, nonatomic) NSString * channelidformal;;
@property (strong, nonatomic) NSString * wid;
@property (strong, nonatomic) NSString * videosubjectid;
@property (strong, nonatomic) NSString * catid;
@property (strong, nonatomic) NSString * catname;
@property (strong, nonatomic) NSString * userid;
@property (strong, nonatomic) NSString * ezineid;
@property (strong, nonatomic) NSArray * ezineList;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * hot;
@property (strong, nonatomic) NSString * channelhome;
@property (strong, nonatomic) NSString * recommend;
@property (strong, nonatomic) NSString * thumbnail;
@property (strong, nonatomic) NSString * photos;
@property (strong, nonatomic) NSString * intro;
@property (strong, nonatomic) NSString * embedvideohtml;
@property (strong, nonatomic) NSString * detail;
@property (strong, nonatomic) NSString * videotype;

@property (strong, nonatomic) NSString * videoarea;
@property (strong, nonatomic) NSString * director;
@property (strong, nonatomic) NSString * protagonist;
@property  NSInteger * visit;
@property   double * grade;
@property (strong, nonatomic) NSString * videopath;
@property   double * price;

@property  NSInteger * companybanner;


@property (strong, nonatomic) NSString * companyurl  ;

@property (strong, nonatomic) NSString * companytitle;


@property (strong, nonatomic) NSString * companyid;


@property (strong, nonatomic) NSString * productid;


@property (strong, nonatomic) NSString * tags;


@property (strong, nonatomic) NSString * taskid;


@property  NSInteger * sort;

@property (strong, nonatomic) NSString * password;

 
@property (strong, nonatomic) NSString * status;


-(int)compareTo:(id)another;

@end
