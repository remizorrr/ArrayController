//
//  ACArrayController.m
//  Vacarious
//
//  Created by Anton Remizov on 9/26/15.
//  Copyright (c) 2015 Appcoming. All rights reserved.
//

#import "ACCollectionController.h"
#import "ACDelegateProxy.h"
#import "UIImage+Icons.h"
#import "UIColor+Hex.h"

@interface ACCollectionController()
{
    ACDelegateProxy* _delegateProxy;
    ACDelegateProxy* _datasourceProxy;
    NSArray* _sections;
}
@end

@implementation ACCollectionController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegateProxy = [ACDelegateProxy new];
        _datasourceProxy = [ACDelegateProxy new];
        _delegateProxy->_breakingDelegate = self;
        _datasourceProxy->_breakingDelegate = self;
    }
    return self;
}

- (void)setCollection:(UICollectionView *)collection {
    _collection = collection;
    self.collection.delegate = _delegateProxy;
    self.collection.dataSource = _datasourceProxy;
    self.collection.delegate = self;
    self.collection.dataSource = self;

}

-(void)setDelegate:(id<UICollectionViewDelegate>)delegate {
    _delegateProxy->_originalDelegate = delegate;
}

-(void)setDataSource:(id<UICollectionViewDataSource>)dataSource {
    _datasourceProxy->_originalDelegate = dataSource;
}

- (void)setViewModel:(NSArray *)viewModel {
    [self setViewModel:viewModel reloadData:YES];
}

- (void)setViewModel:(NSArray *)viewModel reloadData:(BOOL)reload {
    NSMutableArray* sections = [NSMutableArray array];
    NSMutableDictionary* section = [NSMutableDictionary dictionary];
    [sections addObject:section];
    NSInteger startIndex = 0;
    if(!viewModel.count) {
        _viewModel = sections;
        if (reload) {
            [self.collection reloadData];
        }
        return;
    }
    if([viewModel[0][ACCellTypeSectionKey] boolValue]) {
        section[@"cell"] = viewModel[0];
        startIndex = 1;
    }
    NSMutableArray* cells = [NSMutableArray array];
    section[@"children"] = cells;
    for (NSInteger i = startIndex; i < viewModel.count; ++i) {
        NSDictionary* item = viewModel[i];
        if([viewModel[i][ACCellTypeSectionKey] boolValue]) {
            cells = [NSMutableArray array];
            section = [NSMutableDictionary dictionary];
            section[@"children"] = cells;
            [sections addObject:section];
            section[@"cell"] = item;
            startIndex = 1;
        } else {
            [cells addObject:item];
        }
    }
    _viewModel = sections;

    if (reload) {
        [self.collection reloadData];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel[section][@"children"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:item[ACCellKey] forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"ArrayController Warning: Cab't create cell with identifier %@",item[ACCellKey]);
    }
    ACConfigureBlock block = item[ACConfigureKey];
    if (block) {
        block(cell, indexPath);
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary* cellDict = self.viewModel[indexPath.section][@"children"][indexPath.item];
    if (!cellDict) {
        return CGSizeZero;
    }
    NSValue* size = cellDict[ACSizeKey];
    CGSize floatSize;
    if (![size isKindOfClass:[NSValue class]]) {
        ACSizeBlock block = (id)size;
        floatSize = block();
    } else {
        floatSize = size.CGSizeValue;
    }
    return floatSize;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* item = self.viewModel[indexPath.section][@"cell"];
    if (!item) {
        return nil;
    }
    
    UICollectionReusableView* view = [collectionView dequeueReusableCellWithReuseIdentifier:item[ACCellKey] forIndexPath:indexPath];
    if (!view) {
        NSLog(@"ArrayController Warning: Cab't create cell with identifier %@",item[ACCellKey]);
    }
    ACConfigureBlock block = item[ACConfigureKey];
    if (block) {
        block(view, indexPath);
    }
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];

    void (^block)(NSIndexPath* indexPath) = item[ACSelectKey];
    if (!block) {
        return;
    }
    block(indexPath);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.didScrollBlock) {
        self.didScrollBlock(scrollView);
    }
}

@end
