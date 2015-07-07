//
//  MeViewActionBar.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/11/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "MeViewActionBar.h"

@implementation MeViewActionBar
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MeViewActionBar" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[MeViewActionBar class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
        [self setFrame:frame];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setup];
}

- (void)setup {
    [_btnAbout addTarget:self action:@selector(aboutSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_btnWork addTarget:self action:@selector(workSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_btnChat addTarget:self action:@selector(chatSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_btnAdd addTarget:self action:@selector(addWork:) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnAdd setBackgroundColor:[AppUtil colorHex:@"#308366"]];
    
    [_imgProfilePic setContentMode:UIViewContentModeScaleAspectFill];
    dispatch_queue_t waitQueue = dispatch_queue_create("com.connekt.waiter", nil);
    dispatch_async(waitQueue, ^{
        [NSThread sleepForTimeInterval:0.1];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([NSThread isMainThread]) {
                [_imgProfilePic.layer setCornerRadius:_imgProfilePic.frame.size.height/2];
                [_imgProfilePic setClipsToBounds:YES];
            }
        });
    });
    
    [_viewTabHolder setBackgroundColor:THEME_COLOR_DARK];
    [_viewInfoHolder setBackgroundColor:[AppUtil colorForUserType:@"DESIGNER"]];
    [self setBackgroundColor:[AppUtil colorForUserType:@"DESIGNER"]];
}

#pragma mark Event-Handlers
- (void)aboutSelect:(id)sender {
    [_btnAbout setBackgroundColor:[AppUtil colorForUserType:@"DESIGNER"]];
    [_btnWork setBackgroundColor:[UIColor clearColor]];
    [_btnAdd setHidden:YES];
    [_btnChat setHidden:NO];
    if (delegate) [delegate meActionBar:self onAboutSelect:sender];
}

- (void)workSelect:(id)sender {
    [_btnWork setBackgroundColor:[AppUtil colorForUserType:@"DESIGNER"]];
    [_btnAbout setBackgroundColor:[UIColor clearColor]];
    [_btnAdd setHidden:NO];
    [_btnChat setHidden:YES];
    if (delegate) [delegate meActionBar:self onWorkSelect:sender];
}

- (void)chatSelect:(id)sender {
    if (delegate) [delegate meActionBar:self onChat:sender];
}

- (void)addWork:(id)sender {
    if (delegate) [delegate meActionBar:self onAddWork:sender];
}

#pragma mark Custom-Methods
- (void)selectIndex:(NSInteger)index {
    if (index == 0) {
        [self aboutSelect:_btnAbout];
    } else {
        [self workSelect:_btnWork];
    }
}

@end
