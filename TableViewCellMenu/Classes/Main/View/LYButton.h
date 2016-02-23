//
//  LYButton.h
//  TableViewCellMenu
//
//  Created by li_yong on 15/8/25.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItemModel.h"

@interface LYButton : UIButton

/**
 *  @author li_yong
 *
 *  构造方法
 *
 *  @param frame         rect
 *  @param menuItemModel 构造模型
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame model:(MenuItemModel *)menuItemModel;

@end