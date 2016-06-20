//
//  ArchiveViewController.m
//  DataBase
//
//  Created by jianglei on 16/6/19.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "ArchiveViewController.h"
#import "ArchiveManager.h"

@interface ArchiveViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableView;
}
@property (nonatomic,strong)NSMutableArray *localMutArray;

@end

@implementation ArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =@"对象序列化";
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIBarButtonItem *addItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(archiveVCAddItemClick)];
    self.navigationItem.rightBarButtonItem =addItem;
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource =self;
    _tableView.delegate =self;
    [self.view addSubview:_tableView];
    
    //路径已经存在
    if ([[ArchiveManager sharedInstance]isAlerdayHave]) {
        
        NSLog(@"-----文件存在");
        //取出数据
        NSString *path =[[ArchiveManager sharedInstance]stringAppendingPath];
        NSData *data =[NSData dataWithContentsOfFile:path];
        
        self.localMutArray =[NSKeyedUnarchiver unarchiveObjectWithData:data];
        
    }else{
    
        NSLog(@"----文件不存在");
        self.localMutArray =[[NSMutableArray alloc]init];
    }
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
        
        Student *student =self.localMutArray[indexPath.row];
        cell.textLabel.text =student.name;
        cell.detailTextLabel.text =student.age;
        
    }
    
    return cell;
}

#pragma mark-----添加数据
- (void)archiveVCAddItemClick{

    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入学生的名字和年龄" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder =@"请输入名字";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder =@"请输入年龄";
    }];
    
    UIAlertAction *cancle =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消
    }];
    
    UIAlertAction *sure =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //确定
        Student *student =[[Student alloc]init];
        student.name =[alertController.textFields objectAtIndex:0].text;
        student.age =[alertController.textFields objectAtIndex:1].text;
        
        [self.localMutArray addObject:student];
        
        [[ArchiveManager sharedInstance]operationDataWithArray:self.localMutArray];
        [_tableView reloadData];
        
    }];
    
    [alertController addAction:cancle];
    [alertController addAction:sure];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark----修改数据
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Student *student =self.localMutArray[indexPath.row];
    
    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请修改学生的名字和年龄" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.text =student.name;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.text =student.age;
    }];
    
    UIAlertAction *cancle =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //取消
    }];
    
    UIAlertAction *sure =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //确定
        student.name =[alertController.textFields objectAtIndex:0].text;
        student.age =[alertController.textFields objectAtIndex:1].text;
        
        [[ArchiveManager sharedInstance]operationDataWithArray:self.localMutArray];
        [_tableView reloadData];
        
    }];
    
    [alertController addAction:cancle];
    [alertController addAction:sure];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.localMutArray removeObjectAtIndex:indexPath.row];
        [[ArchiveManager sharedInstance]operationDataWithArray:self.localMutArray];
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
