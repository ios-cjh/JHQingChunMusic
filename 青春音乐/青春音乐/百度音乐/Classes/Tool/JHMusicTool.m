//
//  JHMusicTool.m
//  百度音乐OFJH
//
//  Created by cjj on 15-10-4.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import "JHMusicTool.h"
#import "JHMusic.h"
#import "MJExtension.h"


@implementation JHMusicTool

static NSArray *_musics;
static JHMusic *_playingMusic;


/**
 *  返回所有的歌曲
 */
+ (NSArray *) musics
{
    if (_musics == nil) {
        _musics = [JHMusic objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}


/**
 *  返回正在播放的歌曲
 */
+ (JHMusic *) playingMusic
{
    return _playingMusic;
}
+(void)setPlayingMusic:(JHMusic *)playingMusic
{
    if(playingMusic == nil || ![[self musics] containsObject:playingMusic]) return;
    if(_playingMusic == playingMusic) return;
    _playingMusic = playingMusic;
}

/**
 *   数组 static NSArray *_musics存放所有的JHMusic模型
 */

/**
 *  下一首
 */
+ (JHMusic *) nextMusic
{
    int nextIndex = 0;
    if (_playingMusic) {
        int playingIndex = [[self musics] indexOfObject:_playingMusic];
        nextIndex = playingIndex + 1;
        if (nextIndex >= [self musics].count) {
            nextIndex = 0;
        }
    }
    return [self musics][nextIndex];
}

/**
 *  上一首
 */
+ (JHMusic *) previousMusic
{
    int previousIndex = 0;
    if (_playingMusic) {
        int playingIndex = [[self musics] indexOfObject:_playingMusic];
        previousIndex = playingIndex - 1;
        if (previousIndex < 0) {
            previousIndex = [self musics].count - 1;
        }
    }
    return [self musics][previousIndex];
}
@end
