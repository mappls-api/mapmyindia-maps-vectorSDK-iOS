//
//  CustomPointAnnotation.h
//  MapDemo
//
//  Created by apple on 18/12/18.
//  Copyright © 2018 MMI. All rights reserved.
//

@import MapmyIndiaMaps;

// MGLAnnotation protocol reimplementation
@interface CustomAnnotation : NSObject <MGLAnnotation>

// As a reimplementation of the MGLAnnotation protocol, we have to add mutable coordinate and (sub)title properties ourselves.
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

// Custom properties that we will use to customize the annotation's image.
@property (nonatomic, copy, nonnull) UIImage *image;
@property (nonatomic, copy, nonnull) NSString *reuseIdentifier;

@end
@implementation CustomAnnotation
@synthesize eLoc;

- (void)updateEloc:(nonnull NSString *)atEloc completionHandler:(nullable void (^)(BOOL, NSString * _Nullable))completion {
    
}

@end

