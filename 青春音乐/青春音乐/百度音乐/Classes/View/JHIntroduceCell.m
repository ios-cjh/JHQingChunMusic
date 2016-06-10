//
//  JHIntroduceCell.m
//  青春音乐OFJH
//
//  Created by cjj on 16-3-24.
//  Copyright (c) 2016年 jh.chen. All rights reserved.
//

#import "JHIntroduceCell.h"
#import "JHIntroduce.h"
#import "JHIntroduceFrame.h"



@interface JHIntroduceCell()
/** 图片*/
@property(nonatomic, weak) UIImageView *iconView;

/** 内容*/
@property(nonatomic, weak) UIButton *contentBtn;

@end

@implementation JHIntroduceCell



+(instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"intro";
    JHIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHIntroduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor colorWithRed:206 / 255.0 green:254 / 255.0 blue:206 / 255.0 alpha:1.0];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 图片
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        // 内容
        UIButton *contentBtn = [[UIButton alloc] init];
        [contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        contentBtn.titleLabel.font = JHFont(11.0);
        contentBtn.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:contentBtn];
        self.contentBtn = contentBtn;
    }
    return self;
}

-(void)setIntroduceF:(JHIntroduceFrame *)introduceF
{
    _introduceF = introduceF;
    
    JHIntroduce *introduc = introduceF.introduce;
    
    // 图标
    self.iconView.image = [UIImage imageNamed:introduc.icon];
    self.iconView.frame = introduceF.iconF;
    
    // 内容
    [self.contentBtn setTitle:introduc.content forState:UIControlStateNormal];
    self.contentBtn.frame = introduceF.contentF;
    
    
    
}

@end
