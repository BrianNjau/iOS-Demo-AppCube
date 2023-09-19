//
//  MAMinipInfoModel.m
//  MacleDemo
//
//  Created by Macle
//

#import "MAMinipInfoModel.h"


@implementation MAMinipSdkVersionModel

- (NSDictionary *)toDictionary {
    return @{
        @"version_name": self.version_name ?: [NSNull null],
        @"version_code": @(self.version_code) ?: [NSNull null]
    };
}

+ (instancetype)toInstance:(NSDictionary *)dict {
    if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return nil;
    }
    MAMinipSdkVersionModel *model = [[MAMinipSdkVersionModel alloc] init];
    model.version_name = [dict[@"version_name"] isKindOfClass:[NSNull class]] ? nil : dict[@"version_name"];
    model.version_code = [[dict[@"version_code"] isKindOfClass:[NSNull class]] ? nil : dict[@"version_code"] integerValue];
    return model;
}

@end

@implementation MAMinipPackageModel

- (NSDictionary *)toDictionary {
    return @{
        @"file_id": self.file_id ?: [NSNull null],
        @"url": self.url ?: [NSNull null],
        @"size": @(self.size) ?: [NSNull null],
        @"digest": self.digest ?: [NSNull null],
        @"sequence": @(self.sequence) ?: [NSNull null],
        @"file_type": @(self.file_type) ?: [NSNull null],
        @"root": self.root ?: [NSNull null]
    };
}

+ (instancetype)toInstance:(NSDictionary *)dict {
    if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return nil;
    }
    MAMinipPackageModel *model = [[MAMinipPackageModel alloc] init];
    model.file_id = [dict[@"file_id"] isKindOfClass:[NSNull class]] ? nil : dict[@"file_id"];
    model.url = [dict[@"url"] isKindOfClass:[NSNull class]] ? nil : dict[@"url"];
    model.size = [[dict[@"size"] isKindOfClass:[NSNull class]] ? nil : dict[@"size"] integerValue];
    model.digest = [dict[@"digest"] isKindOfClass:[NSNull class]] ? nil : dict[@"digest"];
    model.sequence = [[dict[@"sequence"] isKindOfClass:[NSNull class]] ? nil : dict[@"sequence"] integerValue];
    model.file_type = [[dict[@"file_type"] isKindOfClass:[NSNull class]] ? nil : dict[@"file_type"] integerValue];
    model.root = [dict[@"root"] isKindOfClass:[NSNull class]] ? nil : dict[@"root"];
    return model;
}

@end


@implementation MAMinipInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"packages" : [MAMinipPackageModel class],
             @"min_sdk_version": [MAMinipSdkVersionModel class]};
}

- (NSDictionary *)toDictionary {
    return @{
        @"app_id": self.app_id ?: [NSNull null],
        @"app_name": self.app_name ?: [NSNull null],
        @"app_slogan": self.app_slogan ?: [NSNull null],
        @"app_logo": self.app_logo ?: [NSNull null],
        @"app_desc": self.app_desc ?: [NSNull null],
        @"version": self.version ?: [NSNull null],
        @"instance_id": self.instance_id ?: [NSNull null],
        @"min_sdk_version": [self.min_sdk_version toDictionary] ?: [NSNull null],
        @"package": [self.package toDictionary] ?: [NSNull null],
        @"packages": [NSNull null],
        @"service_status": @(self.service_status) ?: [NSNull null]
    };
}

+ (instancetype)toInstance:(NSDictionary *)dict {
    if (dict == nil || [dict isKindOfClass:[NSNull class]]) {
        return nil;
    }
    MAMinipInfoModel *model = [[MAMinipInfoModel alloc] init];
    model.app_id = [dict[@"app_id"] isKindOfClass:[NSNull class]] ? nil : dict[@"app_id"];
    model.app_name = [dict[@"app_name"] isKindOfClass:[NSNull class]] ? nil : dict[@"app_name"];
    model.app_slogan = [dict[@"app_slogan"] isKindOfClass:[NSNull class]] ? nil : dict[@"app_slogan"];
    model.app_logo = [dict[@"app_logo"] isKindOfClass:[NSNull class]] ? nil : dict[@"app_logo"];
    model.app_desc = [dict[@"app_desc"] isKindOfClass:[NSNull class]] ? nil : dict[@"app_desc"];
    model.version = [dict[@"version"] isKindOfClass:[NSNull class]] ? nil : dict[@"version"];
    model.instance_id = [dict[@"instance_id"] isKindOfClass:[NSNull class]] ? nil : dict[@"instance_id"];
    model.min_sdk_version = [MAMinipSdkVersionModel toInstance:dict[@"min_sdk_version"]];
    model.package = [MAMinipPackageModel toInstance:dict[@"package"]];
    model.packages = nil;
    model.service_status = [[dict[@"service_status"] isKindOfClass:[NSNull class]] ? nil : dict[@"service_status"] integerValue];
    return model;
}

@end
