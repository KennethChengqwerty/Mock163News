//
//  WYNewsCell.h
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYNewsModel;
@interface WYNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_imageview;
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_source;
@property (weak, nonatomic) IBOutlet UILabel *lb_replyCount;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ivs_imageview;

@property(nonatomic,strong) WYNewsModel *model;
@end
