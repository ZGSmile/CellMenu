//
//  CellModel.h
//  TableViewCellMenu
//
//  Created by li_yong on 15/8/20.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

//图片名
@property (nonatomic, strong) NSString *imageName;
//标签内容
@property (nonatomic, strong) NSString *labelText;

/**
 *  @author li_yong
 *
 *  构造函数
 *
 *  @param imageName 图片名
 *  @param labelText 标签内容
 *
 *  @return
 */
- (id)initWithImageName:(NSString *)imageName labelText:(NSString *)labelText;

@end