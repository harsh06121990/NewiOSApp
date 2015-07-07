//
//  FirstViewController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 2/1/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "FirstViewController.h"
#import "Constants.h"
#import "CADebugLog.h"
#import "OAuthLoginView.h"
#import "LoadingDialog.h"

@interface FirstViewController () {
    UIButton *secretButton;
    OAuthLoginView *linkedInLoginView;
    LoadingDialog *ldialog;
    UIView *dimmedView;

}
    @property BOOL isSignUpViewOpenned;
    @property BOOL isSignInViewOpenned;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setup];
    [self setupView];
    [self playAnimation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Check if a user is logged in or not
    if([[UserHelper getInstance] checkIfUserIsLoggedIn]){
        CADLog(@"User is already logged in");
        [UserUtil retrievePersonalInfo:^(bool success, id result) {
            if (success) {
                [self setupLoggedInView:YES];
            }
        }];
        
    }
    
    if (secretButton == nil) {
        secretButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        [secretButton setTitle:@"S" forState:UIControlStateNormal];
        [secretButton setTintColor:[UIColor blackColor]];
        [secretButton addTarget:self action:@selector(secretBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:secretButton];
    }
}

- (void)secretBtnTapped:(id)sender {
    [self presentViewController:MainTabBar animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Initial code to set up elements in page
- (void)setupView {
    [self alignView];
    [_viewConnektHolder.layer setCornerRadius:_viewConnektHolder.frame.size.height/2];
    [_viewFacebookHolder.layer setCornerRadius:_viewFacebookHolder.frame.size.height/2];
    [_viewTwitterHolder.layer setCornerRadius:_viewTwitterHolder.frame.size.height/2];
    [_viewLinkedInHolder.layer setCornerRadius:_viewLinkedInHolder.frame.size.height/2];
    
    // Colour for first title
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: _lblTitle_1.attributedText];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:THEME_ORANGE_COLOR
                 range:NSMakeRange(0, 7)];
    [_lblTitle_1 setAttributedText: text];
    
    // Underline for sign up text
    text = [[NSMutableAttributedString alloc]
            initWithAttributedString: _btnGoToSignup.titleLabel.attributedText];
    [text addAttributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)} range:NSMakeRange (0, text.length)];
    [self.btnGoToSignup.titleLabel setAttributedText:text];
}

// Function for setting up view for a already logged in user
- (void)setupLoggedInView {
    [self setupLoggedInView:TRUE];
}

// Function for setting up view for a already logged in user with animation parameter
- (void)setupLoggedInView:(BOOL) animated {
    [self.navigationController presentViewController:MainTabBar animated:YES completion:nil];
}

- (void)alignView {
    
}

- (void)playAnimation {
    
    // Execute animations
    // ----------------------
    //CGFloat oldConstraint = self.autoConstraintsSigninLeading.constant;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (IBAction)loginFB:(id)sender {
    [FacebookUtil loginFB:^(FBSession *session, FBSessionState state, NSError *error) {
        if (!error) {
            [FacebookUtil requestUserGraph:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                if (!error) {
                    CADLog(@"Complete getting user's Facebook data");
                    [FacebookUtil setUser:user];
                }
            }];
        }
    }];
}

- (IBAction)linkedInbuttonPressed:(id)sender
{
    [self getProfileDetailsFromLinkedIn];
}

-(void)getProfileDetailsFromLinkedIn
{
    linkedInLoginView=[[OAuthLoginView alloc] init];
    linkedInLoginView.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailsOfProfile:) name:@"loginViewDidFinish" object:nil];
    [self presentViewController:linkedInLoginView animated:YES completion:nil];
}


