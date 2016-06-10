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
#import "JHNavigationController.h"
#import "JHIntroController.h"
#import "JHMapViewController.h"

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
    self.title = @"青春音乐";
    
    // 设置返回按钮的文字
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    // 设置导航标题
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"大头针1.png" target:self action:@selector(rightClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"sidebar_nav_news" target:self action:@selector(leftClick)];
    
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
//    self.navigationController.navigationBar.tintColor = [UIColor greenColor];

    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

-(void)rightClick
{
    NSLog(@"rightClick---");
    JHMapViewController *mapView = [[JHMapViewController alloc] init];
    [self.navigationController pushViewController:mapView animated:YES];
}

-(void)leftClick
{
    JHIntroController *intro = [[JHIntroController alloc] init];
    intro.title = @"歌手简介";
    [self.navigationController pushViewController:intro animated:YES];
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
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 设置导航栏透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    CGFloat minAlphaOffset = -5;
    CGFloat maxAlphaOffset = 20;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / ( maxAlphaOffset - minAlphaOffset);
    UINavigationBar *bar = self.navigationController.navigationBar.subviews.firstObject;
    bar.alpha = alpha;
    
   
    NSLog(@"---%.2f",alpha);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
}

@end





