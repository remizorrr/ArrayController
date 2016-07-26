//
//  VCRArrayController.h
//  Vacarious
//
//  Created by Anton Remizov on 9/26/15.
//  Copyright (c) 2015 Appcoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACController.h"

@interface ACCollectionController : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<NSDictionary*>* viewModel;
@property (nonatomic, weak) IBOutlet UICollectionView* collection;
@property (nonatomic, weak) IBOutlet id<UICollectionViewDelegate> delegate;
@property (nonatomic, weak) IBOutlet id<UICollectionViewDataSource> dataSource;
@property (nonatomic, copy) void(^didScrollBlock)(UIScrollView* scrollView) ;
- (void)setViewModel:(NSArray *)viewModel reloadData:(BOOL)reload;

@end
