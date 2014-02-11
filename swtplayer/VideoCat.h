//
//  VideoCat.h
//  swtplayer
//
//  Created by ouyang qungang on 24/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//



@interface VideoCat : NSObject

@property (weak ,nonatomic) NSString * _id ;
@property (weak ,nonatomic) NSString * title;
@property (weak ,nonatomic) NSString * organizationid ;
@property (weak ,nonatomic) NSString * thumbnail ;
@property (weak ,nonatomic) NSString * detail ;
@property (weak ,nonatomic) NSString * level ;
@property (weak ,nonatomic) NSString * userid ;
@property NSInteger * sortorder ;
@property (weak ,nonatomic) NSString * status ;
@property (weak ,nonatomic) NSString * datecreated  ;
@property (weak ,nonatomic) NSString * datemodified ;

@property (weak ,nonatomic) NSDictionary * subcat ;

@end
