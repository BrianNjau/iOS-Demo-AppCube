//
//  MAIndexDataSource.m
//  MacleDemo
//
//  Created by Macle
//

#import "MAIndexDataSource.h"
#import "MAIndexCell.h"


@interface MAIndexDataSource()

@end


@implementation MAIndexDataSource

- (void)setMinips:(MAMinipsModel *)minips {
    if (!_minips) {
        _minips = minips;
    }else {
        NSMutableArray<MAMinipInfoModel *> *appInfos = [[NSMutableArray alloc] initWithArray:_minips.app_infos];
        [appInfos addObjectsFromArray:minips.app_infos];
        minips.app_infos = appInfos;
        _minips = minips;
    }
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.minips) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.minips) {
        return self.minips.app_infos.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MAIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MAIndexCell class])];
    if (!cell) {
        cell = [[MAIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MAIndexCell class])];
    }
    cell.info = [self.minips.app_infos objectAtIndex:indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
