//
//  EditProfileViewController.m
//  ios-app
//
//  Created by Nguyen Minh Tu on 3/19/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController () {
    UIView *transLayer;
}

@end

@implementation EditProfileViewController
@synthesize currentSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:THEME_COLOR_DARK];
    [self.viewTabBarHolder setBackgroundColor:THEME_COLOR_DARK];
    
    // this will appear as the title in the navigation bar
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    // ^-Use UITextAlignmentCenter for older SDKs.
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Edit profile", @"");
    [label sizeToFit];
    
    [self createLeftBarButton];
    [self createSaveButton];
    //[self.navigationItem setb]
}

- (void)createLeftBarButton {
    //Create UIButton
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [backButton setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    
    //Create UIBarbuttonItem and add UIButton in it
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //Add UIBarButtonItem to NavigationBar
    [self.navigationItem setLeftBarButtonItem:backBarButton];
}

- (void)createSaveButton {
    //Create UIButton
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    
    [saveButton addTarget:self action:@selector(onSave) forControlEvents:UIControlEventTouchUpInside];
    
    //Create UIBarbuttonItem and add UIButton in it
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    
    //Add UIBarButtonItem to NavigationBar
    [self.navigationItem setRightBarButtonItem:saveBarButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setView];
    
    // Setup data
    [[EditProfileModel sharedInstance] setEducation:[NSDictionary dictionaryFromJSONString:[UserUtil userPersonalInformation].education]];
    [[EditProfileModel sharedInstance] setIntro:[UserUtil userPersonalInformation].introduction];
    [[EditProfileModel sharedInstance] setSkill:[UserUtil userPersonalInformation].skill];
    [[EditProfileModel sharedInstance] setCountry:[UserUtil userPersonalInformation].country];
    [[EditProfileModel sharedInstance] setCity:[UserUtil userPersonalInformation].city];
    //[[EditProfileModel sharedInstance] setLinks:[AppDelegateObj currentUser].]
}

- (void)onBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onSave {
    switch (currentSelected) {
        case 0: {
            [_editEducation onSave];
            break;
        }
            
        case 1: {
            [_editSkill onSave];
        }
            
        case 2: {
            [_editIntro onSave];
        }
            
        default: {
            break;
        }
    }
    
    [self uploadDataToServer];
}

- (void)uploadDataToServer {
    [UserUtil updateUserProfile:[[EditProfileModel sharedInstance].education jsonStringWithPrettyPrint:YES]
              proficiencyOfUser:@""
                userDateOfBirth:[UserUtil userPersonalInformation].dateOfBirth
             introductionOfUser:[[EditProfileModel sharedInstance] intro]
                       userType:[[UserUtil userPersonalInformation] userType]
                   skillsOfuser:[[EditProfileModel sharedInstance] skill]
                       userCity:@""     // Will add later
                    userCountry:@""     // Will add later
                       callback:^(bool success, id result) {
                           if (success) {
                               CADLog(@"Update info success fully");
                           } else {
                               NSError *error = (NSError *)result;
                               CADLog(@"%@", error);
                           }
    }];
}

- (void)setView {
    if (_tabBar == nil) {
        _tabBar = [[EditProfileTabBar alloc] initWithFrame:CGRectMake(0, 0,
                                                                      self.viewTabBarHolder.frame.size.width-40,
                                                                      self.viewTabBarHolder.frame.size.height-30)];
        [_tabBar setDelegate:self];
        [self.viewTabBarHolder addSubview:_tabBar];
        [_tabBar setCenter:self.viewTabBarHolder.center];
    }
    [_tabBar setSelectedIndex:self.currentSelected];
    
    if (transLayer == nil) {
        transLayer = [[UIView alloc] initWithFrame:self.viewTransLayer.bounds];
        [transLayer setBackgroundColor:[THEME_COLOR_DARK colorWithAlphaComponent:0.8]];
        [self.viewTransLayer addSubview:transLayer];
    }

    if (_editEducation == nil) {
        _editEducation = [[EditEducation alloc] initWithFrame:CGRectMake(0, 0,
                                                                         self.viewTransLayer.frame.size.width,
                                                                         self.viewTransLayer.frame.size.height)];
    }
    
    if (_editSkill == nil) {
        _editSkill = [[EditSkill alloc] initWithFrame:transLayer.bounds];
    }
    
    if (_editIntro == nil) {
        _editIntro = [[EditIntro alloc] initWithFrame:transLayer.bounds];
    }
    
    if (_editLocation == nil) {
        _editLocation = [[EditLocation alloc] initWithFrame:transLayer.bounds];
    }
    
    if (_editExp == nil) {
        _editExp = [[EditExperience alloc] initWithFrame:transLayer.bounds];
    }
    
    if (_editLink == nil) {
        _editLink = [[EditLink alloc] initWithFrame:transLayer.bounds];
    }
    
    [self profileTabBar:_tabBar onIndexSelected:self.currentSelected];
}

#pragma mark EditProfileTabBarDelegate
- (void)profileTabBar:(EditProfileTabBar *)bar onIndexSelected:(NSUInteger)index {
    switch (index) {
        case 0: {
            [transLayer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [transLayer addSubview:_editEducation];
            currentSelected = 0;
            break;
        }
            
        case 1: {
            [transLayer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [transLayer addSubview:_editSkill];
            currentSelected = 1;
            break;
        }
            
        case 2: {
            [transLayer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [transLayer addSubview:_editIntro];
            currentSelected = 2;
            break;
        }
            
        case 3: {
            [transLayer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [transLayer addSubview:_editLocation];
            currentSelected = 3;
            break;
        }
            
        case 4: {
            [transLayer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [transLayer addSubview:_editExp];
            currentSelected = 4;
            break;
        }
            
        case 5: {
            [transLayer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [transLayer addSubview:_editLink];
            currentSelected = 5;
            break;
        }
        default:
            break;
    }
}

@end
