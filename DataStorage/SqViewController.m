//
//  SqViewController.m
//  DataBase
//
//  Created by jianglei on 16/6/19.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "SqViewController.h"
#import "SqManager.h"

@interface SqViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableView;
}

@property (nonatomic,strong)NSMutableArray *localMutArray;

@end

@implementation SqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =@"Sqlite3";
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIBarButtonItem *addItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemClick)];
    self.navigationItem.rightBarButtonItem =addItem;
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource =self;
    _tableView.delegate =self;
    [self.view addSubview:_tableView];
    
    //创建表
    [[SqManager sharedInstance]createTable];
    //取出所有的数据
    self.localMutArray =[[SqManager sharedInstance]getAllObject];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.localMutArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifierCell =@"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (!cell) {
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifierCell];
    }
    
    if (self.localMutArray.count >0) {
        
        Car *car =self.localMutArray[indexPath.row];
        
        cell.textLabel.text =car.name;
        cell.detailTextLabel.text =[NSString stringWithFormat:@"￥%@",car.price];
    }
    
    
    return cell;
}

#pragma mark----添加数据
- (void)addItemClick{

    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入车的名字和单价" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder =@"请输入名字";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
        textField.placeholder =@"请输入单价";
    }];
    
    UIAlertAction *cancle =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       //取消
    }];
    
    UIAlertAction *sure =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        //确定
        Car *car =[[Car alloc]init];
        car.name =[alertController.textFields objectAtIndex:0].text;
        car.price =[alertController.textFields objectAtIndex:1].text;
        
        [[SqManager sharedInstance]insertObject:car];
        self.localMutArray =[[SqManager sharedInstance]getAllObject];
        [_tableView reloadData];
    }];
    
    [alertController addAction:cancle];
    [alertController addAction:sure];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark----修改数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Car *car =self.localMutArray[indexPath.row];
    
    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请修改车的名字和单价" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.text =car.name;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.text =car.price;
    }];
    
    UIAlertAction *cancle =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消
    }];
    
    UIAlertAction *sure =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //确定
        car.name =[alertController.textFields objectAtIndex:0].text;
        car.price =[alertController.textFields objectAtIndex:1].text;
        
        [[SqManager sharedInstance]updateObject:car];
        self.localMutArray =[[SqManager sharedInstance]getAllObject];
        [_tableView reloadData];
    }];
    
    [alertController addAction:cancle];
    [alertController addAction:sure];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark----删除数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Car *car =self.localMutArray[indexPath.row];
        [[SqManager sharedInstance]deleteObject:car];
        self.localMutArray =[[SqManager sharedInstance]getAllObject];
        [_tableView reloadData];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
