//
//  JHLrcCell.h
//  百度音乐OFJH
//
//  Created by cjj on 15-10-10.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHLrcLine;
@interface JHLrcCell : UITableViewCell
+ (instancetype) cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) JHLrcLine *lrcLine;


@end
