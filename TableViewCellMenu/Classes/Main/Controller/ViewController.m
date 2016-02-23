//
//  ViewController.m
//  TableViewCellMenu
//
//  Created by li_yong on 15/7/28.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "ViewController.h"
#import "MenuItemModel.h"
#import "CellModel.h"
#import "MenuTableViewCell.h"
#import "FavoriteViewController.h"
#import "AlbumViewController.h"
#import "DownLoadViewController.h"
#import "SingerViewController.h"

#define ID @"MyCell"

typedef enum
{
    FavoriteOperation = 0,
    AlbumOperation,
    DownLoadOperation,
    SingerOperation,
    DeleteOperation
} OperationType;

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,MenuTableViewCellDelegate,MenutableViewCellDataSource>

//列表
@property (strong, nonatomic) UITableView *tableView;

//已经打开下拉菜单的单元格
@property (strong, nonatomic) MenuTableViewCell *openedMenuCell;
//已经打开下拉菜单的单元格的位置
@property (strong, nonatomic) NSIndexPath *openedMenuCellIndex;

//列表数据源
@property (strong, nonatomic) NSMutableArray *dataSourceArray;
//下拉菜单数据源
@property (strong, nonatomic) NSMutableArray *menuItemDataSourceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self buildDataSource];
    
    [self buildView];
}

/**
 *  @author li_yong
 *
 *  构建数据源
 */
- (void)buildDataSource
{
    //构建单元格下拉列表数据源
    self.menuItemDataSourceArray = [NSMutableArray arrayWithCapacity:0];
    MenuItemModel *favItemModel = [[MenuItemModel alloc] initWithNormalImageName:@"cm2_lay_icn_fav@3x" withHighLightedImageName:@"cm2_lay_icn_fav@3x" withItemText:@"收藏"];
    
    [self.menuItemDataSourceArray addObject:favItemModel];

    MenuItemModel *albItemModel = [[MenuItemModel alloc] initWithNormalImageName:@"cm2_lay_icn_alb@3x" withHighLightedImageName:@"cm2_lay_icn_alb@3x" withItemText:@"专辑"];
    [self.menuItemDataSourceArray addObject:albItemModel];
    
    MenuItemModel *dldItemModel = [[MenuItemModel alloc] initWithNormalImageName:@"cm2_lay_icn_dld@3x" withHighLightedImageName:@"cm2_lay_icn_dld@3x" withItemText:@"下载"];
    [self.menuItemDataSourceArray addObject:dldItemModel];
    
    MenuItemModel *artistItemModel = [[MenuItemModel alloc] initWithNormalImageName:@"cm2_lay_icn_artist@3x" withHighLightedImageName:@"cm2_lay_icn_artist@3x" withItemText:@"歌手"];
    [self.menuItemDataSourceArray addObject:artistItemModel];
    
    MenuItemModel *dltItemModel = [[MenuItemModel alloc] initWithNormalImageName:@"cm2_lay_icn_dlt@3x" withHighLightedImageName:@"cm2_lay_icn_dlt@3x" withItemText:@"删除"];
    [self.menuItemDataSourceArray addObject:dltItemModel];
    
    //构建列表数据源
    self.dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    for (int index = 0; index < 5; index++)
    {
        CellModel *cellModel = [[CellModel alloc] initWithImageName:@"foxgirl.jpg" labelText:@"夏日的风"];
        [self.dataSourceArray addObject:cellModel];
    }
}

/**
 *  @author li_yong
 *
 *  搭建界面
 */
