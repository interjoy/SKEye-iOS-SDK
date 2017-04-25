//
//  recognitionView.m
//  SK_ObjectRecognitionDemo
//
//  Created by cdong on 2017/3/24.
//  Copyright © 2017年 DC. All rights reserved.
//

#import "recognitionView.h"

#define matchW ([[UIScreen mainScreen]bounds].size.width/540)
#define matchH ([[UIScreen mainScreen]bounds].size.height/870)

@implementation recognitionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    self.backgroundColor = [UIColor whiteColor];
    
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollV.contentSize = CGSizeMake(self.frame.size.width, (self.frame.size.height+100)*2*matchH);
    _scrollV.backgroundColor = [UIColor colorWithRed:(0xf3)/255.0 green:(0xf3)/255.0 blue:(0xf3)/255.0 alpha:1];
    [self addSubview:_scrollV];
    
    self.pictureImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width*3/4)];
    [_scrollV addSubview:_pictureImgV];
    
    self.albumBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _albumBtn.frame = CGRectMake(43*matchW, CGRectGetMaxY(_pictureImgV.frame) , (self.frame.size.width - 86*matchW - 72*matchW)/2, 73*matchH);
    UIImage *albumPic = [[UIImage imageNamed:@"icon_xiangce_a"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [_albumBtn setImage:albumPic forState:UIControlStateNormal];
    _albumBtn.imageEdgeInsets = UIEdgeInsetsMake(21*matchH,0,20*matchH,0);
    //[_albumBtn setBackgroundImage:[UIImage imageNamed:@"icon_xiangce_b"] forState:UIControlStateSelected];
    [_scrollV addSubview:_albumBtn];
    
    self.cameraBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _cameraBtn.frame = CGRectMake(self.frame.size.width - 43*matchW-CGRectGetWidth(_albumBtn.frame), CGRectGetMinY(_albumBtn.frame), CGRectGetWidth(_albumBtn.frame), CGRectGetHeight(_albumBtn.frame));
    UIImage *cameraPic = [[UIImage imageNamed:@"icon_xiangji_a"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [_cameraBtn setImage:cameraPic forState:UIControlStateNormal];
    _cameraBtn.imageEdgeInsets = UIEdgeInsetsMake(21*matchH,0,20*matchH,0);
    //[_cameraBtn setBackgroundImage:[UIImage imageNamed:@"icon_xiangji_b"] forState:UIControlStateSelected];
    [_scrollV addSubview:_cameraBtn];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _backBtn.frame = CGRectMake(12*matchW,30*matchH, 44, 44);
    UIImage *ii = [[UIImage imageNamed:@"2left"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [_backBtn setImage:ii forState:UIControlStateNormal];
    _backBtn.imageEdgeInsets = UIEdgeInsetsMake(7,0,7,14);
    [_scrollV addSubview:_backBtn];
    
    self.changePicBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _changePicBtn.frame = CGRectMake(self.frame.size.width-30*matchW-101*matchW, 34*matchH, 120*matchW, 60*matchH);
    //UIImage *_changePic = [[UIImage imageNamed:@"icon_suiji_a"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    //[_changePicBtn setImage:_changePic forState:UIControlStateNormal];
    //_changePicBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,27*matchH,0);
    //[_changePicBtn setBackgroundImage:[UIImage imageNamed:@"icon_suiji_b"] forState:UIControlStateHighlighted];
    [_changePicBtn setTitle:@"随机换一张" forState:UIControlStateNormal];
    [_changePicBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _changePicBtn.titleLabel.font = [UIFont systemFontOfSize:18*matchW];
    [_scrollV addSubview:_changePicBtn];
    
    //[self setUpResultView];
}

- (void)setUpResultViewWithResultArr:(NSArray*)resultArr{
    
    int cunt = (int)resultArr.count;
    if (cunt > 3) {
        cunt = 3;
    }
    
    if(self.resultV != nil){
        [self.resultV removeFromSuperview];
    }
    if (self.jsonv != nil) {
        [self.jsonv removeFromSuperview];
    }
    
    self.resultV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_albumBtn.frame) - 5*matchH, self.frame.size.width, 42*(cunt+2)*matchH)];
    _resultV.backgroundColor = [UIColor whiteColor];
    [_scrollV addSubview:_resultV];
    
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_albumBtn.frame), 0, (self.frame.size.width-CGRectGetMinX(_albumBtn.frame)*2)/2, 42*matchH)];
    nameL.text = @"识别结果";
    nameL.textAlignment = NSTextAlignmentLeft;
    nameL.font = [UIFont systemFontOfSize:14*matchW];
    nameL.textColor = [UIColor colorWithRed:(0x4f)/255.0 green:(0x4f)/255.0 blue:(0x4f)/255.0 alpha:1];
    [_resultV addSubview:nameL];
    
    UIView *fillV1 = [[UIView alloc]initWithFrame:CGRectMake(12*matchW, CGRectGetMaxY(nameL.frame), self.frame.size.width, 1)];
    fillV1.backgroundColor = [UIColor colorWithRed:(0xc9)/255.0 green:(0xc9)/255.0 blue:(0xc9)/255.0 alpha:1];
    [_resultV addSubview:fillV1];
    
    for (int i = 0; i <= cunt; i ++) {
        UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_albumBtn.frame),42*matchH+ i*42*matchH, (self.frame.size.width-CGRectGetMinX(_albumBtn.frame)*2)/2, 42*matchH)];
        if (i == 0) {
            nameL.text = @"名称";
        }else{
            NSDictionary *ddic = resultArr[i-1];
            nameL.text = [NSString stringWithFormat:@"%@",ddic[@"tag"]];
        }
        nameL.tag = i;
        nameL.textAlignment = NSTextAlignmentLeft;
        nameL.font = [UIFont systemFontOfSize:14*matchW];
        nameL.textColor = [UIColor colorWithRed:(0x5c)/255.0 green:(0x5c)/255.0 blue:(0x5c)/255.0 alpha:1];
        [_resultV addSubview:nameL];
        
        UILabel *levelL = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2+CGRectGetMinX(_albumBtn.frame), 42*matchH+ i*42*matchH, CGRectGetWidth(nameL.frame), CGRectGetHeight(nameL.frame))];
        if (i == 0) {
            levelL.text = @"置信度";
        }else{
            NSDictionary *ddic = resultArr[i-1];
            levelL.text = [NSString stringWithFormat:@"%@",ddic[@"confidence"]];
        }
        levelL.tag = i+50;
        levelL.textAlignment = NSTextAlignmentLeft;
        levelL.font = [UIFont systemFontOfSize:14*matchW];
        levelL.textColor = [UIColor colorWithRed:(0x5c)/255.0 green:(0x5c)/255.0 blue:(0x5c)/255.0 alpha:1];
        [_resultV addSubview:levelL];
        
        if (i != cunt) {
            UIView *fillV = [[UIView alloc]initWithFrame:CGRectMake(12*matchW, CGRectGetMaxY(nameL.frame), self.frame.size.width, 1)];
            fillV.backgroundColor = [UIColor colorWithRed:(0xc9)/255.0 green:(0xc9)/255.0 blue:(0xc9)/255.0 alpha:1];
            [_resultV addSubview:fillV];
        }
    }
    
    self.jsonv = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_resultV.frame)+15*matchH, self.frame.size.width, (42+600)*matchH)];
    _jsonv.backgroundColor = [UIColor whiteColor];
    [_scrollV addSubview:_jsonv];
    
    UILabel *jsonL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_albumBtn.frame), 0, 300*matchW, 42*matchH)];
    jsonL.text = @"RESPONSE JSON";
    jsonL.font = [UIFont systemFontOfSize:14*matchW];
    jsonL.textColor = [UIColor colorWithRed:(0x5c)/255.0 green:(0x5c)/255.0 blue:(0x5c)/255.0 alpha:1];
    [_jsonv addSubview:jsonL];
    
    UIView *fillV = [[UIView alloc]initWithFrame:CGRectMake(12*matchW, CGRectGetMaxY(jsonL.frame), self.frame.size.width, 1)];
    fillV.backgroundColor = [UIColor colorWithRed:(0xc9)/255.0 green:(0xc9)/255.0 blue:(0xc9)/255.0 alpha:1];
    [_jsonv addSubview:fillV];
    
    self.jsonTextView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(jsonL.frame), CGRectGetMaxY(jsonL.frame)+15*matchH, self.frame.size.width-CGRectGetMinX(jsonL.frame), 500*matchH)];
    self.jsonTextView.textColor = [UIColor colorWithRed:(0x5c)/255.0 green:(0x5c)/255.0 blue:(0x5c)/255.0 alpha:1];
    _jsonTextView.editable = NO;
    [_jsonv addSubview:_jsonTextView];
}


