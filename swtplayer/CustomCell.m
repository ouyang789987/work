//
//  CustomCell.m
//  swtplayer
//
//  Created by ouyang qungang on 08/02/2014.
//  Copyright (c) 2014 欧阳群刚. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize textLabel;
@synthesize imageView;
@synthesize detailTextLabel;
@synthesize image;
@synthesize title;
@synthesize detail;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setImage:(UIImage *)img {
    if (![img isEqual:image]) {
        image = [img copy];
        self.imageView.image = image;
    }
}

-(void)setTitle:(NSString *)n {
    if (![n isEqualToString:title]) {
        title = [n copy];
        self.textLabel.text = title;
    }
}

-(void)setDetai:(NSString *)d {
    if (![d isEqualToString:detail]) {
        detail = [d copy];
        self.detailTextLabel.text = detail;
    }
}
 

@end
