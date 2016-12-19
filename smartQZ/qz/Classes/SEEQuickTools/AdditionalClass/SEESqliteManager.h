//
//  SEESqliteManager.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/20.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEESqliteManager : NSObject
//制定创建方法
+ (nonnull instancetype)shareManager;

/**
 将模型存入数据库
 使用说明
 购物车接收到外界数据判断购物车数组中没有模型的时候在将模型加入到模型数组中以后调用该方法 datas填加进去的单个模型，千万不要将购物车整个数组加进去会造成重复添加数据
 @param datas 单个模型或者模型数组
 @param table 要存入的表的名字
 @return  0失败
 */
- (int)insertDatas:(nonnull id)datas toTable:(nonnull NSString *)table;

/**
 读取指定数据库中的数据并且转换为对应的模型对象
 使用说明
 程序启动后购物车调用这个方法获取数据库中的数据
 这个方法自动将数据转换为模型数组返回  只需要用数组接返回值就ok
 @param cla 模型类
 @param table 表名
 @param where 条件语句  为空查询全部
 @return 模型数组
 */
- (null_unspecified id)objectForClass:(nonnull Class)cla fromTable:(nonnull NSString *)table where:(NSString * _Nullable)where completeBlock:(nullable void(^)())complete;

/**
 删除模型对应的数据
 使用说明
 当某个商品从购物车中移除的时候调用这个方法 将被移除的模型传入datas即可
 idField为商品id
 @param datas 模型或者模型数组
 @param table 表名
 @param idField 用于判断数据的属性名 使用唯一标识
 @return  0失败
 */
- (int)deleteDatas:(nonnull id)datas forTable:(nonnull NSString *)table forIdField:(nonnull NSString *)idField;

/**
 使用模型或模型数组更新数据库中制定字段的值
 使用说明
 当购物车接到模型之后如果说这个模型在购物车的模型数组中存在 则调用这个方法跟新数据库中的选择数量 将接到的模型传入完成数据库数据的更新
 @param datas 模型或者模型数组
 @param table 表名
 @param idField 标识字段  （唯一标识）
 @param field 需要更新的字段
 @return  0失败
 */
- (int)updateDatas:(nonnull id)datas forTable:(nonnull NSString *)table forIdField:(nonnull NSString *)idField field:(nullable NSString *)field,...NS_REQUIRES_NIL_TERMINATION;

/**
 根据表中的字段更新对象模型
 使用说明
 当程序启动后首页和超市加载到网络数据后 将加载到的网络数据转换为模型数组 然后将模型数组整个传入  以保证网络数据和本地数据同步
 @param objcs 模型或者模型数组
 @param table 表名
 @param idField 标识字段  （唯一标识）
 @param field 更新模型中的属性名  如果为空则更新整个属性
 */
- (void)updateObjcs:(nonnull id)objcs withTable:(nonnull NSString *)table idField:(nonnull NSString *)idField field:(nullable NSString *)field,...NS_REQUIRES_NIL_TERMINATION;
@end
