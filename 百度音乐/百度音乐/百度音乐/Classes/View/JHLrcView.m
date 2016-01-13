//
//  JHLrcView.m
//  百度音乐OFJH
//
//  Created by cjj on 15-10-9.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import "JHLrcView.h"
#import "JHLrcLine.h"
#import "JHLrcCell.h"


@interface JHLrcView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *lrcLines;
@property (nonatomic, assign) int currentIndex;

@end

@implementation JHLrcView

- (NSMutableArray *)lrcLines
{
    if (_lrcLines == nil) {
        self.lrcLines = [NSMutableArray array];
    }
    return _lrcLines;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}



- (void)setup
{
    // 添加表格控件
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:tableView];
    self.tableView = tableView;
}


/**
 *  把歌曲内容截串赋值给时间或者是歌词 (外界给歌词文件)
 */
 /*
 [ti:简单爱]
 [ar:周杰伦]
 [al:范特西]
 [00:-0.91]简单爱

 [00:06.97]作词：徐若瑄  作曲：周杰伦
 [00:08.33]演唱：周杰伦
 [00:11.03]
 */
- (void)setLrcname:(NSString *)lrcname
{
    _lrcname = lrcname;
    
    [self.lrcLines removeAllObjects];
    
    // 加载歌词文件
    NSURL *url = [[NSBundle mainBundle] URLForResource:lrcname withExtension:nil];
    NSString *lrcStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray *lrcCmps = [lrcStr componentsSeparatedByString:@"\n"];
    
    // 输出每一行歌词
    for (NSString *lrcCmp in lrcCmps) {
        JHLrcLine *line = [[JHLrcLine alloc] init];
        [self.lrcLines addObject:line];
        if(![lrcCmp hasPrefix:@"["]) continue;
        
        // 如果是歌词的头部信息 (歌名、歌手、专辑)
        if([lrcCmp hasPrefix:@"[ti:"] || [lrcCmp hasPrefix:@"[ar:"] || [lrcCmp hasPrefix:@"[al:"]){
            NSString *word = [[lrcCmp componentsSeparatedByString:@":" ] lastObject];
            line.word = [word substringToIndex:word.length - 1];
        } else { // 非头部信息
            NSArray *array = [lrcCmp componentsSeparatedByString:@"]"];
            line.time = [[array firstObject] substringFromIndex:1];
            line.word = [array lastObject];
        }
    }
    [self.tableView reloadData];
}


-(void)setCurrentTime:(NSTimeInterval)currentTime
{
   
    // 当往前拖动，从头开始比较歌词时间
    if (currentTime < _currentTime) {
        self.currentIndex = -1;
    }
    
    _currentTime = currentTime;
    
    // 播放器播放的时间
    int minute = currentTime / 60;
    int second = (int)currentTime % 60;
    int msecond = (currentTime - (int)currentTime) * 100;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d.%02d", minute, second, msecond];
    
    int count = self.lrcLines.count;
    // 每次取出当前歌词时间之后的歌词时间比较，不用每次都从头比较
    for (int idx = self.currentIndex + 1; idx<count; idx++) {
        // 获取模型中的歌词时间
        JHLrcLine *currentLine = self.lrcLines[idx];
        // 当前模型的时间
        NSString *currentLineTime = currentLine.time;
        
        
        // 下一个模型的时间
        NSString *nextLineTime = nil;
        NSUInteger nextIdx = idx + 1;
        if (nextIdx < self.lrcLines.count) {
            JHLrcLine *nextLine = self.lrcLines[nextIdx];
            nextLineTime = nextLine.time;
        }
        
        
        // 判断是否为正在播放的歌词，并且不是当前行才刷新
        if (
            ([currentTimeStr compare:currentLineTime] != NSOrderedAscending)
            && ([currentTimeStr compare:nextLineTime] == NSOrderedAscending)
            && self.currentIndex != idx) {
            // 刷新tableView
            NSArray *reloadRows = @[
                                    [NSIndexPath indexPathForRow:self.currentIndex inSection:0],
                                    [NSIndexPath indexPathForRow:idx inSection:0]
                                    ];
            self.currentIndex = idx;
            [self.tableView reloadRowsAtIndexPaths:reloadRows withRowAnimation:UITableViewRowAnimationNone];
            // 滚动到对应的行
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.height * 0.5, 0, self.tableView.height * 0.5, 0);
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHLrcCell *cell = [JHLrcCell cellWithTableView:tableView];
    cell.lrcLine = self.lrcLines[indexPath.row];
    
    if (self.currentIndex == indexPath.row) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
        cell.textLabel.textColor = [UIColor blueColor];
    } else {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}


#pragma mark - UITableViewDelegate


@end
