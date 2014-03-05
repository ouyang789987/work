//
//  ShowEzineViewController.h
//  swtplayer
//
//  Created by oyqg on 14-2-26.
//
//

#import "CommonUIViewController.h"
#import "PSPagesViewController.h"
#import "PSimagePageView.h"

@interface ShowEzineViewController : PSPagesViewController {
    
}

@property (nonatomic,strong)NSMutableArray * ezinepagesurl;
@property (strong, nonatomic)  NSMutableDictionary *  userEntity;

- (id)initWithImagePage:(NSString *) imageurl;
@end
