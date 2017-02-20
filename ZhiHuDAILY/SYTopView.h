

#import <UIKit/UIKit.h>
#import "DetailStory.h"
@interface SYTopView : UIView


@property (nonatomic, strong) DetailStory *story;

-(void)reset;
+ (instancetype)topView;

@end
