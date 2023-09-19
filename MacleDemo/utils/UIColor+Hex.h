//
//  UIColor+Hex.h
//  MacleDemo
//
//  Created by Macle
//

#import <UIKit/UIKit.h>

/**
 Here is the common utls class, in this class we provide the Color functions.
 */
@interface UIColor (Hex) 

+ (UIColor*)colorWithCSS: (NSString*) css;
+ (UIColor*)colorWithHex: (NSUInteger) hex;

- (uint)hex;
- (NSString*)hexString;
- (NSString*)cssString;

@end
