//
//  MacleKitMessageAlertTest.m
//  MacleDemoUITests
//
//  Created by macle on 2021/9/29.
//

#import <XCTest/XCTest.h>
#import "MacleKitUITestUtils.h"
#import "XCTestCase+Macle.h"

@interface MacleKitShowToastTest : XCTestCase

@property(nonatomic, strong)XCUIApplication *app;

@end

@implementation MacleKitShowToastTest

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
    
    XCUIElement *toast = self.app.webViews.staticTexts[@"显示消息提示框"];
    [self waitForElementToAppear:toast shouldTap:YES];
    
    XCUIElement *closeBtn = self.app.webViews.staticTexts[@"关闭提示框"];
    
    [self waitForElementToAppear:closeBtn shouldTap:NO];
    
    XCUIElement *successBtn = self.app.webViews.staticTexts[@"成功"];
    [self waitForElementToAppear:successBtn shouldTap:YES];

    XCUIElement *successToast = self.app.staticTexts[@"success"];
    [self waitForElementToAppear:successToast shouldTap:NO];
    
    [closeBtn tap];

    XCUIElement *failBtn = self.app.webViews.staticTexts[@"失败"];
    [self waitForElementToAppear:failBtn shouldTap:YES];

    XCUIElement *failToast = self.app.staticTexts[@"失败"];
    [self waitForElementToAppear:failToast shouldTap:NO];

    [closeBtn tap];

    XCUIElement *waitBtn = self.app.webViews.staticTexts[@"等待"];
    [self waitForElementToAppear:waitBtn shouldTap:YES];

    XCUIElement *waitToast = self.app.staticTexts[@"等待"];
    [self waitForElementToAppear:waitToast shouldTap:NO];

    [closeBtn tap];
    
    XCUIElement *picBtn = self.app.webViews.staticTexts[@"图片"];
    [self waitForElementToAppear:picBtn shouldTap:YES];
    
    XCUIElement *picToast = self.app.staticTexts[@"图片"];
    [self waitForElementToAppear:picToast shouldTap:NO];
    
    [closeBtn tap];
    
    XCUIElement *otherBtn = self.app.webViews.staticTexts[@"其他"];
    [self waitForElementToAppear:otherBtn shouldTap:YES];
    
    XCUIElement *otherToast = self.app.staticTexts[@"无图标无图片，此时 title 文本最多可显示两行"];
    [self waitForElementToAppear:otherToast shouldTap:NO];
    
    [closeBtn tap];
    
    XCUIElement *maskBtn = self.app.webViews.staticTexts[@"显示蒙层"];
    [self waitForElementToAppear:maskBtn shouldTap:YES];
    
    XCUIElement *maskToast = self.app.staticTexts[@"页面不可点击"];
    [self waitForElementToAppear:maskToast shouldTap:NO];
    
    [closeBtn tap];
    
}

@end
