//
//  JHMusic.h
//  百度音乐OFJH
//
//  Created by cjj on 15-10-4.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHMusic : NSObject

/**
 *  歌曲名字
 */
@property (copy, nonatomic) NSString *name;
/**
 *  歌曲大图
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  歌曲的文件名
 */
@property (copy, nonatomic) NSString *filename;
/**
 *  歌词的文件名
 */
@property (copy, nonatomic) NSString *lrcname;
/**
 *  歌手
 */
@property (copy, nonatomic) NSString *singer;
/**
 *  歌手图标
 */
@property (copy, nonatomic) NSString *singerIcon;

@end
