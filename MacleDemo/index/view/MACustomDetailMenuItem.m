//
//  MaCleDemoAppDetail.m
//  MacleDemo
//
//  Created by Macle
//

#import "MACustomDetailMenuItem.h"
#import <UIKit/UIImage.h>
#import <UIKit/UIViewController.h>
#import <UIKit/UICollectionViewCell.h>
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>

@implementation MACustomDetailMenuItem
- (void)macleMenuItem:(id<MacleMenuItemProtocol>)menu didClickWithAppInfo:(MacleAppInfo *)appInfo presentAction:(void (^)(UIViewController * _Nonnull))present {
    /// Handle click custom menuItem button event
    if (present) {
        /// RatingViewController is a UiViewController whitch contains some applet information through appInfo.
        RatingViewController *vc = [[RatingViewController alloc] initWithAppInfo:appInfo];
        present(vc);
    }
}

- (nonnull UIImage *)macleMenuItemIcon {
    /// add custom menuItem icon image here
    return [UIImage imageNamed:@"desktop"];
}

- (nonnull NSString *)macleMenuItemTitle {
    /// add custom menuItem title string here
    return @"detail";
}
@end

@implementation RatingViewController

- (instancetype)initWithAppInfo:(MacleAppInfo *)appInfo {
    if (self = [super init]) {
        self.appInfo = appInfo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.label2];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(10);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
    }];
    
}

-(UILabel *)label2 {
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.numberOfLines = 100;

        _label2.text = [NSString stringWithFormat:@"appInfo = %@", [self.appInfo yy_modelToJSONObject]];
    }
    return _label2;
}

@end
