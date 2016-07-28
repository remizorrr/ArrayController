//
//  ACArrayController.h
//  Vacarious
//
//  Created by Anton Remizov on 9/26/15.
//  Copyright (c) 2015 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* ACCellKey = @"ACCellKey";
static NSString* ACConfigureKey = @"ACConfigureKey";
static NSString* ACSizeKey = @"ACSizeKey";
static NSString* ACSelectKey = @"ACSelectKey";
static NSString* ACDeleteKey = @"ACDeleteKey";
static NSString* ACEditKey = @"ACEditKey";
static NSString* ACCellTypeSectionKey = @"ACCellTypeSectionKey";

typedef void(^ACConfigureBlock)(id cell, NSIndexPath* indexPath);
typedef void(^ACSelecteBlock)(NSIndexPath* indexPath);
typedef CGSize(^ACSizeBlock)();

@interface NSDictionary (ACController)
+ (NSDictionary*) headerWithCell:(NSString*)cell size:(CGSize)size
                       configure:(ACConfigureBlock)configure;
+ (NSDictionary*) itemWithCell:(NSString*)cell size:(CGSize)size
                     configure:(ACConfigureBlock)configure select:(ACSelecteBlock)select;
+ (NSDictionary*) itemWithCell:(NSString*)cell sizeBlock:(ACSizeBlock)height
                     configure:(ACConfigureBlock)configure select:(ACSelecteBlock)select;
+ (NSDictionary*) itemWithCell:(NSString*)cell sizeBlock:(ACSizeBlock)height configure:(ACConfigureBlock)configure select:(ACSelecteBlock)select delete:(ACSelecteBlock)delete;
+ (NSDictionary*) itemWithCell:(NSString*)cell sizeBlock:(ACSizeBlock)height configure:(ACConfigureBlock)configure select:(ACSelecteBlock)select delete:(ACSelecteBlock)delete edit:(ACSelecteBlock)edit ;
+ (NSDictionary*) itemWithCell:(NSString*)cell size:(CGSize)size;
@end


@interface ACController : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray* viewModel;
@property (nonatomic, weak) IBOutlet UITableView* collection;
@property (nonatomic, weak) IBOutlet id<UITableViewDelegate> delegate;
@property (nonatomic, weak) IBOutlet id<UITableViewDataSource> dataSource;
@property (nonatomic, copy) void(^didScrollBlock)(UIScrollView* scrollView) ;
@property (nonatomic, assign) BOOL staticCellHeight;
- (void)setViewModel:(NSArray *)viewModel reloadData:(BOOL)reload;

@end
