//
//  UIBarButtonItem+Extension.m
//  百度音乐OFJH
//
//  Created by cjj on 16-3-23.
//  Copyright (c) 2016年 jh.chen. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    btn.size = btn.currentBackgroundImage.size;
    // 监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
