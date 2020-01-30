//
//  MMILocationPuckView.h
//  MapDemo
//
//  Created by apple on 19/08/19.
//  Copyright © 2019 MMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMILocationPuckView : UIView
- (void)updateWithLocation:(CLLocation*)location pitch:(CGFloat)pitch direction:(CLLocationDegrees)direction animated:(BOOL)animated tracksUserCourse:(BOOL)tracksUserCourse;
@end

NS_ASSUME_NONNULL_END
