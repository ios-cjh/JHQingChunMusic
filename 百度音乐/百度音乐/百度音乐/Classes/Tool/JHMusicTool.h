//
//  JHMusicTool.h
//  百度音乐OFJH
//
//  Created by cjj on 15-10-4.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//  管理音乐数据(音乐模型)

#import <Foundation/Foundation.h>
@class JHMusic;
@interface JHMusicTool : NSObject

/**
 *  返回所有的歌曲
 */
+ (NSArray *) musics;


/**
 *  返回正在的歌曲
 */
+ (JHMusic *) playingMusic;
// 我要播放哪一首 别人告诉我
+ (void) setPlayingMusic:(JHMusic *)playingMusic;


/**
 *  下一首
 */
+ (JHMusic *) nextMusic;


/**
 *  上一首
 */
+ (JHMusic *) previousMusic;

@end
