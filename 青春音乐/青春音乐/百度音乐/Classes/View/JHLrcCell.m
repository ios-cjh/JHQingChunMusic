//
//  JHLrcCell.m
//  百度音乐OFJH
//
//  Created by cjj on 15-10-10.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import "JHLrcCell.h"
#import "JHLrcLine.h"

@implementation JHLrcCell



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"lrc";
    JHLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.numberOfLines = 0;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

- (void)setLrcLine:(JHLrcLine *)lrcLine
{
    _lrcLine = lrcLine;
    self.textLabel.text = lrcLine.word;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
}

@end
