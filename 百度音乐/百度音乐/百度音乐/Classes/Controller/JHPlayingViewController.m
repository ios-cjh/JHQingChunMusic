//
//  JHPlayingViewController.m
//  百度音乐OFJH
//
//  Created by cjj on 15-10-4.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import "JHPlayingViewController.h"
#import "JHMusic.h"
#import "JHMusicTool.h"
#import "JHAudioTool.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "JHLrcView.h"

@interface JHPlayingViewController () <AVAudioPlayerDelegate>
- (IBAction)Exit;
- (IBAction)lyricOrPic:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (nonatomic, strong) JHMusic *playingMusic;
@property (nonatomic, strong) AVAudioPlayer *player;


/**
 *  添加定时器
 */
@property (nonatomic, strong) NSTimer* currentTimeTimer;
@property (nonatomic, strong) CADisplayLink *lrcTimer;

@property (weak, nonatomic) IBOutlet UIButton *slider;
@property (weak, nonatomic) IBOutlet UIView *progressView;
//点击进度条背景
 - (IBAction)tapProgressBg:(UITapGestureRecognizer *)sender;
// 滑动滑块
- (IBAction)panSlider:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIButton *currentTimeView;

- (IBAction)playOrPause;
- (IBAction)previous;
- (IBAction)next;

@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;

@property (weak, nonatomic) IBOutlet JHLrcView *lrcView;


@end

@implementation JHPlayingViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置圆角
    self.currentTimeView.layer.cornerRadius = 10;
}


#pragma mark - 公共方法
-(void)show
{
    // 禁用整个app的点击事件
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.userInteractionEnabled = NO;
    
    // 如果换了歌曲
    if (self.playingMusic != [JHMusicTool playingMusic]) {
        // 重置正在播放的音乐界面和停歌
        [self resetPlayingMusic];
    }
    
    
    // 添加播放界面
    self.view.frame = window.bounds;
    self.view.hidden = NO;
    [window addSubview:self.view];
    
    // 动画显示
    self.view.y = self.view.height;
    [UIView animateWithDuration:2.0 animations:^{
        self.view.y = 0;
    } completion:^(BOOL finished) {
        
        // 开始播放音乐
        [self startPlayingMusic];
        
        window.userInteractionEnabled = YES;
    }];
}
#pragma mark - 定时器处理器
- (void)addCurrentTimeTimer
{
    if(self.player.isPlaying == NO) return;
    [self removeCurrentTimeTimer];
    // 保证定时器的工作是及时的
    [self updateCurrentTime];
    
    self.currentTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCurrentTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.currentTimeTimer forMode:NSRunLoopCommonModes];
}

- (void)removeCurrentTimeTimer
{
    [self.currentTimeTimer invalidate];
    self.currentTimeTimer = nil;
}

/**
 *  更新播放进度
 */
-(void)updateCurrentTime
{
    // 计算进度值
    double progress = self.player.currentTime / self.player.duration;
    
    // 设置滑块的x值  短距离 / 总长度 = 当前时间 / 总时间
    CGFloat sliderMaxX = self.view.width - self.slider.width;
    self.slider.x = progress * sliderMaxX;
    
    // 设置滑块滑动时间
    [self.slider setTitle:[self strWithTime:self.player.currentTime] forState:UIControlStateNormal];
    
    // 设置蓝色进度条的宽度
    self.progressView.width = self.slider.center.x;

}

- (void)addLrcTimer
{
    if(self.player.isPlaying == NO || self.lrcView.hidden) return;
    
    [self removeLrcTimer];
    
    [self updateLrc];
    
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrc)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)removeLrcTimer
{
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
}

/**
 *  更新歌词
 */
- (void)updateLrc
{
    self.lrcView.currentTime = self.player.currentTime;
}




#pragma mark - 音乐控制
/**
 *  重置正在播放的音乐
 */
- (void)resetPlayingMusic
{
    // 重置音乐界面
    self.iconView.image = [UIImage imageNamed:@"play_cover_pic_bg"];
    self.songLabel.text = nil;
    self.singerLabel.text = nil;
    self.durationLabel = nil;
    self.player = nil;
    
    // 停止播放音乐
    [JHAudioTool stopMusic:self.playingMusic.filename];
    
    // 停止定时器
    [self removeCurrentTimeTimer];
    [self removeLrcTimer];
    
    
    // 设置播放按钮的状态
    self.playOrPauseButton.selected = NO;
}


