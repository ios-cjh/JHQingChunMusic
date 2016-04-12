//
//  JHMapViewController.m
//  青春音乐OFJH
//
//  Created by cjj on 16-4-8.
//  Copyright (c) 2016年 jh.chen. All rights reserved.
//

#import "JHMapViewController.h"
#import <MapKit/MapKit.h>
#import "JHAnnotion.h"

@interface JHMapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)backToCurrentLocal;

@end

@implementation JHMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"地图";
    
    self.mapView.delegate = self;
    // 显示用户位置
    self.mapView.showsUserLocation = YES;
    // 设置用户跟踪模式
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
}
#pragma mark - MKMapViewDelegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *ID = @"id";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    
    // 设置大头针的颜色
    annotationView.pinColor = MKPinAnnotationColorPurple;
    // 设置地图以动画形式降临
    annotationView.animatesDrop = YES;
    // 设置可以显示大头针的额外信息
    annotationView.canShowCallout = YES;
    return annotationView;
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // 获取location
    CLLocation *location = userLocation.location;
    
    // 通过location获取经度、纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    // 显示经度、纬度
//    [self mapPoint:coordinate];
    
    // 标记范围
    MKCoordinateSpan span;
    span.latitudeDelta = 0.9;
    span.longitudeDelta = 0.9;
    MKCoordinateRegion region = {coordinate,span};
    [self.mapView setRegion:region];
    
    // 解析地理当前用户的地理位置 (反地理编译)
    __weak typeof(self) weakSelf = self;
    CLGeocoder *geocode = [[CLGeocoder alloc] init];
    [geocode reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count == 0 || error) return;
        
        // 使用CLPlacemark解析地理位置
        CLPlacemark *placeMark = [placemarks firstObject];
        NSDictionary *addressDictionary = placeMark.addressDictionary;
        
        // 添加大头针
        JHAnnotion *anno = [[JHAnnotion alloc] init];
        anno.title = addressDictionary[@"name"];
        anno.coordinate= coordinate;
        [weakSelf.mapView addAnnotation:anno];
        
    }];
    
}

// 返回用户当前的位置
- (IBAction)backToCurrentLocal {
    CLLocationCoordinate2D center = self.mapView.userLocation.coordinate;
    [self.mapView setCenterCoordinate:center animated:YES];
}
@end
