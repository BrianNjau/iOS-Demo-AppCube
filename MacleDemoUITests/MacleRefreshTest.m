//
//  MacleRefreshTest.m
//  MacleDemoUITests
//
//  Created by gl on 2022/1/18.
//

#import <XCTest/XCTest.h>
#import "MacleKitUITestUtils.h"
#import "XCTestCase+Macle.h"


@interface MacleKitRefreshTest : XCTestCase
@property(nonatomic, strong)XCUIApplication *app;
@end

@implementation MacleKitRefreshTest

- (void)setUp {
    self.continueAfterFailure = NO;
    self.app = [self getAppInstanceWithMiniAppName:@"MacleExamples"];
}

- (void)tearDown {
    [self.app terminate];
}

- (void)testMessageAlertTest {
    
    XCUIElement *instance = self.app.tabBars.buttons[@"接口"];
    [self waitForElementToAppear:instance shouldTap:YES];
    
    XCUIElement *ui = self.app.webViews.staticTexts[@"UI"];
    [self waitForElementToAppear:ui shouldTap:YES];
    
    NSArray<XCUIElement *> *webs = self.app.webViews.allElementsBoundByIndex;
    XCUIElement *currentWeb;
    for (XCUIElement *web in webs) {
        XCUIElement *sourceBtn = web.staticTexts[@"UI"];
        if (sourceBtn.exists) {
            currentWeb = web;
            break;
        }
    }

    XCUIElement *refreshBtn = currentWeb.staticTexts[@"下拉刷新"];
    [self waitForElementToAppear:refreshBtn shouldTap:YES];
    
    webs = self.app.webViews.allElementsBoundByIndex;
    for (XCUIElement *web in webs) {
        XCUIElement *title = web.staticTexts[@"pullDownRefresh"];
        if (title.exists) {
            currentWeb = web;
            break;
        }
    }
    
    XCUIElement *startBtn = currentWeb.staticTexts[@"下拉刷新"];
    [self waitForElementToAppear:startBtn shouldTap:YES];
    
    XCUIElement *refreshImage = [[currentWeb.otherElements containingType:XCUIElementTypeImage identifier:@"macle_refresh"] childrenMatchingType:XCUIElementTypeOther].element;
    [self waitForElementToAppear:refreshImage shouldTap:NO];
    
    XCUIElement *endBtn = currentWeb.staticTexts[@"停止下拉刷新"];
    [self waitForElementToAppear:endBtn shouldTap:YES];
    
}

@end
