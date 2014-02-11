//
//  Video.h
//  swtplayer
//
//  Created by ouyang qungang on 24/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//



@interface Video : NSObject

@property (weak, nonatomic) NSString * vid;
@property (weak, nonatomic) NSString * organizationid;
@property (weak, nonatomic) NSString * channelid;
@property (weak, nonatomic) NSString * channelidformal;;
@property (weak, nonatomic) NSString * wid;
@property (weak, nonatomic) NSString * videosubjectid;
@property (weak, nonatomic) NSString * catid;
@property (weak, nonatomic) NSString * catname;
@property (weak, nonatomic) NSString * userid;
@property (weak, nonatomic) NSString * ezineid;
@property (weak, nonatomic) NSArray * ezineList;
@property (weak, nonatomic) NSString * title;
@property (weak, nonatomic) NSString * hot;
@property (weak, nonatomic) NSString * channelhome;
@property (weak, nonatomic) NSString * recommend;
@property (weak, nonatomic) NSString * thumbnail;
@property (weak, nonatomic) NSString * photos;
@property (weak, nonatomic) NSString * intro;
@property (weak, nonatomic) NSString * embedvideohtml;
@property (weak, nonatomic) NSString * detail;
@property (weak, nonatomic) NSString * videotype;

@property (weak, nonatomic) NSString * videoarea;
@property (weak, nonatomic) NSString * director;
@property (weak, nonatomic) NSString * protagonist;
@property  NSInteger * visit;
@property   double * grade;
@property (weak, nonatomic) NSString * videopath;
@property   double * price;

@property  NSInteger * companybanner;


@property (weak, nonatomic) NSString * companyurl  ;

@property (weak, nonatomic) NSString * companytitle;


@property (weak, nonatomic) NSString * companyid;


@property (weak, nonatomic) NSString * productid;


@property (weak, nonatomic) NSString * tags;


@property (weak, nonatomic) NSString * taskid;


@property  NSInteger * sort;

@property (weak, nonatomic) NSString * password;

 
@property (weak, nonatomic) NSString * status;


-(int)compareTo:(id)another;

@end
