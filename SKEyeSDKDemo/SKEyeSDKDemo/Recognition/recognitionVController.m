//
//  recognitionVController.m
//  SK_ObjectRecognitionDemo
//
//  Created by cdong on 2017/4/7.
//  Copyright © 2017年 DC. All rights reserved.
//

#import "recognitionVController.h"
#import "recognitionView.h"
#import "SKEyeSDK/eyeTool.h"

@interface recognitionVController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic ,strong)recognitionView *recognitionV;
@property (nonatomic ,strong)NSArray *fruitArr;
@property (nonatomic ,strong)NSArray *objectArr;
@property (nonatomic ,assign)NSInteger currentCunt;
@property (nonatomic ,strong)NSString *serviceName;

@end

@implementation recognitionVController

- (void)loadView{
    self.recognitionV = [[recognitionView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _recognitionV;
}

- (void)addTargetAction{
    [self.recognitionV.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.recognitionV.changePicBtn addTarget:self action:@selector(changePicBtnAtion) forControlEvents:UIControlEventTouchUpInside];
    [self.recognitionV.albumBtn addTarget:self action:@selector(albumBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.recognitionV.cameraBtn addTarget:self action:@selector(cameraBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initImageData{
    _currentCunt = 0;
    NSString *imgName = @"";
    if (_typeFlag == 100) {
        _fruitArr = @[@"fruit1.jpg",@"fruit2.jpg",@"fruit3.jpg",@"fruit4.jpg",@"fruit5.jpg"];
        imgName = _fruitArr[0];
        _serviceName = SERVICE_NAME_FRUITS;
    }else if (_typeFlag == 200){
        _objectArr = @[@"object1.jpg",@"object2.jpg",@"object3.jpg",@"object4.jpg",@"object5.jpg"];
        imgName = _objectArr[0];
        _serviceName = SERVICE_NAME_OBJECT;
    }else{
        return;
    }
    self.recognitionV.pictureImgV.image = [UIImage imageNamed:imgName];
    [self uploadWithImage:[UIImage imageNamed:imgName] imagePath:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self addTargetAction];
    [self initImageData];
}

- (void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changePicBtnAtion{
    NSString *imageName= @"";
    _currentCunt++;
    if (_typeFlag == 100) {
        if (_currentCunt >= _fruitArr.count) {
            _currentCunt = 0;
        }
        imageName = _fruitArr[_currentCunt];
    }else if (_typeFlag == 200){
        if (_currentCunt >= _objectArr.count) {
            _currentCunt = 0;
        }
        imageName = _objectArr[_currentCunt];
    }else{
        return;
    }
    [_recognitionV setUpResultViewWithResultArr:nil];
    _recognitionV.pictureImgV.image = [UIImage imageNamed:imageName];
    [self uploadWithImage:[UIImage imageNamed:imageName] imagePath:nil];
}

- (void)albumBtnAction{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)cameraBtnAction{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        self.tabBarController.tabBar.hidden=YES;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.tabBarController.tabBar.hidden=YES;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        NSLog(@"该设备无摄像头");
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    if (image != nil) {
        [_recognitionV setUpResultViewWithResultArr:nil];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self uploadWithImage:image imagePath:nil];
        });
        _recognitionV.pictureImgV.image = image;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadWithImage:(UIImage *)image imagePath:(NSString*)imgPath{
    [eyeTool SKEyeSDK_Image:image service_name:_serviceName callBack:^(id responseObject) {
        if (responseObject == nil) {
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        [_recognitionV setUpResultViewWithResultArr:dic[@"tags"]];
        _recognitionV.jsonTextView.text = [NSString stringWithFormat:@"%@",dic];
    }];
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
