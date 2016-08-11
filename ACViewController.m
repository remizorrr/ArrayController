//
//  VCRArrayViewController.m
//  Vacarious
//
//  Created by Anton Remizov on 3/14/16.
//  Copyright © 2016 Appcoming. All rights reserved.
//

#import "ACViewController.h"

static NSMutableDictionary* _VCRArrayViewControllerRegisteredNibs = nil;
static NSMutableDictionary* _VCRArrayViewControllerRegisteredClasses = nil;

@interface ACViewController ()
{
    UITableView* _tableView;
    NSArray*(^_vmBlock)();
}

@property (nonatomic, strong) ACController* arrayController;

@end

@implementation ACViewController

+ (void)initialize {
    [ACViewController registerNib:[UINib nibWithNibName:@"ACCountCell"
                                                 bundle:nil]
                    forIdentifier:@"ACCountCell"];
    [ACViewController registerNib:[UINib nibWithNibName:@"ACPickerCell"
                                                 bundle:nil]
                    forIdentifier:@"ACPickerCell"];
    [ACViewController registerNib:[UINib nibWithNibName:@"ACSwitchCell"
                                                 bundle:nil]
                    forIdentifier:@"ACSwitchCell"];
    [ACViewController registerNib:[UINib nibWithNibName:@"ACDatePickerCell"
                                                 bundle:nil]
                    forIdentifier:@"ACDatePickerCell"];
    [ACViewController registerNib:[UINib nibWithNibName:@"ACActionCell"
                                                 bundle:nil]
                    forIdentifier:@"ACActionCell"];
    [ACViewController registerNib:[UINib nibWithNibName:@"ACHeaderCell"
                                                 bundle:nil]
                    forIdentifier:@"ACHeaderCell"];
    [ACViewController registerClass:[UITableViewCell class]
                    forIdentifier:@"UITableViewCell"];

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationItem.hidesBackButton = YES;
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayController = [ACController new];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [_tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:_tableView];
    self.arrayController.collection = _tableView;
    _tableView.dataSource = self.arrayController;
    _tableView.delegate = self.arrayController;
    _tableView.tableFooterView = [UIView new];
    for (NSString* key in _VCRArrayViewControllerRegisteredNibs) {
        [_tableView registerNib:_VCRArrayViewControllerRegisteredNibs[key]
         forCellReuseIdentifier:key];
    }
    for (NSString* key in _VCRArrayViewControllerRegisteredClasses) {
        [_tableView registerClass:_VCRArrayViewControllerRegisteredClasses[key]
         forCellReuseIdentifier:key];
    }
    [self refreshModel];
}

- (IBAction)cancel:(id)sender {
    if (self.completionBlock) {
        self.completionBlock(NO);
    }
    [self.navigationController popViewControllerAnimated:YES];
};

- (IBAction)save:(id)sender {
    if (self.completionBlock) {
        self.completionBlock(YES);
    }
    [self.navigationController popViewControllerAnimated:YES];
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setViewModel:(NSArray*)viewModel {
    self.arrayController.viewModel = viewModel;
}

- (void) setViewModelBlock:(NSArray*(^)())vmBlock {
    _vmBlock= vmBlock;
    [self refreshModel];
}

- (UITableView *)tableView {
    return _tableView;
}

- (void) refreshModel {
    if (_vmBlock) {
        self.arrayController.viewModel = _vmBlock();
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

+ (void) registerNib:(UINib*)nib forIdentifier:(NSString*)identifier {
    if (!_VCRArrayViewControllerRegisteredNibs) {
        _VCRArrayViewControllerRegisteredNibs = [NSMutableDictionary dictionary];
    }
    _VCRArrayViewControllerRegisteredNibs[identifier] = nib;
}

+ (void) registerClass:(Class)class forIdentifier:(NSString*)identifier {
    if (!_VCRArrayViewControllerRegisteredClasses) {
        _VCRArrayViewControllerRegisteredClasses = [NSMutableDictionary dictionary];
    }
    _VCRArrayViewControllerRegisteredClasses[identifier] = class;
}


@end
