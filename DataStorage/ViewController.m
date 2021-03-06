//
//  ViewController.m
//  DataStorage
//
//  Created by jianglei on 16/6/20.
//  Copyright © 2016年 xiaoshenyi. All rights reserved.
//

#import "ViewController.h"
#import "ArchiveViewController.h"
#import "SqViewController.h"
#import "FmdbViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableView;
    NSMutableArray *_titleArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title =@"数据存储";
    
    _titleArray =[[NSMutableArray alloc]initWithObjects:@"对象序列化",@"Sqlite3",@"FMDB", nil];
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource =self;
    _tableView.delegate =self;
    [self.view addSubview:_tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifierCell =@"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (!cell) {
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.textLabel.text =_titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            
            ArchiveViewController *archiveVC =[[ArchiveViewController alloc]init];
            [self.navigationController pushViewController:archiveVC animated:YES];
            
        }
            break;
            
        case 1:
        {
            
            SqViewController *sqVC =[[SqViewController alloc]init];
            [self.navigationController pushViewController:sqVC animated:YES];
        }
            break;
            
        case 2:
        {
            FmdbViewController *fmdbVC =[[FmdbViewController alloc]init];
            [self.navigationController pushViewController:fmdbVC animated:YES];
        
        }
            break;
            
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
