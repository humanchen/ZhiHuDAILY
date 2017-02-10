//
//  HomeTableHeaderView.m
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/10.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "HomeTableHeaderView.h"
static NSString *header_reuseid = @"header_reuseid";

@interface HomeTableHeaderView ()

@property (nonatomic, weak) UILabel *dateLabel;

@end

@implementation HomeTableHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    HomeTableHeaderView  *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header_reuseid];
    if (!header) {
        header = [[HomeTableHeaderView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        [header.contentView addSubview:label];
        label.textColor = [UIColor whiteColor];
        [header.contentView addSubview:label];
        label.font = [UIFont boldSystemFontOfSize:18.];
        header.dateLabel = label;
        header.contentView.backgroundColor = Color(23, 144, 211, 1.);
    }
    return header;
}


- (void)setDate:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *da = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"MM月dd日 EEEE";
    _date = [dateFormatter stringFromDate:da];
    
    self.dateLabel.text = _date;
    [self.dateLabel sizeToFit];
    //    NSDictionary *attr = @{
    //            NSFontAttributeName: [UIFont systemFontOfSize:38.] ,
    //            NSForegroundColorAttributeName: [UIColor whiteColor]};
    //
    //    self.textLabel.attributedText = [[NSAttributedString alloc] initWithString:_date attributes:attr];
    
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.dateLabel.center = self.contentView.center;
}



@end
