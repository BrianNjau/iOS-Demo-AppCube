//
//  MARunningCell.m
//  MacleDemo
//
//  Created by Macle
//

#import "MARunningCell.h"
#import "UIColor+Hex.h"
#import <MacleKit/MacleClient.h>
#import <Masonry/Masonry.h>
#import "UILabel+Copy.h"


@interface MARunningCell ()

@property(nonatomic, strong) UILabel *name;
@property(nonatomic, strong) UIButton *killBtn;
@property(nonatomic, strong) UIButton *removeBtn;
@property(nonatomic, strong) UIView *line;

@end

@implementation MARunningCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.removeBtn];
    [self.removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(24);
    }];
    
    [self.contentView addSubview:self.killBtn];
    [self.killBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.removeBtn.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(40);
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

- (void)setAppInfo:(MacleAppSnapshot *)appInfo {
    _appInfo = appInfo;
    self.name.text = _appInfo.appId;
}

- (UIButton *)killBtn {
    if (!_killBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithHex:0xf1f1f1];
        btn.layer.cornerRadius = 12;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [btn setTitle:@"kill" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(kill:) forControlEvents:UIControlEventTouchUpInside];
        _killBtn = btn;
    }
    return _killBtn;
}

- (void)kill:(UIButton *)sender {
    [MacleClient stopApplet:self.appInfo.appId needClearData:NO];
    if (self.didKillAppBlock) {
        self.didKillAppBlock();
    }
}

- (UIButton *)removeBtn {
    if (!_removeBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithHex:0xf1f1f1];
        btn.layer.cornerRadius = 12;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [btn setTitle:@"rm" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
        _removeBtn = btn;
    }
    return _removeBtn;
}

- (void)remove:(UIButton *)sender {
    [MacleClient removeApplet:self.appInfo.appId];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *historyApps = [userDefaults objectForKey:@"historyApps"] ?: @{};
    NSMutableDictionary *mutableHistoryApps = [NSMutableDictionary dictionaryWithDictionary:historyApps];
    [mutableHistoryApps removeObjectForKey:self.appInfo.appId];
    [userDefaults setValue:mutableHistoryApps forKey:@"historyApps"];
    if (self.didRemoveAppBlock) {
        self.didRemoveAppBlock();
    }
}

- (UILabel *)name {
    if (!_name) {
        UILabel *name = [[UILabel alloc] init];
        name.textColor = [UIColor blackColor];
        name.font = [UIFont systemFontOfSize:16];
        name.numberOfLines = 1;
        name.lineBreakMode = NSLineBreakByTruncatingTail;
        name.isCopyable = YES;
        _name = name;
    }
    return _name;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:0xc1c1c1];
    }
    return _line;
}

@end
