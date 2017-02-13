//
//  DetailStory.h
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/13.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "BaseModel.h"

@interface DetailStory : BaseModel
/** body */
@property (nonatomic, copy) NSString *body;

/** 图片来源 */
@property (nonatomic, copy) NSString *image_source;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 图片*/
@property (nonatomic, copy) NSString *image;
/** 源url */
@property (nonatomic, copy) NSString *share_url;

/**推荐者*/
//@property (nonatomic,strong) NSArray<SYRecommender *> *recommenders;

/**id  新闻的 id*/
@property (nonatomic, assign) long long id;

/**css  供手机端的 WebView(UIWebView) 使用*/
@property (nonatomic, strong) NSArray *css;

/**html  供手机端的 WebView(UIWebView) 使用*/
@property (nonatomic, copy) NSString *htmlStr;

@end
