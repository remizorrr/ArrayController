//
//  ARDelegateProxy.h
//  ARTableView
//
//  Created by Anton Remizov on 01/10/15.
//  Copyright (c) 2015 froggyproggy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACDelegateProxy : NSObject<UITableViewDelegate, UITableViewDataSource>
{
    @public
    id _originalDelegate;
    id _breakingDelegate;
}

@property (nonatomic, assign) SEL willNotPassSelector;

@end