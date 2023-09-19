//
//  MAIndexCell.m
//  MacleDemo
//
//  Created by Macle
//

#import "MAIndexCell.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
#import <SSZipArchive/SSZipArchive.h>
#import "MAMinipInfoModel.h"
#import <SDWebImage/SDWebImage.h>
#import <MacleKit/MacleKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "MAEventReporManager.h"
#import "MAMinipLauncher.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>


@interface MAIndexCell ()

@property(nonatomic, strong) UIImageView *icon;
@property(nonatomic, strong) UILabel *name;
@property(nonatomic, strong) UILabel *detail;
@property(nonatomic, strong) UIButton *download;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) MAMinipLauncher *launcher;

@end

@implementation MAIndexCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    //icon
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(66);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(15);
    }];
    //app name
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.icon.mas_top).offset(5);
        make.left.mas_equalTo(self.icon.mas_right).offset(15);
    }];
    //detail
    [self.contentView addSubview:self.detail];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.name.mas_left);
        make.bottom.mas_equalTo(self.icon.mas_bottom).offset(-5);
    }];
    //download
    [self.contentView addSubview:self.download];
    [self.download mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(24);
    }];
    //line
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(1/[UIScreen mainScreen].scale));
        make.left.mas_equalTo(self.name.mas_left);
        make.bottom.right.mas_equalTo(0);
    }];
}

- (void)setInfo:(MAMinipInfoModel *)info {
    _info = info;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_info.app_logo] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    self.name.text = _info.app_name;
    self.detail.text = _info.app_desc;
    [self launcher];
}

#pragma mark - download mini app package
- (void)downloadPackage:(id)sender {
    if (!self.info.package) {
        NSLog(@"there is no app pakcage to download");
        return;
    }

    if (self.info.service_status != 0) {
        NSDictionary *reasons = @{
            @"1": @"system updating",
            @"2": @"system error",
            @"3": @"other reason"
        };
        NSString *key = [NSString stringWithFormat:@"%ld",self.info.service_status];
        [[UIApplication sharedApplication].keyWindow makeToast:reasons[key]];
        return;
    }
    
    // [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    NSMutableDictionary *clickEvent = [NSMutableDictionary new];
    clickEvent[@"appName"] = self.info.app_name;
    clickEvent[@"appVersion"] = self.info.version;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970] * 1000;
    NSInteger intTime = round(time);
    clickEvent[@"timestamp"] = [NSNumber numberWithLong:intTime];
    [[MAEventReporManager sharedInstance] reportEvent:self.info.app_id eventName:@"clickMiniApp" eventParam:clickEvent];
    
    MAMinipPackageModel *package = self.info.package;
    NSString *appUrl = package.url;
    [self.launcher startAppWithUrl:appUrl isTrial:NO trialSign:nil];
}

#pragma mark - lazy load
- (UIImageView *)icon {
    if (!_icon) {
        UIImageView *icon = [[UIImageView alloc] init];
        icon.backgroundColor = [UIColor clearColor];
        icon.layer.cornerRadius = 13;
        icon.layer.masksToBounds = YES;
        _icon = icon;
    }
    return _icon;
}

- (UILabel *)name {
    if (!_name) {
        UILabel *name = [[UILabel alloc] init];
        name.textColor = [UIColor blackColor];
        name.font = [UIFont systemFontOfSize:16];
        name.numberOfLines = 1;
        name.lineBreakMode = NSLineBreakByTruncatingTail;
        _name = name;
    }
    return _name;
}

- (UILabel *)detail {
    if (!_detail) {
        UILabel *detail = [[UILabel alloc] init];
        detail.textColor = [UIColor colorWithHex:0xd1d1d1];
        detail.font = [UIFont systemFontOfSize:13];
        detail.numberOfLines = 1;
        detail.lineBreakMode = NSLineBreakByTruncatingTail;
        _detail = detail;
    }
    return _detail;
}

- (UIButton *)download {
    if (!_download) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithHex:0xf1f1f1];
        btn.layer.cornerRadius = 12;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [btn setTitle:@"open" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(downloadPackage:) forControlEvents:UIControlEventTouchUpInside];
        _download = btn;
    }
    return _download;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:0xc1c1c1];
    }
    return _line;
}

- (MAMinipLauncher *)launcher {
    if (!_launcher) {
        _launcher = [MAMinipLauncher defaultLauncher];
    }
    _launcher.info = _info;
    return _launcher;
}

@end
