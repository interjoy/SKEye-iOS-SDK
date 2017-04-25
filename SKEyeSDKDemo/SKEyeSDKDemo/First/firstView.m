//
//  firstView.m
//  SK_ObjectRecognitionDemo
//
//  Created by cdong on 2017/3/24.
//  Copyright © 2017年 DC. All rights reserved.
//

#import "firstView.h"

#define matchW ([[UIScreen mainScreen]bounds].size.width/375)
#define matchH ([[UIScreen mainScreen]bounds].size.height/667)

@implementation firstView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    UIImageView *iconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width*3/4)];
    iconImageV.image = [UIImage imageNamed:@"luke-chesser-2347.jpg"];
    [self addSubview:iconImageV];
    
    UIImageView *logoImgV = [[UIImageView alloc]initWithFrame:CGRectMake(30*matchW, 48*matchH, 73*matchW, 42*matchH)];
    logoImgV.image = [UIImage imageNamed:@"icon_logo"];
    [self addSubview:logoImgV];
    
    self.fruitRecBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _fruitRecBtn.frame = CGRectMake(self.frame.size.width -((self.frame.size.width - 360*matchW)/2+172*matchW), CGRectGetMaxY(iconImageV.frame) + 33*matchH, 172*matchW, 98*matchH);
    [_fruitRecBtn setBackgroundImage:[UIImage imageNamed:@"icon_shuiguoshibie_a"] forState:UIControlStateNormal];
    [_fruitRecBtn setBackgroundImage:[UIImage imageNamed:@"icon_shuiguoshibie_b"] forState:UIControlStateHighlighted];
    [self addSubview:_fruitRecBtn];
    
    self.householdRecBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _householdRecBtn.frame = CGRectMake((self.frame.size.width - 360*matchW)/2, CGRectGetMinY(_fruitRecBtn.frame), CGRectGetWidth(_fruitRecBtn.frame), CGRectGetHeight(_fruitRecBtn.frame));
    [_householdRecBtn setBackgroundImage:[UIImage imageNamed:@"icon_changjianwupin_b"] forState:UIControlStateHighlighted];
    [_householdRecBtn setBackgroundImage:[UIImage imageNamed:@"icon_changjianwupin_a"] forState:UIControlStateNormal];
    [self addSubview:_householdRecBtn];
}

@end
