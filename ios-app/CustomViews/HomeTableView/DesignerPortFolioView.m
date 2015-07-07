//
//  DesignerPortFolioView.m
//  ios-app
//
//  Created by MinhThai on 2/28/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "DesignerPortFolioView.h"
#import "Utility.h"

static const int maxNumberOfItems = 4;

@interface DesignerPortFolioView () {
    CGFloat left_margin;
    CGFloat top_margin;
    CGFloat margin;
}
@end

@implementation DesignerPortFolioView
@synthesize data;

- (void)measure {
    int left = 60, top = 30;
    
    self.maxWidth -= left;
    self.maxHeight -= top;
    
    margin = 5;
    left_margin = left / 2;
    top_margin = top / 2;
}

- (void)setItemCount:(NSInteger)itemCount
{
    _itemCount = itemCount;
    
    // Important!!! The system may reuse previous view so we have to make sure
    // the view is always empty
    while (self.subviews.count > 0) {
        [self.subviews.lastObject removeFromSuperview];
    }
    
    [self measure];
    [self createAndArrange];
}

- (void)createAndArrange {
    // For testing purpose
    NSArray *imgs = @[@"sample_google", @"sample_event", @"sample_image1", @"sample_JohnDoe"];
    
    int count =  [AppUtil min:self.itemCount :maxNumberOfItems];
    
    // I manually arrange the layout for 4 cases
    // -------------------------------------------
    switch (count) {
        case 1:
            [self create1Item: imgs];
            break;
        case 2:
            [self create2Items: imgs];
            break;
        case 3:
            [self create3Items: imgs];
            break;
        case 4:
            [self create4Items: imgs];
            break;
    }
}

- (void)reloadData {
    // I manually arrange the layout for 4 cases
    // -------------------------------------------
    switch (data.count) {
        case 1:
            [self create1Item: data];
            break;
        case 2:
            [self create2Items: data];
            break;
        case 3:
            [self create3Items: data];
            break;
        case 4:
            [self create4Items: data];
            break;
    }
}

- (void)create1Item:(NSArray *)imgs {
    UIView *img1 = [self createItem:[imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]]];
    CGRect rect = (CGRect){{left_margin, top_margin},{self.maxWidth, self.maxHeight}};
    img1.frame = rect;
    
    [self addSubview:img1];
}

- (void)create2Items:(NSArray *)imgs {
    UIImage *imgName1 = [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]];
    UIImage *imgName2 = [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]];
    
    UIView *img1 = [self createItem:imgName1];
    CGRect rect1 = (CGRect){{left_margin, top_margin},{self.maxWidth / 2 - margin, self.maxHeight}};
    
    UIView *img2 = [self createItem:imgName2];
    CGRect rect2 = (CGRect){{self.maxWidth / 2 + margin + left_margin, top_margin},{self.maxWidth / 2 - margin, self.maxHeight}};
    
    img1.frame = rect1;
    img2.frame = rect2;
    
    [self addSubview:img1];
    [self addSubview:img2];
}

- (void)create3Items:(NSArray *)imgs {
    UIImage *imgName1 = [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]];
    UIImage *imgName2 = [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]];
    UIImage *imgName3 = [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]];
    
    CGFloat haftW = self.maxWidth / 2;
    CGFloat haftH = self.maxHeight / 2;
    
    UIView *img1 = [self createItem:imgName1];
    CGRect rect1 = (CGRect){{left_margin, top_margin},{haftW - margin, self.maxHeight}};
    
    UIView *img2 = [self createItem:imgName2];
    CGRect rect2 = (CGRect){{haftW + margin + left_margin, top_margin},{haftW - margin, haftH - margin}};
    
    UIView *img3 = [self createItem:imgName3];
    CGRect rect3 = (CGRect){{haftW + margin + left_margin, haftH + margin + top_margin},{haftW - margin, haftH - margin}};
    
    img1.frame = rect1;
    img2.frame = rect2;
    img3.frame = rect3;
    
    [self addSubview:img1];
    [self addSubview:img2];
    [self addSubview:img3];
}

- (void)create4Items:(NSArray *)imgs {
    UIImage *imgName1 = [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]];
    UIImage *imgName2 = [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]];
    UIImage *imgName3 = [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]];
    UIImage *imgName4 = [imgs objectAtIndex:[AppUtil randomRange:0 :imgs.count]];
    
    CGFloat thirdW = self.maxWidth / 3;
    CGFloat halfH = self.maxHeight / 2;
    
    UIView *img1 = [self createItem:imgName1];
    CGRect rect1 = (CGRect){{left_margin, top_margin},{thirdW - margin, self.maxHeight}};
    
    UIView *img2 = [self createItem:imgName2];
    CGRect rect2 = (CGRect){{thirdW + 2 * margin + left_margin, top_margin},{thirdW - margin, halfH - margin}};
    
    UIView *img3 = [self createItem:imgName3];
    CGRect rect3 = (CGRect){{thirdW + 2 * margin + left_margin, halfH + margin + top_margin},{thirdW - margin, halfH - margin}};
    
    UIView *img4 = [self createItem:imgName4];
    CGRect rect4 = (CGRect){{thirdW * 2 + 4 * margin + left_margin, top_margin},{thirdW - margin, self.maxHeight}};
    
    img1.frame = rect1;
    img2.frame = rect2;
    img3.frame = rect3;
    img4.frame = rect4;
    
    [self addSubview:img1];
    [self addSubview:img2];
    [self addSubview:img3];
    [self addSubview:img4];
}

- (UIView *)createItem:(UIImage *)image {
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.layer.cornerRadius = 5;
    imgView.clipsToBounds = YES;
    imgView.backgroundColor = [AppUtil colorHex:@"#E0E0E0"];
    
    [imgView setImage:image];
    return imgView;
}


@end
