//
//  MARunningVC.m
//  MacleDemo
//
//  Created by Macle
//

#import "MARunningVC.h"
#import <MacleKit/MacleClient.h>
#import <LYEmptyView/LYEmptyViewHeader.h>
#import "MARunningDataSource.h"
#import <Masonry/Masonry.h>
#import "CustomTextView.h"


@interface MARunningVC ()

@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) MARunningDataSource *dataSource;
@property(nonatomic, strong) UIButton *removeAppListBtn;
@property(nonatomic, strong) UIButton *removeAllAppsBtn;
@property(nonatomic, strong) UIButton *stopAppListBtn;
@property(nonatomic, strong) UIButton *stopAllAppsBtn;
@property(nonatomic, strong) UISwitch *clearDataSwitch;
@property(nonatomic, strong) CustomTextView *appIdsView;

@end

@implementation MARunningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupData {
    NSArray *apps = [MacleClient getRunningApplets];
    self.dataSource.apps = apps;
    [self.table reloadData];
}

- (void)setupUI {
    self.navigationItem.title = @"running mini app";
    
    // Add a button to clear the specified applet
    [self.view addSubview:self.removeAppListBtn];
    [self.removeAppListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(self.mas_topLayoutGuide).offset(15);
    }];
    
    // Add button to clear all applets
    [self.view addSubview:self.removeAllAppsBtn];
    [self.removeAllAppsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.removeAppListBtn.mas_top);
    }];
    
    // Add a button to stop the specified applet
    [self.view addSubview:self.stopAppListBtn];
    [self.stopAppListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(self.removeAppListBtn.mas_bottom);
    }];
    
    // Add button to stop all applets
    [self.view addSubview:self.stopAllAppsBtn];
    [self.stopAllAppsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.removeAllAppsBtn.mas_bottom);
    }];
    
    // Add the switch of whether to clear the stored data of the applet
    [self.view addSubview:self.clearDataSwitch];
    [self.clearDataSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(self.stopAppListBtn.mas_bottom).offset(5);
    }];
    
    // Add the text field of the app that needs to be stopped
    [self.view addSubview:self.appIdsView];
    [self.appIdsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.clearDataSwitch.mas_bottom).offset(5);
        make.height.mas_equalTo(100);
    }];
    
    // add search list
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.appIdsView.mas_bottom).offset(15);
        make.left.right.mas_offset(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
}

#pragma - mark lazy load

- (UITableView *)table {
    if (!_table) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.backgroundColor = [UIColor whiteColor];
        table.delegate = self.dataSource;
        table.dataSource = self.dataSource;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.separatorInset = UIEdgeInsetsMake(0, 90, 0, 0);
        table.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@""
                                                       titleStr:@"no running mini app"
                                                      detailStr:@""];
        _table = table;
    }
    return _table;
}

- (MARunningDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[MARunningDataSource alloc] init];
        @weakify(self);
        [_dataSource setDidKillAppBlock:^{
            @strongify(self);
            [self setupData];
        }];
        [_dataSource setDidRemoveAppBlock:^{
            @strongify(self);
            [self setupData];
        }];
    }
    return _dataSource;
}

- (UIButton *)removeAppListBtn {
    if (!_removeAppListBtn) {
        _removeAppListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeAppListBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_removeAppListBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_removeAppListBtn setTitle:@"Clear specified applet" forState:UIControlStateNormal];
        [_removeAppListBtn addTarget:self action:@selector(removeAppsInList) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeAppListBtn;
}

- (UIButton *)removeAllAppsBtn {
    if (!_removeAllAppsBtn) {
        _removeAllAppsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeAllAppsBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_removeAllAppsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_removeAllAppsBtn setTitle:@"Clear all applet" forState:UIControlStateNormal];
        [_removeAllAppsBtn addTarget:self action:@selector(removeAllApps) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeAllAppsBtn;
}

- (UIButton *)stopAppListBtn {
    if (!_stopAppListBtn) {
        _stopAppListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stopAppListBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_stopAppListBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_stopAppListBtn setTitle:@"stop specified applet" forState:UIControlStateNormal];
        [_stopAppListBtn addTarget:self action:@selector(stopAppsInList) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopAppListBtn;
}

- (UIButton *)stopAllAppsBtn {
    if (!_stopAllAppsBtn) {
        _stopAllAppsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stopAllAppsBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_stopAllAppsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_stopAllAppsBtn setTitle:@"stop all applet" forState:UIControlStateNormal];
        [_stopAllAppsBtn addTarget:self action:@selector(stopAllApps) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopAllAppsBtn;
}

- (UISwitch *)clearDataSwitch {
    if (!_clearDataSwitch) {
        _clearDataSwitch = [[UISwitch alloc] init];
    }
    return _clearDataSwitch;
}

- (UITextView *)appIdsView {
    if (!_appIdsView) {
        _appIdsView = [[CustomTextView alloc] init];
        _appIdsView.textColor = [UIColor whiteColor];
        _appIdsView.font = [UIFont systemFontOfSize:15];
        _appIdsView.backgroundColor = [UIColor lightGrayColor];
    }
    return _appIdsView;
}

- (void)removeAppsInList {
    NSArray *appIdList = [self.appIdsView.text componentsSeparatedByString:@"\n"];
    for (NSString *appId in appIdList) {
        [MacleClient removeApplet:appId];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *historyApps = [userDefaults objectForKey:@"historyApps"] ?: @{};
    NSMutableDictionary *mutableHistoryApps = [NSMutableDictionary dictionaryWithDictionary:historyApps];
    [mutableHistoryApps removeObjectsForKeys:appIdList];
    [userDefaults setValue:mutableHistoryApps forKey:@"historyApps"];
    [self setupData];
}

- (void)removeAllApps {
    [MacleClient removeAllApplets];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"historyApps"];
    [self setupData];
}

- (void)stopAppsInList {
    NSArray *appIdList = [self.appIdsView.text componentsSeparatedByString:@"\n"];
    for (NSString *appId in appIdList) {
        [MacleClient stopApplet:appId needClearData:self.clearDataSwitch.on];
    }
    
    [self setupData];
}

- (void)stopAllApps {
    [MacleClient stopAllApplets:self.clearDataSwitch.on];
    [self setupData];
}

@end
