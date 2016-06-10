//
//  JHAudioTool.h
//  百度音乐OFJH
//
//  Created by cjj on 15-10-5.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JHAudioTool : NSObject

/** 播放音乐*/
+ (AVAudioPlayer *) playMusic:(NSString *)filename;

/** 暂停音乐*/
+ (void) pauseMusic:(NSString *)filename;

/** 停止音乐*/
+ (void) stopMusic:(NSString *)filename;

@end
