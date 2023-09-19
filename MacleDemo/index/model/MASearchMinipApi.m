//
//  MASearchMinipApi.m
//  MacleDemo
//
//  Created by Macle
//

#import "MASearchMinipApi.h"
#import <YYModel/YYModel.h>


@interface MASearchMinipApi ()

@property(nonatomic, copy)NSString *appName;
@property(nonatomic, assign)NSInteger pageNumber;
@property(nonatomic, assign)NSInteger pageSize;

@end


@implementation MASearchMinipApi;

- (instancetype)init {
    if (self = [super init]) {
        self.pageSize = 10;
        self.pageNumber = 0;
    }
    return self;
}

@end

@implementation MAMinipsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"app_infos" : [MAMinipInfoModel class]};
}

@end
