//
//  VideoCat.h
//  swtplayer
//
//  Created by ouyang qungang on 24/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//



@interface VideoCat : NSObject

@property (strong ,nonatomic) NSString * _id ;
@property (strong ,nonatomic) NSString * title;
@property (strong ,nonatomic) NSString * organizationid ;
@property (strong ,nonatomic) NSString * thumbnail ;
@property (strong ,nonatomic) NSString * detail ;
@property (strong ,nonatomic) NSString * level ;
@property (strong ,nonatomic) NSString * userid ;
@property NSInteger * sortorder ;
@property (strong ,nonatomic) NSString * status ;
@property (strong ,nonatomic) NSString * datecreated  ;
@property (strong ,nonatomic) NSString * datemodified ;

@property (strong ,nonatomic) NSDictionary * subcat ;

@end