/**
 *  开始播放音乐
 */
- (void) startPlayingMusic
{
    // 再次点击还是同一首歌 则直接返回
    if(self.playingMusic == [JHMusicTool playingMusic]) {
        [self addCurrentTimeTimer];
        [self addLrcTimer];
        return;
    }
    
    // 用一个属性变量记录当前正在放的歌曲
    self.playingMusic = [JHMusicTool playingMusic];
    self.iconView.image = [UIImage imageNamed:self.playingMusic.icon];
    self.songLabel.text = self.playingMusic.name;
    self.singerLabel.text =self.playingMusic.singer;
  
    
    // 播放音乐
    self.player = [JHAudioTool playMusic:self.playingMusic.filename];
    self.player.delegate = self;
    
    // 设置时长
    self.durationLabel.text = [self strWithTime:self.player.duration];
    
    // 开始定时器
    [self addCurrentTimeTimer];
    [self addLrcTimer];
    
    // 设置播放按钮的状态
    self.playOrPauseButton.selected = YES;
    
    // 切换歌词 加载新的歌词
    self.lrcView.lrcname = self.playingMusic.lrcname;
    
    // 切换锁屏界面的歌曲
    [self updateLockedScreenMusic];
}

/**
 *
 */
- (void)updateLockedScreenMusic
{
    // 播放信息中心
    MPNowPlayingInfoCenter *center = [MPNowPlayingInfoCenter defaultCenter];
    
    // 初始化播放信息
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    // 歌手
    info[MPMediaItemPropertyArtist] = self.playingMusic.singer;
    // 专辑名称
    info[MPMediaItemPropertyAlbumTitle] = self.playingMusic.name;
    // 歌曲名称
    info[MPMediaItemPropertyTitle] = self.playingMusic.name;
    // 设置图片
    info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:self.playingMusic.icon]];
    info[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(self.player.currentTime);
    
    center.nowPlayingInfo = info;
    
    // 开始监听远程控制事件
    // 1.从未第一响应者
    [self becomeFirstResponder];
    
    // 2.开始监控
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}


#pragma mark - 私有方法
/**
 *  时间长度NSTimeInterval ---> 时间字符串NSString typedef double NSTimeInterval
 */
- (NSString *)strWithTime:(NSTimeInterval)time
{
    int minute = time / 60;
    int second = (int)time % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minute,second];
}

#pragma mark - 内部控件的监听
- (IBAction)Exit
{
    // 移除定时器
    [self removeCurrentTimeTimer];
    [self removeLrcTimer];
    
    // 禁用整个app的点击事件
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.userInteractionEnabled = NO;
    
    // 动画隐藏
    [UIView animateWithDuration:0.5 animations:^{
        self.view.y = self.view.height;
    }completion:^(BOOL finished) {
        self.view.hidden = YES;
        window.userInteractionEnabled = YES;
    }];
}

/**
 *  切换歌词和图片
 */
- (IBAction)lyricOrPic:(UIButton *)sender
{
    if (self.lrcView.isHidden) { //显示歌词，盖住图片 毛玻璃设置是hidden
        self.lrcView.hidden = NO;
        sender.selected = YES;
        [self addLrcTimer];
    } else {
        self.lrcView.hidden = YES;
        sender.selected = NO;
        [self removeLrcTimer];
    }
}

/**
 *  点击进度条背景
 */
- (IBAction)tapProgressBg:(UITapGestureRecognizer *)sender
{
    // 获取点击的位置
    CGPoint point = [sender locationInView:sender.view];
    
    // 根据比例  当前时间/总时间 = 当前位置/进度条背景总的最大位置
    self.player.currentTime = (point.x / sender.view.width) * self.player.duration;
    
    [self updateCurrentTime];

}

/**
 *  滑动滑块
 */
