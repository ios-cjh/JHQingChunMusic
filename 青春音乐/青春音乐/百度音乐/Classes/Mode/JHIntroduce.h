//
//  JHIntroduce.h
//  青春音乐OFJH
//
//  Created by cjj on 16-3-24.
//  Copyright (c) 2016年 jh.chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHIntroduce : NSObject
/** 歌手图片*/
@property (nonatomic, copy) NSString *icon;
/** 歌手内容*/
@property (nonatomic, copy) NSString *content;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)introduceWithDict:(NSDictionary *)dict;
@end
