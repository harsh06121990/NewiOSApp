//
//  MyWrappingView.m
//  WrapDemo
//
//  Created by Jonathon Mah on 2014-06-06.
//  This is free and unencumbered software released into the public domain.
//

#import "MyWrappingView.h"
#import "Constants.h"
#import "Utility.h"
#import "CADebugLog.h"

static const CGFloat itemHeight = 25;
static const CGFloat minItemWidth = 35;

@interface MyWrappingView () {
    CGFloat currentX;
    CGFloat currentY;
}
    @property UIScrollView *scrollView;
@end

@implementation MyWrappingView
@synthesize itemBackgroundColor, itemBorderColor, data;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.itemBorderColor = [UIColor clearColor];
        self.itemBackgroundColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)setItemCount:(NSInteger)itemCount
{
	_itemCount = itemCount;
    
    // For testing purpose
    //NSArray *langs = @[@"C++", @"C#", @"JavaScript", @"Assembly", @"Ada", @"Objective-C"];
}

- (void)reloadData {
    // Important!!! The system may reuse previous view so we have to make sure
    // the view is always empty
    while (self.subviews.count > 0) {
        [self.subviews.lastObject removeFromSuperview];
    }
    
    if(self.scrollView == nil) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:(CGRect){{0, 0}, {self.maxWidth, self.maxHeight}}];
        [self.scrollView setShowsVerticalScrollIndicator:NO];
        
        self.scrollView.contentSize = (CGSize){self.maxWidth, currentY + 2 * itemHeight}; // add some bottom margin
        [self addSubview:self.scrollView];
    }
    
    currentX = 10; currentY = 8;
    for(int i = 0; i < data.count; ++i) {
        //NSString *text = [langs objectAtIndex:[Utility randomRange:0 :langs.count]];
        NSString *text = [data objectAtIndex:i];
        [self addItem:text];
    }
}

- (void)addItem:(NSString *)text {
    CGFloat width = self.maxWidth, height = self.maxHeight;
    
    // Create label
    // ----------------
    UILabel *tag = [[UILabel alloc]init];
    tag.text = text;
    tag.textAlignment = NSTextAlignmentCenter;
    [tag setFont:[UIFont systemFontOfSize:12]];
    tag.textColor = [UIColor whiteColor];
    [tag sizeToFit];
    
    CGFloat itemW = [AppUtil max:minItemWidth :tag.frame.size.width];
    CGFloat itemH = itemHeight;
    
    CGSize itemSize = CGSizeMake(itemW, itemH);
    
    // Calculate position for the next tag
    //--------------------------------------
    if (currentX + itemW + 20 > width) {
        currentX = 10;
        currentY += itemH + 8;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(currentX, currentY, itemW + 20, itemH)];
    tag.frame = (CGRect){{10, 0}, itemSize};
    [view addSubview:tag];
    
    view.backgroundColor = itemBackgroundColor;
    [view.layer setBorderWidth:2.0f];
    [view.layer setBorderColor:[itemBorderColor CGColor]];
    view.layer.cornerRadius = itemHeight / 2;
    
    [self.scrollView addSubview:view];
    
    currentX += itemW + 20 + 10;
    
    self.scrollView.contentSize = (CGSize){width, currentY};
}

- (NSArray *)parseDataFromString:(NSString *)input {
    NSArray *result = [NSArray new];
    
    if (input != nil && ![input isEqual:[NSNull null]]) {
        result = [input componentsSeparatedByString:@","];
    }
    return result;
}

@end
