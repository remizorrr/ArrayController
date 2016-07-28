//
//  ACArrayController.m
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

+ (NSDictionary*) itemWithCell:(NSString*)cell size:(CGSize)size configure:(ACConfigureBlock)configure select:(ACSelecteBlock)select {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    dict[ACCellKey] = cell;
    dict[ACSizeKey] = [NSValue valueWithCGSize:size];
    if (configure) {
        dict[ACConfigureKey] = configure;
    }
    if (select) {
        dict[ACSelectKey] = select;
    }
    
    return dict.copy;
}

+ (NSDictionary*) headerWithCell:(NSString*)cell size:(CGSize)size
                       configure:(ACConfigureBlock)configure {
    NSMutableDictionary* dict = [self itemWithCell:cell size:size configure:configure select:nil].mutableCopy;
    dict[ACCellTypeSectionKey] = @YES;
    return dict.copy;
}


+ (NSDictionary*) itemWithCell:(NSString*)cell sizeBlock:(ACSizeBlock)sizeBlock configure:(ACConfigureBlock)configure select:(ACSelecteBlock)select {
    return [self itemWithCell:cell sizeBlock:sizeBlock configure:configure select:select delete:nil];
}

+ (NSDictionary*) itemWithCell:(NSString*)cell sizeBlock:(ACSizeBlock)sizeBlock configure:(ACConfigureBlock)configure select:(ACSelecteBlock)select delete:(ACSelecteBlock)delete {
    return [self itemWithCell:cell sizeBlock:sizeBlock configure:configure select:select delete:delete edit:nil];
}

+ (NSDictionary*) itemWithCell:(NSString*)cell sizeBlock:(ACSizeBlock)sizeBlock configure:(ACConfigureBlock)configure select:(ACSelecteBlock)select delete:(ACSelecteBlock)delete edit:(ACSelecteBlock)edit {
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    dict[ACCellKey] = cell;
    dict[ACSizeKey] = sizeBlock;
    if (configure) {
        dict[ACConfigureKey] = configure;
    }
    if (select) {
        dict[ACSelectKey] = select;
    }
    if (delete) {
        dict[ACDeleteKey] = delete;
    }
    if (edit) {
        dict[ACEditKey] = edit;
    }
    return dict.copy;
}

+ (NSDictionary*) itemWithCell:(NSString*)cell size:(CGSize)size {
    return @{ACCellKey:cell,
             ACSizeKey:[NSValue valueWithCGSize:size]
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
        _delegateProxy = [ACDelegateProxy new];
        _datasourceProxy = [ACDelegateProxy new];
        _delegateProxy->_breakingDelegate = self;
        _datasourceProxy->_breakingDelegate = self;
    }
    return self;
}

- (void)setCollection:(UITableView *)collection {
    _collection = collection;
    self.collection.delegate = _delegateProxy;
    self.collection.dataSource = _datasourceProxy;
    self.collection.delegate = self;
    self.collection.dataSource = self;

}

-(void)setDelegate:(id<UITableViewDelegate>)delegate {
    _delegateProxy->_originalDelegate = delegate;
}

-(void)setDataSource:(id<UITableViewDataSource>)dataSource {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel[section][@"children"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:item[ACCellKey]];
    if (!cell) {
        NSLog(@"ArrayController Warning: Cab't create cell with identifier %@",item[ACCellKey]);
    }
    ACConfigureBlock block = item[ACConfigureKey];
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
    NSValue* size = sectionDict[ACSizeKey];
    float floatHeight;
    if (![size isKindOfClass:[NSValue class]]) {
        ACSizeBlock block = (id)size;
        floatHeight = block().height;
    } else {
        floatHeight = size.CGSizeValue.height;
    }
    return floatHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDictionary* item = self.viewModel[section][@"cell"];
    if (!item) {
        return nil;
    }
    
    UIView* view = [tableView dequeueReusableCellWithIdentifier:item[ACCellKey]];
    if (!view) {
        NSLog(@"ArrayController Warning: Cab't create cell with identifier %@",item[ACCellKey]);
    }
    ACConfigureBlock block = item[ACConfigureKey];
    if (block) {
        block(view, [NSIndexPath indexPathForRow:0 inSection:section]);
    }
    return view;

}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL result = [super respondsToSelector:aSelector];
    if ((aSelector == @selector(tableView:estimatedHeightForRowAtIndexPath:)) && self.staticCellHeight) {
        return NO;
    }
    if ((aSelector == @selector(tableView:heightForRowAtIndexPath:)) && !self.staticCellHeight) {
        return NO;
    }
    return result;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];
    NSValue* size = item[ACSizeKey];
    float floatHeight;
    if (![size isKindOfClass:[NSValue class]]) {
        ACSizeBlock block = (id)size;
        floatHeight = block().height;
    } else {
        floatHeight = size.CGSizeValue.height;
    }
    return floatHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];
    NSValue* size = item[ACSizeKey];
    float floatHeight;
    if (![size isKindOfClass:[NSValue class]]) {
        ACSizeBlock block = (id)size;
        floatHeight = block().height;
    } else {
        floatHeight = size.CGSizeValue.height;
    }
    return floatHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

-  (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* children = self.viewModel[indexPath.section][@"children"];
    NSDictionary* item = children[indexPath.row];
    ACSelecteBlock deleteBlock = item[ACDeleteKey];
    ACSelecteBlock editBlock = item[ACEditKey];
    
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
    ACSelecteBlock deleteBlock = item[ACDeleteKey];
    ACSelecteBlock editBlock = item[ACEditKey];
    return deleteBlock || editBlock;
}


@end
