//
//  MAIndexVC.m
//  MacleDemo
//
//  Created by Macle
//

#import "MAIndexVC.h"
#import <Masonry/Masonry.h>
#import "ViewController+MASAdditions.h"
#import "MAIndexDataSource.h"
#import <LYEmptyView/LYEmptyViewHeader.h>
#import <MJRefresh/MJRefresh.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/Toast.h>
#import "MADevLoginApi.h"
#import "MAGetTrialApi.h"
#import <MacleKit/MacleClient.h>
#import "MAMinipLauncher.h"
#import "MAEventReporManager.h"
#import <ScanKitFrameWork/ScanKitFrameWork.h>

@interface MAIndexVC () <UISearchBarDelegate, DefaultScanDelegate>

@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) MAIndexDataSource *dataSource;
@property(nonatomic, strong) MJRefreshAutoNormalFooter *footer;
@property(nonatomic, strong) UIWindow *wid;
@property(nonatomic, strong) UIButton *loginBtn;
@property(nonatomic, strong) MAMinipLauncher *launcher;
@property(nonatomic, strong) UIButton *historyAppsBtn;

@end

@implementation MAIndexVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    self.launcher = [MAMinipLauncher defaultLauncher];
    /// reset some user default  data
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults removeObjectForKey:@"launchPage"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshHistoryApp];
}

#pragma mark
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    /// Add the gesture of clicking the view to hide the keyboard
    UITapGestureRecognizer *endTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endInput:)];
    [self.view addGestureRecognizer:endTap];
    /// add search bar
    [self.navigationController.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationController.mas_topLayoutGuide);
        make.left.mas_equalTo(15);
        make.right.mas_lessThanOrEqualTo(-15);
        make.height.mas_equalTo(30);
    }];
    
    /// local mini app button
    [self.navigationController.view addSubview:self.historyAppsBtn];
    [self.historyAppsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.searchBar.mas_centerY);
        make.left.mas_equalTo(self.searchBar.mas_right).offset(5);
        make.width.height.mas_equalTo(self.searchBar.mas_height);
    }];
    
    /// add login demo
    [self.navigationController.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.searchBar.mas_centerY);
        make.left.mas_equalTo(self.historyAppsBtn.mas_right).offset(5);
        make.right.mas_equalTo(-15);
        make.width.height.mas_equalTo(self.searchBar.mas_height);
    }];
    
    /// add search result display list
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.left.right.mas_offset(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
}

- (void) excuteSearchApps {
    @weakify(self);
    MacleSearchAppletsRequest * searchRequest = [[MacleSearchAppletsRequest alloc] init];
    searchRequest.searchKey = self.searchBar.text;
    [MacleClient searchApplets:(MacleSearchAppletsRequest * _Nonnull)searchRequest success:^(MacleSearchAppletsResponse * _Nullable response) {
        @strongify(self);
        NSArray * entries = response.entries;
        NSMutableArray<MAMinipInfoModel *> *appInfos = [[NSMutableArray alloc] initWithCapacity:response.entries.count];
        for (MacleAppInfo * info in entries) {
            MAMinipPackageModel *package = [[MAMinipPackageModel alloc] init];
            package.url = info.appUrl;
            
            MAMinipInfoModel * model = [[MAMinipInfoModel alloc] init];
            model.app_logo = info.appLogoUrl;
            model.app_name = info.appName;
            model.app_desc = info.appDescription;
            model.service_status = 0;
            model.version = info.appVersion;
            model.app_id = info.appId;
            model.instance_id = info.instancId;
            model.package = package;
            [appInfos addObject:model];
        }
        MAMinipsModel *mapp = [[MAMinipsModel alloc] init];
        mapp.app_infos = appInfos;
        self.dataSource.minips = mapp;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (self.dataSource.minips.app_infos.count == 0) {
                [self.view makeToast:@"do not find mini app" duration:0.88 position:CSToastPositionCenter];
            }
        });
    } failure:^{
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view makeToast:@"request to server fail" duration:0.88 position:CSToastPositionCenter];
            [self failureCallBack];
        });
    }];
}

- (void) failureCallBack {
    self.dataSource.minips = nil;
    [self.table reloadData];
    if (self.table.mj_footer.isRefreshing) {
        [self.table.mj_footer endRefreshing];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - searchBar delegate
- (void)endInput:(id)sender {
    [self.navigationController.view endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (self.searchBar.text.length < 2) {
        [self.view makeToast:@"keyword length > 1" duration:0.3 position:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.view.frame), 100)]];
        return;
    }

    self.dataSource.minips = nil;
    [self excuteSearchApps];
}

#pragma mark - scan DefaultScanDelegate

- (void)defaultScanDelegateForDicResult:(NSDictionary *)resultDic {
    [self codeHandler:resultDic];
}

