//
//  IosPageViewController.h
//  swtplayer
//
//  Created by oyqg on 14-3-5.
//
//

#import <UIKit/UIKit.h>

@interface IosPageViewController : UIPageViewController<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (strong, nonatomic)  NSMutableDictionary *  userEntity;
@property (nonatomic,strong) NSMutableArray * ezinepagesurl;
@property (nonatomic,strong) NSMutableArray * pagesview;

@end
