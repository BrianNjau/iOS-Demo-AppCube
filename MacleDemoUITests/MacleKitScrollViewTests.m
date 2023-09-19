//
//  MacleDemoUITests.m
//  MacleDemoUITests
//
//  Created by gl on 2021/8/31.
//

#import <XCTest/XCTest.h>
#import "MacleKitUITestUtils.h"


@interface MacleKitScrollViewTest : XCTestCase

@end

@implementation MacleKitScrollViewTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = YES;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


- (void)testExample {
    
    //获取webQuery
    XCUIElementQuery *webQuery = [MacleKitUITestUtils webQueryWithMiniAppName:@"MacleExamples"];

    //没有获取到web则失败
    XCTAssertNotNil(webQuery, @"can't find element");
    
    //点击【视图容器】【scroll-view】
    [webQuery.staticTexts[@"视图容器"] tap];
    [webQuery.staticTexts[@"scroll-view"] tap];
    
    //等待1秒后（确保webview渲染完成），检查元素
    XCUIElement *element = [MacleKitUITestUtils findStaticText:@"A" withQuery:webQuery afterDelay:1];
    XCTAssertNotNil(element, @"can't find element");//找不到元素进断言 测试失败

}


@end
