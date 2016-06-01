//
//  VCRArrayViewController.m
//  Vacarious
//
//  Created by Anton Remizov on 3/14/16.
//  Copyright © 2016 Appcoming. All rights reserved.
//

#import "ACViewController.h"

static NSMutableDictionary* _VCRArrayViewControllerRegisteredNibs = nil;

@interface ACViewController ()
{
    UITableView* _tableView;
    NSArray*(^_vmBlock)();
}

@property (nonatomic, strong) ACController* arrayController;

@end

@implementation ACViewController

+ (void)initialize {
    [ACViewController registerNib:[UINib nibWithNibName:@"VCRAddItemCell"
                                                 bundle:nil]
                    forIdentifier:@"VCRAddItemCell"];
    
    [ACViewController registerNib:[UINib nibWithNibName:@"CheckinCell"
                                                 bundle:nil]
                    forIdentifier:@"checkin"];
    [ACViewController registerNib:[UINib nibWithNibName:@"VCRCountCell"
                                                 bundle:nil]
                    forIdentifier:@"VCRCountCell"];
    [ACViewController registerNib:[UINib nibWithNibName:@"VCRPickerCell"
                                                 bundle:nil]
                    forIdentifier:@"VCRPickerCell"];
    [ACViewController registerNib:[UINib nibWithNibName:@"VCRSwitchCell"
                                                 bundle:nil]
                    forIdentifier:@"VCRSwitchCell"];
    [ACViewController registerNib:[UINib nibWithNibName:@"VCRDatePicker"
                                                 bundle:nil]
                    forIdentifier:@"VCRDatePicker"];
    [ACViewController registerNib:[UINib nibWithNibName:@"VCRActionCell"
                                                 bundle:nil]
                    forIdentifier:@"VCRActionCell"];
    [ACViewController registerNib:[UINib nibWithNibName:@"VCRPhotoCell"
                                                 bundle:nil]
                    forIdentifier:@"VCRPhotoCell"];
    [ACViewController registerNib:[UINib nibWithNibName:@"VCRHeaderCell"
                                                 bundle:nil]
                    forIdentifier:@"VCRHeaderCell"];
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

@end
