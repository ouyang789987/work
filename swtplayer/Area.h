//
//  Area.h
//  swtplayer
//
//  Created by ouyang qungang on 24/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//



@interface Area : NSObject

@property (strong ,nonatomic) NSString * _id ;
@property (strong ,nonatomic) NSString * title;
@property (strong ,nonatomic) NSString * parentareatitle ;
@property (strong ,nonatomic) NSString * parentareaid ;
@property  NSInteger * sort ;
@property (strong ,nonatomic) NSString * status ;


-(int)compareTo:(id)another;

@end
