//
//  ProfilePortFolioView.h
//  ios-app
//
//  Created by MinhThai on 3/8/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFQuiltLayout.h"
#import "PortfolioCollectionCell.h"
#import "ImageViewerController.h"
#import "AppDelegate.h"

@interface ProfilePortFolioView : UIView <RFQuiltLayoutDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *portfolio;

@end
