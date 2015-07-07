//
//  ConnectViewController.h
//  ios-app
//
//  Created by MinhThai on 3/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectCollectionView.h"
#import "ConnectTableView.h"
#import "ConnectTabBar.h"
#import "ExpandableSearchBar.h"

@interface ConnectViewController : UIViewController
{
    UIView *dropdownview;
    
    BOOL checkhidden;
}

@property (nonatomic, strong) ConnectTableView *tableView;
@property (nonatomic, strong) ConnectCollectionView *collectionView;
@property (nonatomic, strong) ConnectTabBar *tabBar;

@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *tabBarHolder;
@property (weak, nonatomic) IBOutlet UIView *layoutOptionHolder;
@property (weak, nonatomic) IBOutlet UIView *collectionViewHolder;

@property (weak, nonatomic) IBOutlet UIButton *btnLayoutCards;
@property (weak, nonatomic) IBOutlet UIButton *btnLayoutGrid;
@property (weak, nonatomic) IBOutlet UIButton *btnLayoutList;

- (IBAction)btnCardsLayoutClick:(id)sender;
- (IBAction)btnGridLayoutClick:(id)sender;
- (IBAction)btnListLayoutClick:(id)sender;

@end