- (void)defaultScanImagePickerDelegateForImage:(UIImage *)image {
    NSDictionary *info = [HmsBitMap bitMapForImage:image withOptions:[[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:true]];
    [self codeHandler:info];
}

- (void)codeHandler:(NSDictionary *)info {
    NSString *sceneType = [[info objectForKey:@"parserDic"] objectForKey:@"sceneType"];
    
    if ([sceneType isEqualToString:@"WebSite"]) {
        NSString *result = [info objectForKey:@"text"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchBar.text = result;
            [self excuteSearchApps];
        });
        return;
    }
    
    NSString *result = [[info objectForKey:@"parserDic"] objectForKey:@"result"];
    NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *appDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *appid = [[appDic objectForKey:@"data"] objectForKey:@"app_id"];
    NSString *version = [[appDic objectForKey:@"data"] objectForKey:@"version"];
    NSString *sign = [[appDic objectForKey:@"data"] objectForKey:@"sign"];
    
    /// Click to experience the version
    NSMutableDictionary *clickEvent = [NSMutableDictionary new];
    clickEvent[@"appName"] = @"";
    clickEvent[@"appVersion"] = version;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970] * 1000;
    NSInteger intTime = round(time);
    clickEvent[@"timestamp"] = [NSNumber numberWithLong:intTime];
    [[MAEventReporManager sharedInstance] reportEvent:appid eventName:@"clickMiniApp" eventParam:clickEvent];
    
    [self executeOpenTrialWithAppId:appid version:version sign:sign];
}

- (void) executeOpenTrialWithAppId:(NSString *)appid version:(NSString *)version sign:(NSString *)sign{
    MAGetTrialApi *trialApi = [[MAGetTrialApi alloc] init];
    [trialApi getTrialWithAppId:appid version:version sign:sign success:^(MAMinipInfoModel *_Nullable trialModel) {
        if (!trialModel.package) {
            NSLog(@"there is no app pakcage to download");
            return;
        }
        if (trialModel.package) {
            MAMinipPackageModel *package = trialModel.package;
            NSString *appName = trialModel.app_name;
            NSString *appUrl = package.url;
            
            NSLog(@"begin to download app pakcage with appName: %@, appUrl: %@", appName, appUrl);

            self.launcher.info = trialModel;
            [self.launcher startAppWithUrl:appUrl isTrial:YES trialSign:sign];
        }else {
            [self.view makeToast:@"No corresponding experience package found" duration:0.55 position:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.view.frame), 100)]];
        }
    } failure:^(NSError * _Nonnull error) {
        NSString *info = error.userInfo[NSLocalizedDescriptionKey];
        if ([error.domain isEqualToString:@"invalid.cert.identity"]) {
            info = @"The token has expired, please click to scan the code to log in again";
        }
        [self.view makeToast:info duration:1.5 position:[NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame))]];
    }];
}

#pragma mark - lazy load

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(showLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)showLogin:(UIButton *)btn {
    [MADevLoginApi needLoginOnViewController:self withScanBlock:^{
    }];
}

- (UIButton *)historyAppsBtn {
    if (!_historyAppsBtn) {
        _historyAppsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_historyAppsBtn setImage:[UIImage imageNamed:@"history"] forState:UIControlStateNormal];
        [_historyAppsBtn addTarget:self action:@selector(getHistoryApps:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _historyAppsBtn;
}

- (void)getHistoryApps:(UIButton *)btn {
    [self refreshHistoryApp];
}

-(void)refreshHistoryApp {
    NSDictionary *historyApps = [[NSUserDefaults standardUserDefaults] objectForKey:@"historyApps"];
    NSArray<NSData *> *historyAppsData = [historyApps allValues];
    NSMutableArray *historyAppList = [[NSMutableArray alloc] init];
    for (NSData *appData in historyAppsData) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:appData options:0 error:nil];
        MAMinipInfoModel *minip = [MAMinipInfoModel toInstance:dict];
        [historyAppList addObject:minip];
    }
    MAMinipsModel *minips = [[MAMinipsModel alloc] init];
    minips.total_count = historyAppList.count;
    minips.current_page_num = 1;
    minips.per_page_size = historyAppList.count;
    minips.app_infos = historyAppList;
    self.dataSource.minips = nil;
    self.dataSource.minips = minips;
    [self.table reloadData];
}


- (UITableView *)table {
    if (!_table) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.backgroundColor = [UIColor whiteColor];
        table.delegate = self.dataSource;
        table.dataSource = self.dataSource;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.separatorInset = UIEdgeInsetsMake(0, 90, 0, 0);
        table.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@""
                                                       titleStr:@"no data"
                                                      detailStr:@"input key word to search mini app"];
        _table = table;
    }
    return _table;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        searchBar.backgroundColor = [UIColor clearColor];
        searchBar.barTintColor = [UIColor colorWithRed:247.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1.000];
        searchBar.backgroundImage = [UIImage new];
        searchBar.placeholder = @"input key word to search mini app";
        searchBar.delegate = self;
        UIToolbar *topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45)];
        [topView setBarStyle:UIBarStyleDefault];
        UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"hide keyboard" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 50, 45);
        [btn addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil];
        [topView setItems:buttonsArray];
        [searchBar setInputAccessoryView:topView];
        _searchBar = searchBar;
    }
    return _searchBar;
}

-(void)dismissKeyBoard
{
    [self.searchBar resignFirstResponder];
}


- (MAIndexDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[MAIndexDataSource alloc] init];
    }
    return _dataSource;
}

- (MJRefreshAutoNormalFooter *)footer {
    if (!_footer) {
        @weakify(self);
        _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self excuteSearchApps];
        }];
    }
    return _footer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
