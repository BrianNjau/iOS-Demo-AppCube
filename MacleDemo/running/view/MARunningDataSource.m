//
//  MARunningDataSource.m
//  MacleDemo
//
//  Created by Macle
//

#import "MARunningDataSource.h"
#import "MARunningCell.h"


@implementation MARunningDataSource

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.apps.count) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
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
    MARunningCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MARunningCell class])];
    if (!cell) {
        cell = [[MARunningCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MARunningCell class])];
        @weakify(self);
        [cell setDidKillAppBlock:^{
            @strongify(self);
            if (self.didKillAppBlock) {
                self.didKillAppBlock();
            }
        }];
        [cell setDidRemoveAppBlock:^{
            @strongify(self);
            if (self.didRemoveAppBlock) {
                self.didRemoveAppBlock();
            }
        }];
    }
    cell.appInfo = [self.apps objectAtIndex:indexPath.row];
    return cell;
}

@end
