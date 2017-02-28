//
//  WYChannelModel.m
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import "WYChannelModel.h"

@implementation WYChannelModel


-(NSString *)description{
    return [self yy_modelDescription];
}

+(NSArray<WYChannelModel *> *)channalList{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    id instance = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *array = instance[@"tList"];
    
    NSArray *modelArr = [NSArray yy_modelArrayWithClass:[self class] json:array];
    
    //排序
   return  [modelArr sortedArrayUsingComparator:^NSComparisonResult(WYChannelModel*  _Nonnull obj1, WYChannelModel*  _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
}
@end
