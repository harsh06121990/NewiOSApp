//
//  UserHelperTest.m
//  ios-app
//
//  Created by Deepak on 06/02/15.
//  Copyright (c) 2015 Connekt Team. All rights reserved.
//

#import "Specta.h"
#import "UserHelper.h"
#import "PortfolioHelper.h"
#import "SearchHelper.h"
#import "EventHelper.h"
#import "AdHelper.h"

SpecBegin(HelperSpec)

int i = arc4random();

// Test cases for User helper function
describe(@"UserHelper", ^{
    context(@"UserHelper", ^{
        // Variable which will store the userid of the user under tests
        __block NSString *userid;
        
        it(@"singleton Instance should not be null", ^{
            XCTAssertNotNil([UserHelper getInstance]);
        });
        
        it(@"should signup a user", ^{
            waitUntil(^(DoneCallback done) {
                [[UserHelper getInstance] signUp:[@"temp" stringByAppendingFormat:@"%d", i] passwordOfUser:@"password" emailOfuser:[@"temp" stringByAppendingFormat:@"%d@gmail.com", i] userDateOfBirth:[NSDate date] introductionOfUser:@"introduction" userType:@"ENGINEER" skillsOfuser:@"skill" callback:^(bool success, NSDictionary *result) {
                    XCTAssertTrue(success);
                    // Async example blocks need to invoke done() callback.
                    done();
                }];
            });
        });
        
        it(@"should login a user", ^{
            waitUntil(^(DoneCallback done) {
                [[UserHelper getInstance] login:[@"temp" stringByAppendingFormat:@"%d", i] password:@"password" callback:^(bool success, NSDictionary *result) {
                    XCTAssertTrue(success);
                    XCTAssertNotNil([result objectForKey:@"user_id"]);
                    XCTAssertNotNil([result objectForKey:@"auth_token"]);
                    userid = [result objectForKeyedSubscript:@"user_id"];
                    done();
                }];
            });
        });
        
        it(@"user should be logged in", ^{
            XCTAssertTrue([[UserHelper getInstance] checkIfUserIsLoggedIn]);
        });
        
        it(@"should update profile of the user", ^{
            waitUntil(^(DoneCallback done) {
                [[UserHelper getInstance] updateUserProfile:@"education" proficiencyOfUser:@"proficiency" userDateOfBirth:[NSDate date] introductionOfUser:@"introduction" userType:@"DESIGNER" skillsOfuser:@"skill" userCity:@"Delhi" userCountry:@"India" callback:^(bool success, NSDictionary *result) {
                    XCTAssertTrue(success);
                    done();
                }];
            });
        });
        
        it(@"Should get the information of the user", ^{
            waitUntil(^(DoneCallback done) {
                [[UserHelper getInstance] getUsersDetail:@[userid] callback:^(bool success, id result) {
                    XCTAssertTrue(success);
                    done();
                }];
            });
        });
        
    });
});

// Ad helper
describe(@"AdHelper", ^{
    it(@"should get Ads from the server", ^{
        waitUntil(^(DoneCallback done) {
            [[AdHelper getInstance] getAdsFromServer:[NSNumber numberWithInt:0] callbackHandler:^(bool success, id result) {
                done();
            }];
        });
    });
});


// Test cases for Portfolio helper function
describe(@"portfolioHelper", ^{
    
    it(@"should sync with the server", ^{
        waitUntil(^(DoneCallback done) {
            [[PortfolioHelper getInstance] syncWithTheServer:^(bool success, id result) {
                XCTAssertTrue(success);
                done();
            }];
        });
    });
    
    it(@"should add a portfolio", ^{
        waitUntil(^(DoneCallback done) {
            NSString *filePath = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"Icon.png"];
            __block NSData *imageData = [NSData dataWithContentsOfFile:filePath];
            XCTAssertNotNil(imageData);
            [[PortfolioHelper getInstance] addPortfolio:@"connekt logo" imageOfThePortfolio:imageData callback:^(bool success, id result) {
                XCTAssertTrue(success);
                done();
            }];
        });
    });
    
    it(@"should sync with the server", ^{
        waitUntil(^(DoneCallback done) {
            [[PortfolioHelper getInstance] syncWithTheServer:^(bool success, id result) {
                XCTAssertTrue(success);
                done();
            }];
        });
    });
    
});

// Test cases for Search helper function
describe(@"searchHelper", ^{
    it(@"should search for the user", ^{
        waitUntil(^(DoneCallback done) {
            [[SearchHelper getInstance] searchUsers:@"all" searchQuery:nil searchInsideEduction:false searchInsideUsername:false searchInsideProficieny:false searchInsideSkill:false searchInsidePortfolio:false filterByCity:nil filterByCountry:nil filterByAgeLessThan:nil filterByAgeGreaterThan:nil callback:^(bool success, id result) {
                XCTAssertTrue(success);
                done();
            }];
        });
    });
});

//Test cases for the event
__block NSNumber *eventId = nil;
describe(@"EventHelper", ^{
    it(@"should get the list of events", ^{
        waitUntil(^(DoneCallback done) {
            [[EventHelper getInstance] getEventsFromServer:[NSNumber numberWithInteger:0] callbackHandler:^(bool success, id result) {
                XCTAssertGreaterThanOrEqual([result count], 1);
                XCTAssertTrue(success);
                //Retriving event id for the first event
                int i = [[[result objectAtIndex:0] objectForKey:@"id"] integerValue];
                eventId = [NSNumber numberWithInteger:[[[result objectAtIndex:0] objectForKey:@"id"] integerValue]];
                done();
            }];
        });
    });
    
    /*
        Bookmark API's test
     */
    it(@"should bookmark an event", ^{
        waitUntil(^(DoneCallback done) {
           [[EventHelper getInstance] bookmarkAnEvent:eventId callbackHandler:^(bool success, id result) {
               XCTAssertTrue(success);
               done();
           }];
        });
    });
    
    it(@"should get bookmarks equal to 1", ^{
        XCTAssertEqual([[[EventHelper getInstance] getBookmarkedEvents] count], 1);
    });
    
    it(@"should delete an event", ^{
        waitUntil(^(DoneCallback done) {
            [[EventHelper getInstance] deleteBookmarkedEvent:eventId callbackHandler:^(bool success, id result) {
                XCTAssertTrue(success);
                done();
            }];
        });
    });
    
    it(@"should get bookmarks equal to 0", ^{
        XCTAssertEqual([[[EventHelper getInstance] getBookmarkedEvents] count], 0);
    });
    
    /*
        Attending API's test
     */
    
    it(@"should attend an event", ^{
        waitUntil(^(DoneCallback done) {
            [[EventHelper getInstance] attendAnEvent:eventId callbackHandler:^(bool success, id result) {
                XCTAssertTrue(success);
                done();
            }];
        });
    });
    
    it(@"should get attending events equal to 1", ^{
        XCTAssertEqual([[[EventHelper getInstance] getAttendingEvents] count], 1);
    });
    
    it(@"should delete an attending event", ^{
        waitUntil(^(DoneCallback done) {
            [[EventHelper getInstance] deleteAttendingEvent:eventId callbackHandler:^(bool success, id result) {
                XCTAssertTrue(success);
                done();
            }];
        });
    });
    
    it(@"should get attending events equal to 0", ^{
        XCTAssertEqual([[[EventHelper getInstance] getAttendingEvents] count], 0);
    });

});

// Should logout a user
describe(@"UserHelper", ^{
    it(@"should logout a user", ^{
        [[UserHelper getInstance] logout];
    });
});


SpecEnd