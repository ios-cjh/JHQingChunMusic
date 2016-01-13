//
//  JHMusicsViewController.m
//  百度音乐OFJH
//
//  Created by cjj on 15-10-4.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import "JHMusicsViewController.h"
#import "JHMusic.h"
#import "MJExtension.h"
#import "JHMusicCell.h"
#import "JHPlayingViewController.h"
#import "JHMusicTool.h"

@interface JHMusicsViewController ()
@property (nonatomic, strong) JHPlayingViewController *playingVc;
@end

@implementation JHMusicsViewController

// 懒加载
-(JHPlayingViewController *)playingVc
{
    if (_playingVc == nil) {
        self.playingVc = [[JHPlayingViewController alloc] init];
    }
    return _playingVc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [JHMusicTool musics].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    JHMusicCell *cell = [JHMusicCell cellWithTableView:tableView];
    cell.music = [JHMusicTool musics][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取消选中背景色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 2.设置正在播放的歌曲
    [JHMusicTool setPlayingMusic:[JHMusicTool musics][indexPath.row]];
    
    // 3. 显示播放界面
    [self.playingVc show];
    
}
@end





