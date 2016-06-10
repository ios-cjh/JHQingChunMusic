//
//  JHIntroduceCell.h
//  青春音乐OFJH
//
//  Created by cjj on 16-3-24.
//  Copyright (c) 2016年 jh.chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHIntroduceFrame;
@interface JHIntroduceCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

/** 传递模型数据*/
@property (nonatomic, strong) JHIntroduceFrame *introduceF;

@end
