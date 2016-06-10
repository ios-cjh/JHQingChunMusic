//
//  JHIntroduceFrame.m
//  青春音乐OFJH
//
//  Created by cjj on 16-3-24.
//  Copyright (c) 2016年 jh.chen. All rights reserved.
//

#import "JHIntroduceFrame.h"
#import "JHIntroduce.h"

@implementation JHIntroduceFrame


-(void)setIntroduce:(JHIntroduce *)introduce
{
    _introduce = introduce;
    // 图片
    CGFloat iconX = 10;
    CGFloat iconY = 10;
    CGFloat iconW = 60;
    CGFloat iconH = 60;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 内容
    CGFloat contentX = iconW + 20;
    CGFloat contentY = 10;
    CGFloat W = 230;
    CGSize size = [introduce.content sizeWithFont:JHFont(11.0) maxW:W];
    _contentF = (CGRect) {{contentX,contentY},size};
    
    
    _cellH = CGRectGetMaxY(_contentF)+10;
    

}

@end
