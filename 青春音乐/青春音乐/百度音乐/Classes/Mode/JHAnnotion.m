//
//  JHAnnotion.m
//  导航画线和打开苹果应用
//
//  Created by cjj on 16-4-6.
//  Copyright (c) 2016年 jh. All rights reserved.
// Default-568h@2x.png  Default-568h@2x.png

#import "JHAnnotion.h"

@implementation JHAnnotion


-(NSString *)title
{
    return @"您当前的位置";
}
-(NSString *)subtitle
{
    if (_subtitle == nil) {
        return _subtitle;
    }
    return @"";
}

@end
