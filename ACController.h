//
//  VCRArrayController.h
//  Vacarious
//
//  Created by Anton Remizov on 9/26/15.
//  Copyright (c) 2015 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* VCRCellKey = @"VCRCellKey";
static NSString* VCRConfigureKey = @"VCRConfigureKey";
static NSString* VCRSizeKey = @"VCRSizeKey";
static NSString* VCRSelectKey = @"VCRSelectKey";
static NSString* VCRDeleteKey = @"VCRDeleteKey";
static NSString* VCREditKey = @"VCREditKey";
static NSString* VCRCellTypeSectionKey = @"VCRCellTypeSectionKey";

typedef void(^VCRConfigureBlock)(id cell, NSIndexPath* indexPath);
typedef void(^VCRSelecteBlock)(NSIndexPath* indexPath);
typedef CGSize(^VCRSizeBlock)();

@interface NSDictionary (ACController)
+ (NSDictionary*) headerWithCell:(NSString*)cell size:(CGSize)size
                       configure:(VCRConfigureBlock)configure;
+ (NSDictionary*) itemWithCell:(NSString*)cell size:(CGSize)size
                     configure:(VCRConfigureBlock)configure select:(VCRSelecteBlock)select;
+ (NSDictionary*) itemWithCell:(NSString*)cell sizeBlock:(VCRSizeBlock)height
                     configure:(VCRConfigureBlock)configure select:(VCRSelecteBlock)select;
+ (NSDictionary*) itemWithCell:(NSString*)cell sizeBlock:(VCRSizeBlock)height configure:(VCRConfigureBlock)configure select:(VCRSelecteBlock)select delete:(VCRSelecteBlock)delete;
+ (NSDictionary*) itemWithCell:(NSString*)cell sizeBlock:(VCRSizeBlock)height configure:(VCRConfigureBlock)configure select:(VCRSelecteBlock)select delete:(VCRSelecteBlock)delete edit:(VCRSelecteBlock)edit ;
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
