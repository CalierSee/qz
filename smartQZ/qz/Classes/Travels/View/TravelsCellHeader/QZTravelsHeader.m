//
//  QZTravelsHeader.m
//  qz
//
//  Created by 景彦铭 on 2016/12/13.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#import "QZTravelsHeader.h"

@interface QZTravelsHeader ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *arraw;
@property (weak, nonatomic) IBOutlet UILabel *all;


@end


@implementation QZTravelsHeader

- (void)setModel:(QZHomeModel *)model {
    _model = model;
    _title.text = model.header;
    
}

- (void)setHiddenAll:(BOOL)hiddenAll {
    _hiddenAll = hiddenAll;
    if (_hiddenAll){
        _all.hidden = YES;
        _arraw.hidden = YES;
    }
    else {
        _all.hidden = NO;
        _arraw.hidden = NO;
    }
}

@end
