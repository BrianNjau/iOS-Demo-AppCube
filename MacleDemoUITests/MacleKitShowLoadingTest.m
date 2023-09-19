//
//  MacleKitLoadingAlertTest.m
//  MacleDemoUITests
//
//  Created by macle on 2021/9/29.
//

#import <XCTest/XCTest.h>
#import "MacleKitUITestUtils.h"
#import "XCTestCase+Macle.h"

@interface MacleKitShowAndHideLoadingTest : XCTestCase

@property(nonatomic, strong)XCUIApplication *app;

@end

@implementation MacleKitShowAndHideLoadingTest

- (void)setUp {
    self.continueAfterFailure = NO;
    self.app = [self getAppInstanceWithMiniAppName:@"MacleExamples_v13"];
}

- (void)tearDown {
    [self.app terminate];
}

- (void)testLoadingAlert {
    if ([[[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode] isEqual:@"en"]) {
        XCUIElement *instance = self.app.tabBars.buttons[@"API"];
        [self waitForElementToAppear:instance shouldTap:YES];
    }else {
        XCUIElement *instance = self.app.tabBars.buttons[@"接口"];
        [self waitForElementToAppear:instance shouldTap:YES];
    }

    XCUIElement *UI = self.app.webViews.staticTexts[@"UI"];
    [self waitForElementToAppear:UI shouldTap:YES];
    
    XCUIElement *subBtn = self.app.webViews.staticTexts[@"显示Loading提示框"];
    [self waitForElementToAppear:subBtn shouldTap:YES];
    
    XCUIElement *waitBtn = self.app.webViews.staticTexts[@"显示loading提示框"];
    [self waitForElementToAppear:waitBtn shouldTap:YES];
    
    XCUIElement *loading = [self.app.staticTexts elementMatchingType:XCUIElementTypeAny identifier:@"macle loading"];
    [self waitForElementToAppear:loading shouldTap:NO];
    
    sleep(5);
    
    XCTAssertTrue(loading.exists == NO, @"hide success");
}

@end
