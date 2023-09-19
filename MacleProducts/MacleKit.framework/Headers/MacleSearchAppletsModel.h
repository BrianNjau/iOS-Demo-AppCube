//
//  MacleSearchAppletsData.h
//  MacleKit
//
//  Created by Macle on 2023/3/14.
//

#import <Foundation/Foundation.h>
#import "MacleAppInfo.h"

NS_ASSUME_NONNULL_BEGIN

/**
 搜索小程序的请求体数据模型
 */
@interface MacleSearchAppletsRequest : NSObject

@property (nonatomic, copy) NSString * _Nonnull searchKey;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;

@end


/**
 搜索小程序的响应体分页数据模型
 */
@interface Pagination : NSObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger entryCount;

- (instancetype)initWithDictionary:(NSDictionary *)pagination;

- (instancetype)initWithPagination:(Pagination *)pagination;

@end


/**
 搜索小程序的响应体数据模型（返回给宿主的）
 */
@interface MacleSearchAppletsResponse : NSObject

@property (nonatomic, strong) NSArray<MacleAppInfo *> * _Nullable entries;
@property (nonatomic, strong) Pagination * _Nullable pagination;

@end

NS_ASSUME_NONNULL_END
