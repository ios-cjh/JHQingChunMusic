//
//  JHIntroduceFrame.h
//  青春音乐OFJH
//
//  Created by cjj on 16-3-24.
//  Copyright (c) 2016年 jh.chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JHIntroduce;
@interface JHIntroduceFrame : NSObject
/**整体的View*/
@property (nonatomic, assign) CGRect viewF;

/** 歌手图标*/
@property (nonatomic, assign) CGRect iconF;

/** 歌手内容*/
@property (nonatomic, assign) CGRect contentF;

/** cell的高度*/
@property (nonatomic, assign) CGFloat cellH;

// 传递模型数据
@property (nonatomic, strong) JHIntroduce *introduce;

@end
