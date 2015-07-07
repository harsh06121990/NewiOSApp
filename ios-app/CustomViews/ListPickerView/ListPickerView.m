//
//  ListPickerView.m
//  ios-app
//
//  Created by MinhThai on 3/22/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "ListPickerView.h"

@interface ListPickerView()
    @property BOOL isExpanded;
    @property CGFloat expandViewHeight;
@end

@implementation ListPickerView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ListPickerView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[ListPickerView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        [self setFrame:frame];
    }
    
    self.lblTitle.text = title;
    [self setup];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

// This method is overriden to allow the child views (that are out of bound)
// able to receive touch
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if ( CGRectContainsPoint(self.expandView.frame, point) )
        return YES;
    
    return [super pointInside:point withEvent:event];
}

- (void)setup {
    CGFloat margin = self.btnExpand.frame.size.width * 1.0/3;
    self.btnExpand.imageEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    self.parentView.layer.cornerRadius = self.parentView.frame.size.height / 2;
    self.parentView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.parentView.layer.borderWidth = 2;
    self.parentView.backgroundColor = [UIColor clearColor];
    
    
}

- (IBAction)btnExpandClick:(id)sender {
    if(self.isExpanded) {
        [self unexpand];
    }
    else {
        if(self.expandView == nil)
            [self createExpandView];
        [self expand];
    }
}

- (void)createExpandView {
    CGFloat height = 0, width = self.frame.size.width;
    CGFloat offset = self.frame.size.height;
    CGFloat itemHeight = offset * 3.0/4;
    
    self.expandView = [[UIView alloc]init];
    int n = self.Data.count;
    for(int i = 0; i < n; ++i) {
        UILabel *lbl = [[UILabel alloc]init];
        lbl.text = [self.Data objectAtIndex:i];
        lbl.textColor = [UIColor whiteColor];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        
        UIView *item = [[UIView alloc]initWithFrame:(CGRect){{20, height}, {width, itemHeight}}];
        item.tag = i;
        [item addSubview:lbl];
        [lbl sizeToFit];
        
        height += itemHeight;
        
        // Center the lable in view
        CGPoint center = lbl.center;
        center.y = item.frame.size.height / 2;
        [lbl setCenter:center];
        
        // Add touch event
        [self addTouchEvent:item];
        
        [self.expandView addSubview:item];
    }
    
    [self.expandView setFrame:CGRectMake(0, offset, width, height)];
    self.expandView.layer.zPosition = 99;
    self.expandView.clipsToBounds = YES;
    [self roundCornerBottom:self.expandView radius:self.parentView.frame.size.height / 2];
    [self.expandView setFrame:CGRectMake(0, offset, width, 0)]; // set it to 0 to hide
    
    [self addSubview:self.expandView];

    // save the height
    self.expandViewHeight = height;
}

- (void)expand {    
    [UIView animateWithDuration:0.3 animations:^{
        [self.expandView setFrame:(CGRect){self.expandView.frame.origin, {self.frame.size.width, self.expandViewHeight}}];
        self.btnExpand.transform = CGAffineTransformMakeRotation(M_PI);
    }completion:^(BOOL finished) {
        self.isExpanded = YES;
    }];
}

- (void)unexpand {
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.expandView setFrame:(CGRect){self.expandView.frame.origin, {self.frame.size.width, 0}}];
        self.btnExpand.transform = CGAffineTransformMakeRotation(0);
    }completion:^(BOOL finished) {
        self.isExpanded = NO;
    }];
}

- (void)roundCornerBottom:(UIView *)view radius:(CGFloat)R {
    // add cornder radius
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(R, R)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path  = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
    // add border
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = view.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth   = 4.0f;
    borderLayer.strokeColor = [UIColor whiteColor].CGColor;
    borderLayer.fillColor   = [UIColor clearColor].CGColor;
    
    [view.layer addSublayer:borderLayer];
}


- (void)addTouchEvent:(UIView *)view {
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [view addGestureRecognizer:singleFingerTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    UIView *selected = recognizer.view;
    NSString *selectedValue = ((UILabel*)([selected.subviews objectAtIndex:0])).text;
    int index = (int)selected.tag;
    
    // replace title
    self.lblTitle.text = selectedValue;
    
    // trigger event
    if (self.delegate) [self.delegate onItemSelected:self value:(NSString*)selectedValue index:(int)index];
}

- (void)scrollViewTap:(UITapGestureRecognizer *)recognizer {

}
@end
