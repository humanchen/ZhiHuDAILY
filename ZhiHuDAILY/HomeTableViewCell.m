//
//  SYTableViewCell.m
//  zhihuDaily
//
//  Created by yang on 16/2/22.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "HomeTableViewCell.h"
//#import "UIImageView+WebCache.h"

@interface HomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeft;
@property (weak, nonatomic) IBOutlet UIImageView *multiImage;

@end


@implementation HomeTableViewCell


- (void) setStory:(Stories *)story{
    _story = story;
        self.title.text = story.title;
    
    
        self.multiImage.hidden = !story.multipic;
    
        if (story.images.count > 0) {
            [self.image yy_setImageWithURL:[NSURL URLWithString:story.images.firstObject] options:YYWebImageOptionProgressiveBlur |YYWebImageOptionSetImageWithFadeAnimation];

            self.image.hidden = NO;
            self.titleLeft.constant = 18;
        } else {
            self.image.hidden = YES;
            self.multiImage.hidden = YES;
            self.titleLeft.constant = 18-60;
        }

}




@end
