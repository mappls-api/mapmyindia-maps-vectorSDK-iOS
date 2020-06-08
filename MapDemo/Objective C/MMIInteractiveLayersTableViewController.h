//
//  CovidLayersTableVC.h
//  MapDemo
//
//  Created by apple on 04/06/20.
//  Copyright © 2020 MMI. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapmyIndiaAPIKit;

NS_ASSUME_NONNULL_BEGIN

@protocol MMIInteractiveLayersTableViewControllerDelegate<NSObject>

- (void)layersSelected:(NSArray<MapmyIndiaInteractiveLayer *> *) selectedInteractiveLayers;

@end

@interface MMIInteractiveLayersTableViewController : UITableViewController

@property(nonatomic, weak, nullable) id<MMIInteractiveLayersTableViewControllerDelegate> delegate;

@property (nonatomic, readwrite, nullable) NSArray<MapmyIndiaInteractiveLayer *> *interactiveLayers;
@property (nonatomic, readwrite, nullable) NSArray<MapmyIndiaInteractiveLayer *> *selectedInteractiveLayers;

@end

NS_ASSUME_NONNULL_END
