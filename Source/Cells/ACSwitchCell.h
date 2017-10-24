//
//  VCRSwitchCell.h
//  Vacarious
//
//  Created by Anton Remizov on 10/31/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACActionCell.h"

extern NSString* ACSwitchCellIdentifier;

@interface ACSwitchCell : ACActionCell

@property (nonatomic, strong) IBOutlet UISwitch* switchView;
@property (nonatomic, copy) void (^changedBlock)(BOOL value);

@end
