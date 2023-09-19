//
//  FecMAMinipInfoModel.h
//  MacleDemo
//
//  Created by Macle
//

#import <Foundation/Foundation.h>
#import "MAMinipInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
   Here is a model definition class, here we provide the definition of FecMAMinipPackageModel and FecMAMinipInfoModel
 */
@interface FecMAMinipPackageModel : NSObject

@property(nonatomic, copy) NSString *mappFileId;  ///string 32 required file ID
@property(nonatomic, copy) NSString *tenantId;  ///string 32 required tenant Id
@property(nonatomic, copy) NSString *mappVersionId;  ///string 32 required mini app versoion ID
@property(nonatomic, copy) NSString *fileName;  ///string required file name
@property(nonatomic, assign) NSInteger fileType;  ///int optional file type
@property(nonatomic, copy) NSString *filePath;  ///string optional file url address
@property(nonatomic, assign) NSInteger fileSize;  ///int optional file size，byte
@property(nonatomic, copy) NSString *digest;  ///string optional file digest
@property(nonatomic, copy) NSString *root;  ///string optional sub package root directory
@property(nonatomic, copy) NSString *createTime;  ///string creation time

@end


@interface FecMAMinipInfoModel : NSObject

@property(nonatomic, copy) NSString *mappId;
@property(nonatomic, copy) NSString *mappName;
@property(nonatomic, copy) NSString *mappSlogan;
@property(nonatomic, copy) NSString *mappLogo;
@property(nonatomic, copy) NSString *mappDesc;
@property(nonatomic, copy) NSString *version;
@property(nonatomic, assign) NSInteger releaseStatus;
@property(nonatomic, copy) NSString *ownerAccountId;
@property(nonatomic, copy) NSString *tenantId;
@property(nonatomic, copy) NSString *serviceRegionType;
@property(nonatomic, copy) NSString *createTime;
@property(nonatomic, copy) NSString *statusTime;
@property(nonatomic, copy) NSString *modifyTime;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, assign) NSInteger suspendService;
@property(nonatomic, strong) FecMAMinipPackageModel *packageInfo;

- (MAMinipInfoModel *) transToMAMinipInfoModel;

@end


NS_ASSUME_NONNULL_END
