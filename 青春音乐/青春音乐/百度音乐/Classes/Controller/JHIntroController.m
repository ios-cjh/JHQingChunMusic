//
//  JHIntroController.m
//  青春音乐OFJH
//
//  Created by cjj on 16-3-24.
//  Copyright (c) 2016年 jh.chen. All rights reserved.
//


#import "JHIntroController.h"
#import "JHIntroduce.h"
#import "JHIntroduceCell.h"
#import "JHIntroduceFrame.h"

@interface JHIntroController ()
@property (nonatomic, strong) NSArray *introduces;
@end

@implementation JHIntroController

-(NSArray *)introduces
{
    if (_introduces == nil) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"singerIntro.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:file];
        
        NSMutableArray *introduceFarray = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            JHIntroduce *introduce = [JHIntroduce introduceWithDict:dict];
            
            JHIntroduceFrame *introduceF = [[JHIntroduceFrame alloc] init];
            introduceF.introduce = introduce;
            [introduceFarray addObject:introduceF];
        }
        _introduces = introduceFarray;
    }
    return _introduces;
}
- (void)viewDidLoad
{
//    UIView *view = [[UIView alloc] init];206 254 205
//    view.backgroundColor = [UIColor greenColor];
//    self.tableView.backgroundView = view;
    self.tableView.backgroundColor = [UIColor colorWithRed:206 / 255.0 green:254 / 255.0 blue:206 / 255.0 alpha:1.0];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.introduces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHIntroduceCell *cell = [JHIntroduceCell cellWithTableView:tableView];
    cell.introduceF = self.introduces[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHIntroduceFrame *introduceFrame = self.introduces[indexPath.row];
    return introduceFrame.cellH;
}

@end







