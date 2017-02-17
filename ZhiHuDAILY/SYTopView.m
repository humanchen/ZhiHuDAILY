

#import "SYTopView.h"
//#import "UIImageView+WebCache.h"
@interface SYTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@end


@implementation SYTopView


- (void)setStory:(DetailStory *)story {
    _story = story;
    if (story.image) {
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:story.image]];
         [self.imageView yy_setImageWithURL:[NSURL URLWithString:story.image] options:YYWebImageOptionProgressiveBlur |YYWebImageOptionSetImageWithFadeAnimation];
        self.titleLabel.text = story.title;
        self.sourceLabel.text = [@"来源 " stringByAppendingString:story.image_source];
    }
    [self setNeedsLayout];
}


+ (instancetype)topView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SYTopView" owner:self options:nil] firstObject];
}
@end
