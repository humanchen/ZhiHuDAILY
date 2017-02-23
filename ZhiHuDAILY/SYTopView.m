#import "SYTopView.h"
@interface SYTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@end


@implementation SYTopView


- (void)setStory:(DetailStory *)story {
    _story = story;
    if (story.image) {

         [self.imageView yy_setImageWithURL:[NSURL URLWithString:story.image] options:YYWebImageOptionProgressiveBlur |YYWebImageOptionSetImageWithFadeAnimation];
        self.titleLabel.text = story.title;
        self.titleLabel.shadowColor=[UIColor blackColor];
        self.titleLabel.shadowOffset=CGSizeMake(1, 1);
        self.titleLabel.font = [UIFont boldSystemFontOfSize:21];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        self.sourceLabel.text = [@"来源 " stringByAppendingString:story.image_source];
        self.sourceLabel.tintColor=[UIColor whiteColor];
        self.sourceLabel.shadowColor=[UIColor blackColor];
        self.sourceLabel.shadowOffset=CGSizeMake(0.5, 0.5);
    }
    

    
    [self reset];
    [self setNeedsLayout];
}


-(void)reset{
    CGSize maximumLabelSize = CGSizeMake(kScreenWidth-20-15, 9999);//labelsize的最大值
    
    CGSize expectSize = [self.titleLabel sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
//    cell.label.frame = CGRectMake(20, self.bounds.size.height-20-expectSize.height, expectSize.width, expectSize.height);
    
    _topHeight.constant=self.bounds.size.height-25-expectSize.height;
    [self setNeedsLayout];
    
    [self.gradientLayer removeFromSuperlayer];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor, (__bridge id)[UIColor clearColor].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 1.0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    gradientLayer.frame = CGRectMake(0, self.bounds.size.height-150, kScreenWidth, 150);
    self.gradientLayer=gradientLayer;
    [self.imageView.layer addSublayer:gradientLayer];
}


+ (instancetype)topView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SYTopView" owner:self options:nil] firstObject];
}
@end
