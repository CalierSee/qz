//
//  UITableView+SEEQuick.m
//  Moment
//
//  Created by 景彦铭 on 16/9/11.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "UITableView+SEEQuick.h"

@implementation UITableView (SEEQuick)

+ (instancetype)see_createWithFrame:(CGRect)frame style:(UITableViewStyle)style registerClass:(Class)class reuseIdentifier:(NSString *)reuseID delegate:(id)delegate dataSource:(id)dataSource {
    UITableView * tableV = [[UITableView alloc]initWithFrame:frame style:style];
    [tableV registerClass:class forCellReuseIdentifier:reuseID];
    tableV.delegate = delegate;
    tableV.dataSource = dataSource;
    return tableV;
}

+ (instancetype)see_createWithFrame:(CGRect)frame style:(UITableViewStyle)style registerNib:(UINib *)nib reuseIdentifier:(NSString *)reuseID delegate:(id)delegate dataSource:(id)dataSource {
    UITableView * tableV = [[UITableView alloc]initWithFrame:frame style:style];
    [tableV registerNib:nib forCellReuseIdentifier:reuseID];
    tableV.delegate = delegate;
    tableV.dataSource = dataSource;
    return tableV;
}

@end
