//
//  ConnectCollectionView.h
//  ios-app
//
//  Created by MinhThai on 3/4/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAImageCollectionLayout.h"

@interface ConnectCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *Data;

@end
