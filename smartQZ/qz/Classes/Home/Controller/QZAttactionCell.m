//
//  QZAttactionCell.m
//  qz
//
//  Created by 景彦铭 on 2016/12/17.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZAttactionCell.h"
#import "QZAttactionView.h"
@interface QZAttactionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet QZAttactionView *star;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *old_prict;
@property (weak, nonatomic) IBOutlet UILabel *free;
@property (weak, nonatomic) IBOutlet UILabel *common;


@end

@implementation QZAttactionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showWithModel:(QZAttactionModel *)model {
    _icon.image = [model iconImage];
    _desc.attributedText = [model descAttributeString];
    _location.text = model.location;
    _price.text = [NSString stringWithFormat:@"￥%@",model.price];
    _old_prict.text = [NSString stringWithFormat:@"￥%@",model.old_price];
    _free.hidden = [model.price intValue];
    _price.hidden = ![model.price intValue];
    _old_prict.hidden = ![model.price intValue];
    _common.text = [NSString stringWithFormat:@"%@评论",model.common];
    [_star drawWithImages:[model starImage]];
}

@end
