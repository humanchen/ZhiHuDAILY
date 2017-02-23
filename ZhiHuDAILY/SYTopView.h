

#import <UIKit/UIKit.h>
#import "DetailStory.h"
@interface SYTopView : UIView


@property (nonatomic, strong) DetailStory *story;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
-(void)reset;
+ (instancetype)topView;

@end
