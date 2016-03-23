//
//  JHAudioTool.m
//  百度音乐OFJH
//
//  Created by cjj on 15-10-5.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import "JHAudioTool.h"

@implementation JHAudioTool

/**
 *   用字典 NSMutableDictionary *_musicPlayers存放所有的音乐播放器
 */
static NSMutableDictionary *_musicPlayers;
+ (NSMutableDictionary *)musicPlayers
{
    if (_musicPlayers == nil) {
        _musicPlayers = [NSMutableDictionary dictionary];
    }
    return _musicPlayers;
}


/**
 *  播放音乐
 */
+ (AVAudioPlayer *) playMusic:(NSString *)filename;
{
    if(filename == nil) return nil;
    
    // 取出对应的音乐播放器
    AVAudioPlayer *player = [self musicPlayers][filename];
    
    // 如果没有播放器 并进行初始化
    if (player == nil) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if(url == nil) return nil;
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        // 缓冲
        if(![player prepareToPlay]) return nil;
        
        // 将播放器存入字典
        [self musicPlayers][filename] = player;
    }
    
    // 是否正在播放
    if (![player isPlaying]) {
        [player play];
    }
    return player;
}

/**
 *   用字典 NSMutableDictionary *_musicPlayers存放所有的音乐播放器
 */

/** 
 * 暂停音乐
 */
+ (void) pauseMusic:(NSString *)filename
{
    if(filename == nil) return;
    // 取出对应的音乐播放器
    AVAudioPlayer *player = [self musicPlayers][filename];
    
    if ([player isPlaying]) {
        [player pause];
    }
}

/** 停止音乐*/
+ (void) stopMusic:(NSString *)filename
{
    if(filename == nil) return;
    
    // 取出对应的音乐播放器
    AVAudioPlayer *player = [self musicPlayers][filename];

    [player stop];
    
    // 将对应播放器从字典中移除
    [[self musicPlayers] removeObjectForKey:filename];
    
}


@end
