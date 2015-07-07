//
//  SearchTableViewCell.h
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/12/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@class SearchTableViewCell;
@protocol SearchTableViewCellDelegate <NSObject>

- (void)searchTableViewCell:(SearchTableViewCell *)cell componentTapped:(UIView *)component atIndexPath:(NSIndexPath *)indexPath;

@end
@interface SearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnProfilePic;
@property (weak, nonatomic) IBOutlet UIView *viewInfoHolder;
@property (weak, nonatomic) IBOutlet UIView *viewTitleHolder;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *viewAllHolder;
@property (weak, nonatomic) IBOutlet UIView *viewBtnProfileHolder;

- (void)setColorForType:(NSString *)userType;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) id delegate;

@end
