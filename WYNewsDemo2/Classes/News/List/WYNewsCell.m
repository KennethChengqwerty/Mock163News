//
//  WYNewsCell.m
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import "WYNewsCell.h"
#import "WYNewsModel.h"

@implementation WYNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(WYNewsModel *)model{
    
    _model = model;
    self.lb_title.text = model.title;
    self.lb_source.text = model.source;
    self.lb_replyCount.text = [[model.replyCount stringValue] stringByAppendingString:@"跟帖"];
    [self.iv_imageview cz_loadWebImage:model.imgsrc];
    
    if(model.imgextra){
    [model.imgextra enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imgAddr = obj[@"imgsrc"];
        UIImageView *iv = self.ivs_imageview[idx];
        [iv cz_loadWebImage:imgAddr];
        
    }];
    }
}

@end
