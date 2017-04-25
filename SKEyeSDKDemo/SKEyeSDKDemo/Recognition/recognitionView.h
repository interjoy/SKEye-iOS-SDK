//
//  recognitionView.h
//  SK_ObjectRecognitionDemo
//
//  Created by cdong on 2017/3/24.
//  Copyright © 2017年 DC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recognitionView : UIView

@property (nonatomic ,strong)UIScrollView *scrollV;
@property (nonatomic ,strong)UIImageView *pictureImgV;
@property (nonatomic ,strong)UIButton *changePicBtn;
@property (nonatomic ,strong)UIButton *albumBtn;
@property (nonatomic ,strong)UIButton *cameraBtn;
@property (nonatomic ,strong)UITextView *jsonTextView;
@property (nonatomic ,strong)UIButton *backBtn;
@property (nonatomic ,strong)UIView *resultV;
@property (nonatomic ,strong)UIView *jsonv;

- (void)setUpResultViewWithResultArr:(NSArray*)resultArr;

@end
