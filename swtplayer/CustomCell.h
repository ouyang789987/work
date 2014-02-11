//
//  CustomCell.h
//  swtplayer
//
//  Created by ouyang qungang on 08/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel * textLabel;
@property (retain, nonatomic) IBOutlet UIImageView * imageView;
@property (retain, nonatomic) IBOutlet UILabel * detailTextLabel;

@property (copy, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * detail;


@end
