//
//  MenuTableViewCell.h
//  TableViewCellMenu
//
//  Created by li_yong on 15/7/28.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenutableViewCellDataSource;
@protocol MenuTableViewCellDelegate;

@interface MenuTableViewCell : UITableViewCell

@property (strong, nonatomic) id <MenutableViewCellDataSource> dataSource;
@property (strong, nonatomic) id <MenuTableViewCellDelegate> delegate;

//是否已经打开
@property (assign, nonatomic) BOOL isOpenMenu;

//头像
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;

//cell的位置标签
@property (strong, nonatomic) IBOutlet UILabel *indexPathLabel;
// cell详情
@property (weak, nonatomic) IBOutlet UILabel *detailMessages;

//下拉菜单按钮
@property (strong, nonatomic) IBOutlet UIButton *moreBtn;

//下拉菜单视图
@property (weak, nonatomic) IBOutlet UIView *menuView;

/**
 *  @author li_yong
 *
 *  自定义Cell中控件属性
 */
- (void)customCell;

/**
 *  构建下拉视图
 */
- (void)buildMenuView;

@end

/**
 *  定义数据源
 */
@protocol MenutableViewCellDataSource <NSObject>

@required
- (NSMutableArray *)dataSourceForMenuItem;

@end

/**
 *  定义代理
 */
@protocol MenuTableViewCellDelegate <NSObject>

@optional
- (void)didOpenMenuAtCell:(MenuTableViewCell *)menuCell withMoreButton:(UIButton *)moreButton;

- (void)menuTableViewCell:(MenuTableViewCell *)menuTableViewCell didSeletedMentItemAtIndex:(NSInteger)menuItemIndex;

@end

