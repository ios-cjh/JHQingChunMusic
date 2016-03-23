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
#import "JHVideoController.h"
#import "JHNavigationController.h"
#import "JHIntroController.h"


@interface JHMusicsViewController ()
@property (nonatomic, strong) JHPlayingViewController *playingVc;
@property (nonatomic, weak) JHIntroController *intro;
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
    self.title = @"青春音乐";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"sidebar_nav_video" target:self action:@selector(rightClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"sidebar_nav_news" target:self action:@selector(leftClick)];
}

-(void)rightClick
{
    JHVideoController *vc = [[JHVideoController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)leftClick
{
    UIButton *btn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:btn];

    
}

-(void)btnClick:(UIButton *)btn
{
    [btn removeFromSuperview];
}

// 隐藏状态栏
//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

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





