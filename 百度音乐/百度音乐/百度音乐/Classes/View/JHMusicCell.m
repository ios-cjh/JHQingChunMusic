//
//  JHMusicCell.m
//  百度音乐OFJH
//
//  Created by cjj on 15-10-4.
//  Copyright (c) 2015年 jh.chen. All rights reserved.
//

#import "JHMusicCell.h"
#import "JHMusic.h"
#import "UIImage+MJ.h"
#import "Colours.h"

@implementation JHMusicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *ID = @"music";
    JHMusicCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JHMusicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)setMusic:(JHMusic *)music
{
    _music = music;
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
    self.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:3 borderColor:[UIColor pinkColor]];

}


@end
