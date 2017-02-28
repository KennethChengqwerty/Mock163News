//
//  WYNewsListViewController.m
//  WYNewsDemo2
//
//  Created by Kenneth Cheng on 30/09/2016.
//  Copyright © 2016 Kenneth Cheng. All rights reserved.
//

#import "WYNewsListViewController.h"
#import "WYNewsModel.h"
#import "WYNewsCell.h"

static NSString *CELLID_NORMAL = @"normalcell";
static NSString *CELLID_BIG = @"newbigcell";
static NSString *CELLID_HEAD = @"newsheadcell";
static NSString *CELLID_TRI = @"newstricell";

@interface WYNewsListViewController ()<UITableViewDelegate,UITableViewDataSource>

//数据源
@property(nonatomic,strong) NSArray<WYNewsModel *>* newsList;

@property(nonatomic,weak) UITableView *tableView;

@property(nonatomic,copy) NSString *docID;

@end

@implementation WYNewsListViewController

-(instancetype)initWithChannelID:(NSString *)docID channelIndex:(NSInteger)channelIndex{
    self = [super init];
    if(self){
        _channelIndex = channelIndex;
        _docID = docID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getData];
}

- (void)setupUI {
    UITableView *tv = [[UITableView alloc] init];
    self.tableView = tv;
    [self.view addSubview:tv];
    tv.delegate = self;
    tv.dataSource = self;
    tv.rowHeight = UITableViewAutomaticDimension;
    tv.estimatedRowHeight = 100;
    
    [tv registerNib:[UINib nibWithNibName:@"WYNewsCell" bundle:nil] forCellReuseIdentifier:CELLID_NORMAL];
     [tv registerNib:[UINib nibWithNibName:@"WYBigNewsCell" bundle:nil] forCellReuseIdentifier:CELLID_BIG];
    [tv registerNib:[UINib nibWithNibName:@"WYHeadNewsCell" bundle:nil] forCellReuseIdentifier:CELLID_HEAD];
    [tv registerNib:[UINib nibWithNibName:@"WYTriNewsCell" bundle:nil] forCellReuseIdentifier:CELLID_TRI];
    
    [tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)getData{
//@"T1348648517839"
    [[WYNetworkTool sharedTool] getNewsListWithChannelID:_docID offSet:0 compplete:^(NSArray *modelList, NSError *error) {
        self.newsList = modelList;
        [self.tableView reloadData];
    }];
}

#pragma mark tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYNewsModel *model = self.newsList[indexPath.row];
    
    NSString *identifier = CELLID_NORMAL;
    
    if(model.hasHead){
        identifier = CELLID_HEAD;
    }else if(model.imgType){
        identifier = CELLID_BIG;
    }else if (model.imgextra){
        identifier = CELLID_TRI;
    }
    
    WYNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}



@end
