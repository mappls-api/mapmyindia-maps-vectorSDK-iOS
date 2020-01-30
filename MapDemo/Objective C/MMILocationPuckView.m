//
//  MMILocationPuckView.m
//  MapDemo
//
//  Created by apple on 19/08/19.
//  Copyright © 2019 MMI. All rights reserved.
//

#import "MMILocationPuckView.h"
#import <CoreLocation/CoreLocation.h>

CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
};

CGFloat RadiansToDegrees(CGFloat radians)
{
    return radians * 180 / M_PI;
};

@interface MMILocationPuckView ()

    @property (strong, nonatomic) UIImageView *puckView;
    //@property (strong, nonatomic) UIView *puckView;

@end

@implementation MMILocationPuckView
    
- (void)updateWithLocation:(CLLocation*)location pitch:(CGFloat)pitch direction:(CLLocationDegrees)direction animated:(BOOL)animated tracksUserCourse:(BOOL)tracksUserCourse {
    NSTimeInterval duration = animated ? 1 : 0;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveLinear animations:^{
        CLLocationDegrees angle = tracksUserCourse ? 0 : (direction - location.course);
        [self.puckView.layer setAffineTransform:CGAffineTransformMakeRotation(-RadiansToDegrees(angle))];
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, DegreesToRadians(pitch), 1.0, 0, 0);
        transform.m34 = -1.0 / 1000;
        self.layer.sublayerTransform = transform;
    } completion:nil];
}
    
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.puckView = [[UIImageView alloc] initWithFrame:frame];
        [self.puckView setImage:[UIImage imageNamed:@ "Vehicle"]];
        self.puckView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.puckView];
    }
    return self;
}
    
@end
