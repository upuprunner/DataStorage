//
//  FmdbViewController.m
//  DataStorage
//
//  Created by jianglei on 16/6/21.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "FmdbViewController.h"
#import "PeopleOperation.h"

@interface FmdbViewController ()<UITableViewDelegate,UITableViewDataSource>{

    UITableView *_tableView;
}

@property (nonatomic,strong)NSMutableArray *localMutArray;

@end

@implementation FmdbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =@"FMDB";
    self.view.backgroundColor =[UIColor whiteColor];
    
    [PeopleOperation createTable];
    self.localMutArray =[PeopleOperation getAllObject];
    
    UIBarButtonItem *addItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(fmdbAddItemClick)];
    self.navigationItem.rightBarButtonItem =addItem;
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource =self;
    _tableView.delegate =self;
    [self.view addSubview:_tableView];
    
}

#pragma mark----添加
- (void)fmdbAddItemClick{

    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请填写信息" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
        textField.placeholder =@"请输入你的名字";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
        textField.placeholder =@"请输入你的年龄";
    }];
    
    UIAlertAction *cancle =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        //确定
        People *people =[[People alloc]init];
        people.name =[alertController.textFields objectAtIndex:0].text;
        people.age =[alertController.textFields objectAtIndex:1].text;
        
        [PeopleOperation insertObject:people];
        self.localMutArray =[PeopleOperation getAllObject];
        [_tableView reloadData];
    }];
    
    [alertController addAction:cancle];
    [alertController addAction:sure];
    [self presentViewController:alertController animated:YES completion:nil];
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
        
        People *people =self.localMutArray[indexPath.row];
        cell.textLabel.text =people.name;
        cell.detailTextLabel.text =people.age;
    }
    
    
    return cell;
}

#pragma mark------修改
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    People *people =self.localMutArray[indexPath.row];
    
    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入要修改的信息" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.text =people.name;
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.text =people.age;
    }];
    
    UIAlertAction *cancle =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        people.name =[alertController.textFields objectAtIndex:0].text;
        people.age =[alertController.textFields objectAtIndex:1].text;
        
        [PeopleOperation updateObject:people withId:people.ID];
        self.localMutArray =[PeopleOperation getAllObject];
        [_tableView reloadData];
    }];
    
    [alertController addAction:cancle];
    [alertController addAction:sure];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        People *people =self.localMutArray[indexPath.row];
        [PeopleOperation deleteObjectById:people.ID];
        
        self.localMutArray =[PeopleOperation getAllObject];
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
