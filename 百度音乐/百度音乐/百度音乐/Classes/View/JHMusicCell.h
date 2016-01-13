//
//  JHMusicCell.h
//  百度音乐OFJH
//
//  Created by cjj on 15-10-4.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHMusic;
@interface JHMusicCell : UITableViewCell
+ (instancetype) cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) JHMusic *music;

@end
