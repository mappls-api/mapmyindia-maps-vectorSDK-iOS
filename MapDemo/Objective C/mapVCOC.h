//
//  mapVCOC.h
//  MapDemo
//
//  Created by CE Info on 30/07/18.
//  Copyright © 2018 MMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapbox/Mapbox.h>
#import <MapmyIndiaAPIKit/MapmyIndiaAPIKit.h>

@interface mapVCOC : UIViewController <MGLMapViewDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic) NSString *strType;
@end
