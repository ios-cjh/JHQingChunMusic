//
//  JHIntroduce.m
//  青春音乐OFJH
//
//  Created by cjj on 16-3-24.
//  Copyright (c) 2016年 jh.chen. All rights reserved.
//

#import "JHIntroduce.h"

@implementation JHIntroduce

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)introduceWithDict:(NSDictionary *)dict;
{
    return [[self alloc] initWithDict:dict];
}
@end
