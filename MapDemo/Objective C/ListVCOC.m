//
//  ListVCOC.m
//  MapDemo
//
//  Created by CE Info on 30/07/18.
//  Copyright © 2018 MMI. All rights reserved.
//

#import "ListVCOC.h"
#import "mapVCOC.h"
#import "MultipleShapesExample.h"
#import "HighlightPointExample.h"
#import "CovidLayersExample.h"
#import "CovidSafetyStatusExample.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@interface ListVCOC ()
@property (weak, nonatomic) IBOutlet UITableView *tblList;

@end

@implementation ListVCOC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpGUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpGUI {
    self.navigationItem.title = @"Objective C";
    _listArr = @[ @"Zoom Level", @"Zoom Level With Animation", @"Center With Animation", @"Current Location",@"Tracking Mode", @"Add Marker", @"Add Multiple Markers With Bounds", @"Polyline" ,@"Polygons",
                  @"Autosuggest", @"Geocoding (Forward Geocode)", @"Atlas Geocode", @"Reverse Geocoding", @"Nearby Search", @"Place/eLoc Detail Legacy", @"Place Detail", @"Driving Distance", @"Distance Matrix", @"Distance Matrix ETA", @"Route", @"Route Advance", @"Route Advance ETA", @"Feedback", @"Animate Marker", @"GeoJson Multiple Shapes", @"Custom Marker", @"Interior Polygons", @"Covid Layers", @"COVID-19 Safety Status"
                  ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_listArr count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] ;
    }
    
    cell.textLabel.text = [_listArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString  *strType = [_listArr objectAtIndex:indexPath.row];
    
    SWITCH (strType) {
        CASE (@"GeoJson Multiple Shapes") {
            MultipleShapesExample *vc = [[MultipleShapesExample alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:true];
            break;
        }
        CASE (@"Interior Polygons") {
            HighlightPointExample *vc = [[HighlightPointExample alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:true];
            break;
        }
        CASE (@"Covid Layers") {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainC" bundle:nil];
            CovidLayersExample *controller = [storyboard instantiateViewControllerWithIdentifier:@"CovidLayersExample"];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        CASE (@"COVID-19 Safety Status") {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainC" bundle:nil];
            CovidSafetyStatusExample *controller = [storyboard instantiateViewControllerWithIdentifier:@"CovidSafetyStatusExample"];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        DEFAULT {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainC" bundle:nil];
            mapVCOC *controller = [storyboard instantiateViewControllerWithIdentifier:@"mapVCOC"];
            controller.strType = strType;
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
    }
}
    

@end
