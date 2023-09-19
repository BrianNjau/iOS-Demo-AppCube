//
//  FecMAMinipInfoModel.m
//  MacleDemo
//
//  Created by Macle
//

#import "FecMAMinipInfoModel.h"

@implementation FecMAMinipPackageModel

@end

@implementation FecMAMinipInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"packageInfo" : [FecMAMinipPackageModel class]};
}

- (MAMinipInfoModel *) transToMAMinipInfoModel {
    MAMinipPackageModel *package = [[MAMinipPackageModel alloc] init];
    FecMAMinipPackageModel *fecPackage = self.packageInfo;
    package.file_id = fecPackage.mappFileId;
    package.url = fecPackage.filePath;  ///
    package.size = fecPackage.fileSize;
    package.digest = fecPackage.digest;
    package.file_type = fecPackage.fileType;
    package.root = fecPackage.root;

    MAMinipInfoModel *appInfo = [[MAMinipInfoModel alloc] init];
    appInfo.app_id = self.mappId;
    appInfo.app_name = self.mappName;
    appInfo.app_slogan = self.mappSlogan;
    appInfo.app_logo = self.mappLogo;
    appInfo.app_desc = self.mappDesc;
    appInfo.version = self.version;
    appInfo.instance_id = fecPackage.mappVersionId;
    appInfo.service_status = self.suspendService;
    appInfo.package = package;
    
    return appInfo;
}

@end
