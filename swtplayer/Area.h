//
//  Area.h
//  swtplayer
//
//  Created by ouyang qungang on 24/01/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//



@interface Area : NSObject

@property (weak ,nonatomic) NSString * _id ;
@property (weak ,nonatomic) NSString * title;
@property (weak ,nonatomic) NSString * parentareatitle ;
@property (weak ,nonatomic) NSString * parentareaid ;
@property  NSInteger * sort ;
@property (weak ,nonatomic) NSString * status ;


-(int)compareTo:(id)another;

@end
