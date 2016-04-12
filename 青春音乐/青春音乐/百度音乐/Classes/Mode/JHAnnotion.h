//
//  JHAnnotion.h
//  导航画线和打开苹果应用
//
//  Created by cjj on 16-4-6.
//  Copyright (c) 2016年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface JHAnnotion : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end
