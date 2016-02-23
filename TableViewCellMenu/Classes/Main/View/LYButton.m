//
//  LYButton.m
//  TableViewCellMenu
//
//  Created by li_yong on 15/8/25.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "LYButton.h"

@implementation LYButton

- (id)initWithFrame:(CGRect)frame model:(MenuItemModel *)menuItemModel
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self customViewWithModel:menuItemModel];
    }
    
    return self;
}

- (void)customViewWithModel:(MenuItemModel *)menuItemModel
{
    //图片
    UIImageView *buttonImageView = [[UIImageView alloc] init];
    buttonImageView.bounds = CGRectMake(0, 0, 20, 20);
    buttonImageView.center = CGPointMake(self.frame.size.width/2, 20);
    buttonImageView.image = [UIImage imageNamed:menuItemModel.normalImageName];
    [self addSubview:buttonImageView];
    
    //文案
    UILabel *buttonLabel = [[UILabel alloc] init];
    buttonLabel.bounds = CGRectMake(0, 0, self.frame.size.width, 20);
    buttonLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height - buttonLabel.frame.size.height/2);
    buttonLabel.text = menuItemModel.itemText;
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    buttonLabel.font = [UIFont systemFontOfSize:10];
    buttonLabel.textColor = [UIColor whiteColor];
    [self addSubview:buttonLabel];
}

@end