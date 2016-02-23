//
//  UIButton+Extra.m
//  TableViewCellMenu
//
//  Created by 李勇 on 15/8/1.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "UIButton+Extra.h"

@implementation UIButton (Extra)

/**
 *  下拉菜单按钮的工厂方法
 *
 *  @param menuItemModel 创建下拉菜单按钮的Model
 *  @param buttonFrame   创建下拉菜单按钮的尺寸
 *
 *  @return
 */
// UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
+ (UIButton *)creartButtonWith:(MenuItemModel *)menuItemModel withFrame:(CGRect)buttonFrame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = buttonFrame;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    [button setImage:[UIImage imageNamed:menuItemModel.normalImageName]
            forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:menuItemModel.highLightedImageName]
            forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:menuItemModel.selectedImageName]
            forState:UIControlStateSelected];
    [button setImageEdgeInsets:UIEdgeInsetsMake(10, 19, 20, 19)];
    
    [button setTitle:menuItemModel.itemText forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor]
                 forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(35, -(buttonFrame.size.width)-7, 5, 0)];
    
    return button;
}

@end