//
//  JHLrcView.h
//  百度音乐OFJH
//
//  Created by cjj on 15-10-9.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import "DRNRealTimeBlurView.h"

@interface JHLrcView : DRNRealTimeBlurView

@property (nonatomic, copy) NSString *lrcname;
@property (nonatomic, assign) NSTimeInterval currentTime;
@end
