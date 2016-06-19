//
//  VCRArrayController.m
//  Vacarious
//
//  Created by Anton Remizov on 9/26/15.
//  Copyright (c) 2015 Appcoming. All rights reserved.
//

#import "ACController.h"
#import "ACDelegateProxy.h"
#import "UIImage+Icon.h"
#import "UIColor+Hex.h"

@implementation NSDictionary (ACController)

+ (NSDictionary*) itemWithCell:(NSString*)cell height:(float)height configure:(VCRConfigureBlock)configure select:(VCRSelecteBlock)select {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    dict[VCRCellKey] = cell;
    dict[VCRHeightKey] = @(height);
    if (configure) {
        dict[VCRConfigureKey] = configure;
    }
    if (select) {
        dict[VCRSelectKey] = select;
    }
    
    return dict.copy;
}

+ (NSDictionary*) headerWithCell:(NSString*)cell height:(float)height
                       configure:(VCRConfigureBlock)configure {
    NSMutableDictionary* dict = [self itemWithCell:cell height:height configure:configure select:nil].mutableCopy;
    dict[VCRCellTypeSectionKey] = @YES;
    return dict.copy;
}


+ (NSDictionary*) itemWithCell:(NSString*)cell heightBlock:(VCRHeightBlock)height configure:(VCRConfigureBlock)configure select:(VCRSelecteBlock)select {
    return [self itemWithCell:cell heightBlock:height configure:configure select:select delete:nil];
}

+ (NSDictionary*) itemWithCell:(NSString*)cell heightBlock:(VCRHeightBlock)height configure:(VCRConfigureBlock)configure select:(VCRSelecteBlock)select delete:(VCRSelecteBlock)delete {
    return [self itemWithCell:cell heightBlock:height configure:configure select:select delete:delete edit:nil];
}

+ (NSDictionary*) itemWithCell:(NSString*)cell heightBlock:(VCRHeightBlock)height configure:(VCRConfigureBlock)configure select:(VCRSelecteBlock)select delete:(VCRSelecteBlock)delete edit:(VCRSelecteBlock)edit {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    dict[VCRCellKey] = cell;
    dict[VCRHeightKey] = height;
    if (configure) {
        dict[VCRConfigureKey] = configure;
    }
    if (select) {
        dict[VCRSelectKey] = select;
    }
    if (delete) {
        dict[VCRDeleteKey] = delete;
    }
    if (edit) {
        dict[VCREditKey] = edit;
    }
    return dict.copy;
}

+ (NSDictionary*) itemWithCell:(NSString*)cell height:(float)height {
    return @{VCRCellKey:cell,
             VCRHeightKey:@(height)
             };
}

@end

@interface ACController()
{
    ACDelegateProxy* _delegateProxy;
    ACDelegateProxy* _datasourceProxy;
    NSArray* _sections;
}
@end

@implementation ACController

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _delegateProxy = [VCRDelegateProxy new];
//        _datasourceProxy = [VCRDelegateProxy new];
//        _delegateProxy->_breakingDelegate = self;
//        _datasourceProxy->_breakingDelegate = self;
    }
    return self;
}

- (void)setCollection:(UITableView *)collection {
    _collection = collection;
//    self.collection.delegate = _delegateProxy;
//    self.collection.dataSource = _datasourceProxy;
    self.collection.delegate = self;
    self.collection.dataSource = self;

}

-(void)setDelegate:(id<UITableViewDelegate>)delegate {
//    _delegateProxy->_originalDelegate = delegate;
}

-(void)setDataSource:(id<UITableViewDataSource>)dataSource {
//    _datasourceProxy->_originalDelegate = dataSource;
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
        return;
    }
    if([viewModel[0][VCRCellTypeSectionKey] boolValue]) {
        section[@"cell"] = viewModel[0];
        startIndex = 1;
    }
    NSMutableArray* cells = [NSMutableArray array];
    section[@"children"] = cells;
    for (NSInteger i = startIndex; i < viewModel.count; ++i) {
        NSDictionary* item = viewModel[i];
        if([viewModel[i][VCRCellTypeSectionKey] boolValue]) {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel[section][@"children"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:item[VCRCellKey]];
    if (!cell) {
        NSLog(@"ArrayController Warning: Cab't create cell with identifier %@",item[VCRCellKey]);
    }
    VCRConfigureBlock block = item[VCRConfigureKey];
    if (block) {
        block(cell, indexPath);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSDictionary* sectionDict = self.viewModel[section][@"cell"];
    if (!sectionDict) {
        return 0.0;
    }
    NSNumber* height = sectionDict[VCRHeightKey];
    float floatHeight;
    if (![height isKindOfClass:[NSNumber class]]) {
        VCRHeightBlock block = (id)height;
        floatHeight = block();
    } else {
        floatHeight = height.floatValue;
    }
    return floatHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDictionary* item = self.viewModel[section][@"cell"];
    if (!item) {
        return nil;
    }
    
    UIView* view = [tableView dequeueReusableCellWithIdentifier:item[VCRCellKey]];
    if (!view) {
        NSLog(@"ArrayController Warning: Cab't create cell with identifier %@",item[VCRCellKey]);
    }
    VCRConfigureBlock block = item[VCRConfigureKey];
    if (block) {
        block(view, [NSIndexPath indexPathForRow:0 inSection:section]);
    }
    return view;

}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];
    NSNumber* height = item[VCRHeightKey];
    
    float floatHeight;
    if (![height isKindOfClass:[NSNumber class]]) {
        VCRHeightBlock block = (id)height;
        floatHeight = block();
    } else {
        floatHeight = height.floatValue;
    }
    return floatHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    void (^block)(NSIndexPath* indexPath) = item[VCRSelectKey];
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

-  (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];
    VCRSelecteBlock deleteBlock = item[VCRDeleteKey];
    VCRSelecteBlock editBlock = item[VCREditKey];
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSMutableArray* actions = [NSMutableArray array];
    UITableViewRowAction* action;
    if (editBlock) {
        action =
        [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                           title:@"   "
                                         handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                             editBlock(indexPath);
                                         }];
        UIImage* image = [UIImage imageWithIcon:[UIImage imageNamed:@"edit"]
                                         ofSize:CGSizeMake(45, cell.frame.size.height)
                                     background:UIColorFromHex(0xdbdbdb)
                                          blend:[UIColor whiteColor]];
        action.backgroundColor = [UIColor colorWithPatternImage:image];
        [actions addObject:action];
    }
    if (deleteBlock) {
        UIImage* trash = [UIImage imageWithIcon:[UIImage imageNamed:@"trash"]
                                         ofSize:CGSizeMake(45, cell.frame.size.height)
                                     background:UIColorFromHex(0xf43d53)
                                          blend:[UIColor whiteColor]];
        action =
        [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                           title:@"   "
                                         handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                             deleteBlock(indexPath);
                                         }];
        action.backgroundColor = [UIColor colorWithPatternImage:trash];
        [actions addObject:action];
    }

    return actions.count?actions:nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];
    VCRSelecteBlock deleteBlock = item[VCRDeleteKey];
    VCRSelecteBlock editBlock = item[VCREditKey];
    return deleteBlock || editBlock;
}


@end