- (void)buildView
{
    //列表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)
                                                  style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MenuTableViewCell class]) bundle:nil]
         forCellReuseIdentifier:ID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UIView *tableFootView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableFooterView = tableFootView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *Cell = (MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    Cell.delegate = self;
    Cell.dataSource = self;
    Cell.moreBtn.tag = indexPath.row;
    //需要手动绘制下拉菜单视图，通过xib创建视图的时候cell的delegate和dataSource尚未确定
    [Cell buildMenuView];
    if (indexPath.row < [self.dataSourceArray count])
    {
        CellModel *cellModel = [self.dataSourceArray objectAtIndex:indexPath.row];
        Cell.headImageView.image = [UIImage imageNamed:cellModel.imageName];
        Cell.indexPathLabel.text = cellModel.labelText;
        Cell.detailMessages.text = @"点击现实详情";
    }
    return Cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((self.openedMenuCell != nil)&&
        (self.openedMenuCell.isOpenMenu = YES)&&
        (self.openedMenuCellIndex.row == indexPath.row))
    {
        return 114.0;
    }else
    {
        return 64.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MenutableViewCellDataSource

- (NSMutableArray *)dataSourceForMenuItem
{
    return self.menuItemDataSourceArray;
}

#pragma mark - MenuTableViewCellDelegate

- (void)didOpenMenuAtCell:(MenuTableViewCell *)menuTableVieCell withMoreButton:(UIButton *)moreButton
{
    /*
     //不需要刷新旧的cell
     //先刷新旧的Cell
     if ((self.openedMenuCell != nil)&&
     (self.openedMenuCell.isOpenMenu = YES))
     {
     if ((self.openedMenuCellIndex.row == indexPath.row))
     {
     //如果点的是同一个cell关闭下拉菜单并且不刷新新的cell
     self.openedMenuCell = nil;
     [tableView reloadRowsAtIndexPaths:@[self.openedMenuCellIndex] withRowAnimation:UITableViewRowAnimationFade];
     self.openedMenuCellIndex = nil;
     return;
     }else
     {
     [tableView reloadRowsAtIndexPaths:@[self.openedMenuCellIndex] withRowAnimation:UITableViewRowAnimationFade];
     }
     }
     */

    NSIndexPath *openedIndexPath = [NSIndexPath indexPathForRow:moreButton.tag inSection:0];
    
    if ((self.openedMenuCell != nil)&&
        (self.openedMenuCell.isOpenMenu = YES)&&
        (self.openedMenuCellIndex.row == openedIndexPath.row))
    {
        //如果点的是同一个cell关闭下拉菜单并且不刷新新的cell
        self.openedMenuCell = nil;
        [self.tableView reloadRowsAtIndexPaths:@[self.openedMenuCellIndex] withRowAnimation:UITableViewRowAnimationFade];
        self.openedMenuCellIndex = nil;
        return;
    }
    
    //刷新新的Cell
    self.openedMenuCell = menuTableVieCell;
    self.openedMenuCellIndex = openedIndexPath;
    [self.tableView reloadRowsAtIndexPaths:@[self.openedMenuCellIndex] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView scrollToRowAtIndexPath:self.openedMenuCellIndex
                          atScrollPosition:UITableViewScrollPositionNone
                                  animated:YES];

}

- (void)menuTableViewCell:(MenuTableViewCell *)menuTableViewCell didSeletedMentItemAtIndex:(NSInteger)menuItemIndex
{
    //首先关闭打开的下拉菜单
    if ((self.openedMenuCell != nil)&&
        (self.openedMenuCell.isOpenMenu = YES)&&
        (self.openedMenuCellIndex.row == menuTableViewCell.moreBtn.tag))
    {
        //如果点的是同一个cell关闭下拉菜单并且不刷新新的cell
        self.openedMenuCell = nil;
        [self.tableView reloadRowsAtIndexPaths:@[self.openedMenuCellIndex] withRowAnimation:UITableViewRowAnimationFade];
        self.openedMenuCellIndex = nil;
    }
    
    //根据点击的下拉菜单的item触发相应的事件
    switch (menuItemIndex)
    {
        case FavoriteOperation:
        {
            FavoriteViewController *favoriteVC = [[FavoriteViewController alloc] init];
            [self.navigationController pushViewController:favoriteVC animated:YES];
        }
            break;
        case AlbumOperation:
        {
            AlbumViewController *albumVC = [[AlbumViewController alloc] init];
            [self.navigationController pushViewController:albumVC animated:YES];
        }
            break;
        case DownLoadOperation:
        {
            DownLoadViewController *downLoadVC = [[DownLoadViewController alloc] init];
            [self.navigationController pushViewController:downLoadVC animated:YES];
        }
            break;
        case SingerOperation:
        {
            SingerViewController *singerVC = [[SingerViewController alloc] init];
            [self.navigationController pushViewController:singerVC animated:YES];
        }
            break;
        case DeleteOperation:
        {
            NSInteger deleteInteger = menuTableViewCell.moreBtn.tag;
            NSIndexPath *deletIndexPath = [NSIndexPath indexPathForRow:deleteInteger inSection:0];
            //刷新数据源
            [self.dataSourceArray removeObjectAtIndex:deleteInteger];
            //刷新列表
            [self.tableView deleteRowsAtIndexPaths:@[deletIndexPath] withRowAnimation:UITableViewRowAnimationMiddle];
            //如果不执行下面的代码cell的moreBtn的tag就没办法刷新。
            [self.tableView reloadData];
        }
            break;
            
        default:
            break;
    }
}

@end
