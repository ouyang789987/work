//
//  PSimagePageView.m
//  swtplayer
//
//  Created by oyqg on 14-3-5.
//
//

#import "PSimagePageView.h"
#import "PSDrawings.h"
#import "UIImageView+WebCache.h"

@implementation PSimagePageView
@synthesize imgpath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithImagePage:(NSString * ) imageurl
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if ( self ) {
        self.backgroundColor = [UIColor whiteColor];
        self.imgpath = imageurl;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect mainrt=[UIScreen mainScreen].bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0,mainrt.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
   
    
    
    UIImageView * imgview = [[UIImageView alloc]init];
    [imgview setImageWithURL:[NSURL URLWithString:self.imgpath]];
    CGImageRef  ref=[imgview.image CGImage];
    CGRect thumbnailRect =CGRectMake(0, 0, 480 , 300);
    NSLog(@"imageview: framesize: w %@,main bounds width %@ ok view bounds",imgview.image.size,mainrt.size);
    // Draw PDF (scaled to fit)
    CGAffineTransform transform = PSRectScaleAspectFit(thumbnailRect, CGContextGetClipBoundingBox(context));
    CGContextConcatCTM(context, transform);
	CGContextDrawImage(context,mainrt, ref);
    
    
}


@end
