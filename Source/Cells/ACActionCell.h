//
//  VCRActionCell.h
//  Vacarious
//
//  Created by Anton Remizov on 10/31/15.
//  Copyright © 2015 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* ACActionCellIdentifier;

@interface ACActionCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* title;
@property (nonatomic, strong) IBOutlet UIImageView* image;

@end