-(void)showDetailsOfProfile:(NSNotification *)notification{
    
    NSDictionary *jsonResponse = notification.userInfo;
    
    NSLog(@"notification  : %@", notification.userInfo);
    
    NSString *position;
    NSString *company;
    if([jsonResponse objectForKey:@"positions"])
    {
        if ([[jsonResponse objectForKey:@"positions"] objectForKey:@"values"])
        {
            if([[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0])
            {
                if ([[[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"title"])
                {
                    position=[[[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"title"];
                }
                
                
                if ([[[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"company"])
                {
                    
                    if ([[[[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"company"]objectForKey:@"name"])
                    {
                        company=[[[[[jsonResponse objectForKey:@"positions"] objectForKey:@"values"] objectAtIndex:0] objectForKey:@"company"]objectForKey:@"name"];
                    }
                }
            }
        }
    }
    
    NSString *_id;
    
    if ([jsonResponse objectForKey:@"id"])
    {
        _id=[jsonResponse objectForKey:@"id"];
    }
    
    
    NSString *profileUrl;
    
    if ([jsonResponse objectForKey:@"publicProfileUrl"])
    {
        profileUrl=[jsonResponse objectForKey:@"publicProfileUrl"];
    }
    
    NSString *email;
    if ([jsonResponse objectForKey:@"emailAddress"])
    {
        email=[jsonResponse objectForKey:@"emailAddress"];
    }
    
    NSString *industry;
    if ([jsonResponse objectForKey:@"industry"])
    {
        industry=[jsonResponse objectForKey:@"industry"];
    }
    
    NSString *pictureUrl;
    if ([jsonResponse objectForKey:@"pictureUrl"])
    {
        pictureUrl=[jsonResponse objectForKey:@"pictureUrl"];
    }
    
    
    NSString *biography;
    if ([jsonResponse objectForKey:@"summary"])
    {
        biography=[jsonResponse objectForKey:@"summary"];
    }
    
    
    NSString *location;
    if ([jsonResponse objectForKey:@"location"])
    {
        NSDictionary *locationDictionary = [jsonResponse objectForKey:@"location"];
        location = [locationDictionary objectForKey:@"name"];
        //location = [location substringToIndex:[location rangeOfString:@","].location];
    }
    
    NSString *twitterAccountName;
    if ([jsonResponse objectForKey:@"primaryTwitterAccount"])
    {
        if ([[jsonResponse objectForKey:@"primaryTwitterAccount"] objectForKey:@"providerAccountName"])
        {
            twitterAccountName=[[jsonResponse objectForKey:@"primaryTwitterAccount"] objectForKey:@"providerAccountName"];
        }
    }
    
    NSString *day;
    NSString *month;
    NSString *year;
    NSDate *dob ;
    if ([jsonResponse objectForKey:@"dateOfBirth"] ) {
        
        day = [[jsonResponse objectForKey:@"dateOfBirth"] objectForKey:@"day"];
        month = [[jsonResponse objectForKey:@"dateOfBirth"] objectForKey:@"month"];
        year = [[jsonResponse objectForKey:@"dateOfBirth"] objectForKey:@"year"];
        
        NSString *str ;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        [formatter setTimeZone:gmt];
        str = [NSString stringWithFormat:@"%@/%@/%@ 00:00 AM",month,day,year];
        dob = [formatter dateFromString:str];
        
        
    }
    
    NSString *contactNumber;
    if ([jsonResponse objectForKey:@"phoneNumbers"]) {
        if ([[jsonResponse objectForKey:@"phoneNumbers"] objectForKey:@"values"]) {
            NSArray *arr = [[jsonResponse objectForKey:@"phoneNumbers"] objectForKey:@"values"];
            if ([arr count]>0) {
                NSDictionary *con = [arr objectAtIndex:0];
                contactNumber = [con objectForKey:@"phoneNumber"];
            }
        }
    }
    
    NSMutableDictionary *infodict = [[NSMutableDictionary alloc] init];

    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM-dd-yyyy"];
    NSDate *odate = [dateformatter dateFromString:@"06-21-1991"];
    NSString *dateBirth = [dateformatter stringFromDate:dob];
    if(dateBirth == nil)
        dateBirth = @"";
    
    
    if(email == nil)
        email = @"";
    
    [infodict setValue:[notification.userInfo valueForKey:@"firstName"] forKey:@"userName"];
    [infodict setValue:@"12345" forKey:@"password"];
    [infodict setValue:email forKey:@"email"];
    [infodict setValue:odate forKey:@"dob"];
    [infodict setValue:@"Type here..." forKey:@"introduction"];
    [infodict setValue:@"ENGINEER" forKey:@"type"];
    [infodict setValue:@"e.g. graphic design, UI/UX (designer) \ne.g. css, html (developer)" forKey:@"skill"];
    
    [self signUpintoApp:infodict];
    
}

-(void)signUpintoApp:(NSMutableDictionary *)Infodict
{
    [ldialog setTitle:@"Signing up..."];
    [self showLoading];
    
    [UserUtil signUp:[Infodict valueForKey:@"userName"]
      passwordOfUser:[Infodict valueForKey:@"password"]
         emailOfuser:[Infodict valueForKey:@"email"]
     userDateOfBirth:[Infodict valueForKey:@"dob"]
  introductionOfUser:[Infodict valueForKey:@"introduction"]
            userType:[Infodict valueForKey:@"type"]
        skillsOfuser:[Infodict valueForKey:@"skill"]
            callback:^(bool success, id result) {
                if (success) {
                    [ldialog setTitle:@"loging in..."];
                    [UserUtil login:[Infodict valueForKey:@"userName"]
                           password:[Infodict valueForKey:@"password"]
                           callback:^(bool success, id result) {
                               
                               [UserUtil retrievePersonalInfo:^(bool success, id result) {
                                   [self hideLoading];
                                   if (success) {
                                       [self.navigationController presentViewController:MainTabBar animated:YES completion:nil];
                                   } else {
                                       
                                   }
                               }];
                           }];
                } else {
                    
                }
            }];

}

- (void)showLoading {
    [dimmedView addSubview:ldialog];
    [ldialog setCenter:dimmedView.center];
    [ldialog startAnimation];
    [self.view addSubview:dimmedView];
    [self.view bringSubviewToFront:dimmedView];
    
    [dimmedView setAlpha:0.0f];
    [UIView animateWithDuration:0.3 animations:^{
        [dimmedView setAlpha:1.0f];
    } completion:^(BOOL finished) {
        return;
    }];
}

- (void)hideLoading {
    [UIView animateWithDuration:0.3 animations:^{
        [dimmedView setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [ldialog stopAnimation];
        [dimmedView removeFromSuperview];
        [ldialog removeFromSuperview];
    }];
}

- (void)setup {
//    self.titleView.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.5];
//    
//    self.tvExperience.textColor = [UIColor lightGrayColor];
//    self.tvExperience.layer.cornerRadius = 10;
//    self.tvExperience.layer.borderWidth = 2;
//    self.tvExperience.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.tvExperience.text = @"e.g. Spokesperson at a conference.";
//    [self.tvExperience setTintColor:[UIColor whiteColor]];
//    
//    self.btnSignup.backgroundColor = THEME_RED_COLOR;
//    self.btnSignup.layer.cornerRadius = self.btnSignup.frame.size.height / 2;
    
    // change color of title
//    NSMutableAttributedString *text =
//    [[NSMutableAttributedString alloc]
//     initWithAttributedString: self.lblTitle_7.attributedText];
//    [text addAttribute:NSForegroundColorAttributeName
//                 value:THEME_RED_COLOR
//                 range:NSMakeRange(0, 7)];
//    [self.lblTitle_7 setAttributedText: text];
//    
//    self.tvExperience.delegate = self;
    
    if (ldialog == nil) {
        ldialog = [[LoadingDialog alloc] initWithFrame:CGRectMake(50, 50, 250, 70)];
    }
    
    if (dimmedView == nil) {
        dimmedView = [[UIView alloc] init];
        [dimmedView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        dimmedView.backgroundColor = [AppUtil colorRGBA:0 :0 :0 :0.3];
        // Add click event
        /*
         UITapGestureRecognizer *singleClick1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dummy_Click:)];
         [dimmedView addGestureRecognizer:singleClick1];
         */
    }
}

@end