- (void)setUpResultView{
    self.resultV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_albumBtn.frame) - 5*matchH, self.frame.size.width, 42*5*matchH)];
    _resultV.backgroundColor = [UIColor whiteColor];
    [_scrollV addSubview:_resultV];
    
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_albumBtn.frame), 0, (self.frame.size.width-CGRectGetMinX(_albumBtn.frame)*2)/2, 42*matchH)];
    nameL.text = @"识别结果";
    nameL.textAlignment = NSTextAlignmentLeft;
    nameL.font = [UIFont systemFontOfSize:14*matchW];
    nameL.textColor = [UIColor colorWithRed:(0x4f)/255.0 green:(0x4f)/255.0 blue:(0x4f)/255.0 alpha:1];
    [_resultV addSubview:nameL];
    
    UIView *fillV1 = [[UIView alloc]initWithFrame:CGRectMake(12*matchW, CGRectGetMaxY(nameL.frame), self.frame.size.width, 1)];
    fillV1.backgroundColor = [UIColor colorWithRed:(0xc9)/255.0 green:(0xc9)/255.0 blue:(0xc9)/255.0 alpha:1];
    [_resultV addSubview:fillV1];
    
    for (int i = 0; i <= 3; i ++) {
        UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_albumBtn.frame),42*matchH+ i*42*matchH, (self.frame.size.width-CGRectGetMinX(_albumBtn.frame)*2)/2, 42*matchH)];
        if (i == 0) {
            nameL.text = @"名称";
        }else if(i == 1){
            nameL.text = @"---";
        }
        nameL.tag = i;
        nameL.textAlignment = NSTextAlignmentLeft;
        nameL.font = [UIFont systemFontOfSize:14*matchW];
        nameL.textColor = [UIColor colorWithRed:(0x5c)/255.0 green:(0x5c)/255.0 blue:(0x5c)/255.0 alpha:1];
        [_resultV addSubview:nameL];
        
        UILabel *levelL = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2+CGRectGetMinX(_albumBtn.frame), 42*matchH+ i*42*matchH, CGRectGetWidth(nameL.frame), CGRectGetHeight(nameL.frame))];
        if (i == 0) {
            levelL.text = @"置信度";
        }else if(i == 1){
            levelL.text = @"---";
        }
        levelL.tag = i+50;
        levelL.textAlignment = NSTextAlignmentLeft;
        levelL.font = [UIFont systemFontOfSize:14*matchW];
        levelL.textColor = [UIColor colorWithRed:(0x5c)/255.0 green:(0x5c)/255.0 blue:(0x5c)/255.0 alpha:1];
        [_resultV addSubview:levelL];
        
        if (i != 4) {
            UIView *fillV = [[UIView alloc]initWithFrame:CGRectMake(12*matchW, CGRectGetMaxY(nameL.frame), self.frame.size.width, 1)];
            fillV.backgroundColor = [UIColor colorWithRed:(0xc9)/255.0 green:(0xc9)/255.0 blue:(0xc9)/255.0 alpha:1];
            [_resultV addSubview:fillV];
        }
    }
    
    UIView *jsonv = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_resultV.frame)+15*matchH, self.frame.size.width, (42+600)*matchH)];
    jsonv.backgroundColor = [UIColor whiteColor];
    [_scrollV addSubview:jsonv];
    
    UILabel *jsonL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_albumBtn.frame), 0, 300*matchW, 42*matchH)];
    jsonL.text = @"RESPONSE JSON";
    jsonL.font = [UIFont systemFontOfSize:14*matchW];
    jsonL.textColor = [UIColor colorWithRed:(0x5c)/255.0 green:(0x5c)/255.0 blue:(0x5c)/255.0 alpha:1];
    [jsonv addSubview:jsonL];
    
    UIView *fillV = [[UIView alloc]initWithFrame:CGRectMake(12*matchW, CGRectGetMaxY(jsonL.frame), self.frame.size.width, 1)];
    fillV.backgroundColor = [UIColor colorWithRed:(0xc9)/255.0 green:(0xc9)/255.0 blue:(0xc9)/255.0 alpha:1];
    [jsonv addSubview:fillV];
    
    self.jsonTextView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(jsonL.frame), CGRectGetMaxY(jsonL.frame)+15*matchH, self.frame.size.width-CGRectGetMinX(jsonL.frame), 500*matchH)];
    self.jsonTextView.textColor = [UIColor colorWithRed:(0x5c)/255.0 green:(0x5c)/255.0 blue:(0x5c)/255.0 alpha:1];
    [jsonv addSubview:_jsonTextView];
}

@end
