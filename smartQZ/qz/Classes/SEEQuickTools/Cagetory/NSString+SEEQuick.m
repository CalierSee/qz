//
//  NSString+SEEQuick.m
//  SEEQuick
//
//  Created by 景彦铭 on 16/9/12.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "NSString+SEEQuick.h"

@implementation NSString (SEEQuick)

- (CGFloat)see_heightWithWidth:(CGFloat)width fontSize:(CGFloat)size{
    NSMutableParagraphStyle *paragraphstyle=[[NSMutableParagraphStyle alloc]init];
    paragraphstyle.lineBreakMode=NSLineBreakByCharWrapping;
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size],NSParagraphStyleAttributeName:paragraphstyle.copy} context:nil].size.height;
}

- (CGFloat)see_widthWithHeight:(CGFloat)height fontSize:(CGFloat)size{
    NSMutableParagraphStyle *paragraphstyle=[[NSMutableParagraphStyle alloc]init];
    paragraphstyle.lineBreakMode=NSLineBreakByCharWrapping;
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size],NSParagraphStyleAttributeName:paragraphstyle.copy} context:nil].size.width;
}
    
+ (NSString *)see_cachePathForURL:(NSString *)url {
    
    return [self see_pathForURL:url forDirectory:NSCachesDirectory];
}
    
+ (NSString *)see_documentPathForURL:(NSString *)url {
    
    return [self see_pathForURL:url forDirectory:NSDocumentDirectory];
}
    
+ (NSString *)see_tempPathForURL:(NSString *)url {
    NSString * fileName = [url lastPathComponent];
    NSString * path = NSTemporaryDirectory();
    return [path stringByAppendingPathComponent:fileName];
}
    
    
+ (NSString *)see_pathForURL:(NSString *)url forDirectory:(NSSearchPathDirectory)directory {
    NSString * fileName = [url lastPathComponent];
    NSString * path = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES).lastObject;
    return [path stringByAppendingPathComponent:fileName];
}

@end
