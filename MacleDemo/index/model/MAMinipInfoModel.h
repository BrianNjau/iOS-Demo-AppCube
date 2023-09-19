//
//  MAMinipInfoModel.h
//  MacleDemo
//
//  Created by Macle
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
   Here is a model definition class, here we provide the definition of MAMinipSdkVersionModel, MAMinipPackageModel, MAMinipInfoModel and some method
 */
@interface MAMinipSdkVersionModel : NSObject

@property(nonatomic, copy) NSString *version_name;
@property(nonatomic, assign) NSInteger version_code;

- (NSDictionary *)toDictionary;

+ (instancetype)toInstance:(NSDictionary *)dict;

@end


@interface MAMinipPackageModel : NSObject

@property(nonatomic, copy) NSString *file_id;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, assign) NSInteger size;
@property(nonatomic, copy) NSString *digest;
@property(nonatomic, assign) NSInteger sequence;
@property(nonatomic, assign) NSInteger file_type;
@property(nonatomic, copy) NSString *root;

- (NSDictionary *)toDictionary;

+ (instancetype)toInstance:(NSDictionary *)dict;

@end


@interface MAMinipInfoModel : NSObject

@property(nonatomic, copy) NSString *app_id;
@property(nonatomic, copy) NSString *app_name;
@property(nonatomic, copy) NSString *app_slogan;
@property(nonatomic, copy) NSString *app_logo;
@property(nonatomic, copy) NSString *app_desc;
@property(nonatomic, copy) NSString *version;
@property(nonatomic, copy) NSString *instance_id;
@property(nonatomic, strong) MAMinipSdkVersionModel *min_sdk_version;
@property(nonatomic, strong) MAMinipPackageModel *package;
@property(nonatomic, strong) NSArray<MAMinipPackageModel *>  *_Nullable packages;
@property(nonatomic, assign) NSInteger service_status;

- (NSDictionary *)toDictionary;

+ (instancetype)toInstance:(NSDictionary *)dict;

@end


NS_ASSUME_NONNULL_END
