//
//  CommonFn.h
//  swtplayer
//
//  Created by ouyang qungang on 12/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CommonFn : NSObject


 
+(NSString *)JsonFileName;
+(NSString *)SiteUrl;

+(NSMutableDictionary *)AllvList;

+(NSMutableDictionary *)CatList;

+(NSMutableDictionary *)CatVideoList;

+(NSMutableDictionary *) AreaList;

+(NSMutableDictionary *) EzineList;

+(NSString *) GetDocumentsDirectory ;

+(BOOL) writeNSDictData:(NSDictionary *)data  writeFileName:(NSString *)fileName;
+(NSDictionary *) readNSDictData:(NSString *)fileName;

+(BOOL) writeNSStringData:(NSString *)data  writeFileName:(NSString *)fileName;
+(NSString *) readNSStringData:(NSString *)fileName;
+(void)varbinit;
+(NSDictionary *) ParseJsonData:(NSString *)data;

+(NSDictionary *) ParseJsonData;

+(void) FormatJsonDict;

+(BOOL) CheckFileExist:(NSString *)fileName;

+(BOOL) CheckJsonFile;

+(void) GoHome:(UIViewController *) curview;
+(void) GoToShowView:(UIViewController *) curview WithIdentifier:(NSString *) showviewIdentifier WithUserEntity:(NSMutableDictionary *)param HasNavController:(BOOL) status ;

+(void) GoToShowView:(UIViewController *) curview WithIdentifier:(NSString *) showviewIdentifier WithUserEntity:(NSMutableDictionary *)param;

+(void) GoToShowView:(UIViewController *) curview WithIdentifier:(NSString *) showviewIdentifier ;
+(void) ChangeOrientation;
@end