- (IBAction)panSlider:(UIPanGestureRecognizer *)sender
{
    
    // 1.获得挪动的距离
    CGPoint t = [sender translationInView:sender.view];
    [sender setTranslation:CGPointZero inView:sender.view];
    
    // 2.控制滑块和进度条的frame
    CGFloat sliderMaxX = self.view.width - self.slider.width;
    if (self.slider.x < 0) {
        self.slider.x = 0;
    } else if (self.slider.x > sliderMaxX){
        self.slider.x = sliderMaxX;
    }
    
    
    self.slider.x = self.slider.x + t.x;
    self.progressView.width = self.slider.center.x;
    
    // 3.设置滑块时间值
    double progress = self.slider.x / sliderMaxX;
    // 短时间 / 总时间 = 短距离 / 总距离
    NSTimeInterval time = progress * self.player.duration;
    [self.slider setTitle:[self strWithTime:time] forState:UIControlStateNormal];
    
    
    // 4.显示半透明指示器的文字 (将半透明指示器跟着滑块一起)
    [self.currentTimeView setTitle:self.slider.currentTitle forState:UIControlStateNormal];
    self.currentTimeView.x = self.slider.x;
    self.currentTimeView.y = self.currentTimeView.superview.height - self.currentTimeView.height - 10;
    
    
    if (sender.state == UIGestureRecognizerStateBegan) { // 开始滑动
        
        [self removeCurrentTimeTimer];
        
        // 显示半透明指示器
        self.currentTimeView.hidden = NO;
    } else if (sender.state == UIGestureRecognizerStateEnded){ // 手松开
        
        // 设置半透明播放的时间 (播放歌曲)
        self.player.currentTime = time;

        if (self.player.isPlaying) {
           // 添加开始定时器
           [self addCurrentTimeTimer];
        }
        
        // 隐藏半透明指示器
        self.currentTimeView.hidden = YES;
    }
}
/**
 * 播放或暂停
 */
- (IBAction)playOrPause
{
    if (self.playOrPauseButton.isSelected) { // 暂停
        
        self.playOrPauseButton.selected = NO;
        [JHAudioTool pauseMusic:self.playingMusic.filename];
        [self removeLrcTimer];
        [self removeCurrentTimeTimer];
        
    } else { // 继续播放
     
        self.playOrPauseButton.selected = YES;
        [JHAudioTool playMusic:self.playingMusic.filename];
        [self updateLockedScreenMusic];
        [self addCurrentTimeTimer];
        [self addLrcTimer];
    }
}

/**
 * 上一首歌曲
 */
- (IBAction)previous
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.userInteractionEnabled = NO;
    
    // 重置当前的歌曲
    [self resetPlayingMusic];
    
    // 播放上一首歌曲
    [JHMusicTool setPlayingMusic:[JHMusicTool previousMusic]];
    
    // 开始播放歌曲
    [self startPlayingMusic];
    
    window.userInteractionEnabled = YES;
}

/**
 * 下一首歌曲
 */
- (IBAction)next
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.userInteractionEnabled = NO;
    
    // 重置当前歌曲
    [self resetPlayingMusic];
    
    // 播放下一首歌曲
    [JHMusicTool setPlayingMusic:[JHMusicTool nextMusic]];
    
    // 开始播放音乐
    [self startPlayingMusic];
    
    window.userInteractionEnabled = YES;
    
}


#pragma mark - AVAudioPlayerDelegate
/**
 *  播放器播放结束时调用
 */
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self next];
}

/**
 * 当播放器遇到中断的时候调用 (手机来电)
 */
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    if (self.player.isPlaying) {
        [self playOrPause];
    }
}


#pragma mark - 远程控制事件监听

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    /**
     * typedef NS_ENUM(NSInteger, UIEventType) {
       UIEventTypeTouches,        触摸事件
       UIEventTypeMotion,     加速事件
       UIEventTypeRemoteControl,    远程事件
     };
     
     UIEventSubtypeRemoteControlPlay                 = 100,
     UIEventSubtypeRemoteControlPause                = 101,
     UIEventSubtypeRemoteControlStop                 = 102,
     UIEventSubtypeRemoteControlTogglePlayPause      = 103,
     UIEventSubtypeRemoteControlNextTrack            = 104,
     UIEventSubtypeRemoteControlPreviousTrack        = 105,
     UIEventSubtypeRemoteControlBeginSeekingBackward = 106,
     UIEventSubtypeRemoteControlEndSeekingBackward   = 107,
     UIEventSubtypeRemoteControlBeginSeekingForward  = 108,
     UIEventSubtypeRemoteControlEndSeekingForward    = 109,
     */
    // event.type 事件类型
    // event.subtype 事件子类型
    
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
        case UIEventSubtypeRemoteControlPause:
            [self playOrPause];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [self next];
        case UIEventSubtypeRemoteControlPreviousTrack:
            [self previous];
            default:
            break;
    }
}

@end




