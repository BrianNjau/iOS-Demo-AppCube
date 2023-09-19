//
//  MacleAuthorityScope.h
//  MacleKit
//
//  Created by FrontEnd on 2022/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    PERMISSION = 0,
    PRIVACY    = 1,
} MacleAuthorityType;

typedef enum : NSUInteger {
    DENY    = -1,
    DEFAULT = 0,
    ALLOW   = 1,
} MacleAuthorityState;

@interface MacleAuthorityScope : NSObject

@property (nonatomic, copy)NSString* authId;

@property (nonatomic, copy)NSString* authName;

@property (nonatomic, assign)MacleAuthorityType authType;

@property (nonatomic, copy)NSString* authDesc;

- (instancetype)initAuthWithId:(NSString *)authId name:(NSString *)name type:(MacleAuthorityType)type description:(NSString *)desc;

- (NSString *)authName;

- (NSString *)authDesc;

@end

NS_ASSUME_NONNULL_END
