//
//  ViewController.m
//  ListItemTest
//
//  Created by xiaotei's on 15/11/11.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import "ViewController.h"
//#import "ListItemModel.h"
#import "ListItemView.h"
#import "ListView.h"


@interface ViewController ()

//标签链式视图
@property (nonatomic,weak)ListView* listView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ListItemModel* model = [ListItemModel listItemWith:@"一一" itemID:@"00110"];
    ListItemModel* model1 = [ListItemModel listItemWith:@"二二" itemID:@"00111"];
    ListItemModel* model2 = [ListItemModel listItemWith:@"三三" itemID:@"00112"];
    ListItemModel* model3 = [ListItemModel listItemWith:@"四四" itemID:@"00113"];
    ListItemModel* model4 = [ListItemModel listItemWith:@"五五" itemID:@"00114"];
    ListItemModel* model5 = [ListItemModel listItemWith:@"六六" itemID:@"00115"];
    ListItemModel* model6 = [ListItemModel listItemWith:@"七七" itemID:@"00116"];
    ListItemModel* model7 = [ListItemModel listItemWith:@"八八" itemID:@"00117"];
    NSLog(@"%@",model);
    
//    ListItemView* listView = [[ListItemView alloc]init];
    
//    [self.view addSubview:listView];
    
//    [self listView];
    
    ListView* myListView = [[ListView alloc]initWithModels:@[model,model1,model2,model3,model4,model5,model6,model7]];
    _listView = myListView;

//    myListView.listItemModelArray = [[NSMutableArray alloc]initWithArray:];
    
    myListView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    
    [self.view addSubview:myListView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_listView stopJitter];
}



@end
