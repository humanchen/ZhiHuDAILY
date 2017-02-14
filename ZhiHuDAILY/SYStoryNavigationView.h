

#import <UIKit/UIKit.h>
//#import "SYExtraStory.h"

@class SYStoryNavigationView;

@protocol SYStoryNavigationViewDelegate <NSObject>

- (void)storyNavigationView:(SYStoryNavigationView *)navView didClicked:(NSInteger)index;

@end


@interface SYStoryNavigationView : UIView

//@property (nonatomic, strong) SYExtraStory *extraStory;

@property (nonatomic, weak) id<SYStoryNavigationViewDelegate> delegate;


+ (instancetype)storyNaviView;

@end
