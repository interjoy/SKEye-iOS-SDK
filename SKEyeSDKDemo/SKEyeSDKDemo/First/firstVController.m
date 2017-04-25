//
//  firstVController.m
//  SK_ObjectRecognitionDemo
//
//  Created by cdong on 2017/3/24.
//  Copyright © 2017年 DC. All rights reserved.
//

#import "firstVController.h"
#import "firstView.h"
#import "recognitionVController.h"

@interface firstVController ()

@property (nonatomic ,strong)firstView *firstV;

@end

@implementation firstVController

- (void)loadView{
    [super loadView];
    self.firstV = [[firstView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _firstV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [_firstV.fruitRecBtn addTarget:self action:@selector(fruitRecBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_firstV.householdRecBtn addTarget:self action:@selector(householdRecBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)householdRecBtnAction{
    recognitionVController *houseVC = [[recognitionVController alloc]init];
    houseVC.typeFlag = 200;
    [self.navigationController pushViewController:houseVC animated:YES];
}

- (void)fruitRecBtnAction{
    recognitionVController *recVC = [[recognitionVController alloc]init];
    recVC.typeFlag = 100;
    [self.navigationController pushViewController:recVC animated:YES];
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
