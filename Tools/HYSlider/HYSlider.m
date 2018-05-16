//
//  HYSlider.m
//  HYSlider
//
//  Created by heyang on 16/6/3.
//  Copyright © 2016年 heyang. All rights reserved.
//

#import "HYSlider.h"

#define RGB(r,g,b,a)   [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]

@interface HYSlider ()
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *scrollShowTextView;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UILabel *lbl_maxValue;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *scrollShowTextLabel;
@property (nonatomic,strong) UIView *touchView;
@property (nonatomic) CGFloat hyMaxValue;

@end
@implementation HYSlider



- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setCurrentSliderValue:(CGFloat)currentSliderValue
{
    _currentSliderValue = currentSliderValue;
    
    _leftView.frame = CGRectMake(0, 0,currentSliderValue / (_hyMaxValue/self.frame.size.width), self.frame.size.height);
    
    if(_textLabel){
        [_textLabel removeFromSuperview];
    }
    
    _textLabel = [[UILabel alloc]initWithFrame: CGRectMake(self.leftView.frame.size.width - 32, 0, 30, self.frame.size.height)];
    _textLabel.textColor = RGB(255, 255, 255, 1);
    _textLabel.font = [UIFont systemFontOfSize:9.0];
    [_textLabel setTextAlignment:NSTextAlignmentRight];
    [self.leftView addSubview:_textLabel];
    
    int munite = currentSliderValue/60;
    int second = (int)currentSliderValue%60;
    if(munite>0){
        self.textLabel.text = [NSString stringWithFormat:@"%d:%d",munite,second];
    }else{
        self.textLabel.text = [NSString stringWithFormat:@"0:%d",second];
    }
    
    _touchView.center = CGPointMake(self.leftView.frame.size.width, _textLabel.center.y);
}

-(void)setShowTouchView:(BOOL)showTouchView{
    _showTouchView = showTouchView;
    if(_showTouchView){
        _touchView .frame = CGRectMake(0, 0, self.frame.size.height + 10, self.frame.size.height + 10);
        _touchView.center = CGPointMake(0, _textLabel.center.y);
    }
}

-(void)setMaxValue:(CGFloat)maxValue{
    _hyMaxValue = maxValue;
    int munite = _hyMaxValue/60;
    int second = (int)_hyMaxValue%60;
    if(munite>0){
        _lbl_maxValue.text = [NSString stringWithFormat:@"%d:%d",munite,second];
    }else{
        _lbl_maxValue.text = [NSString stringWithFormat:@"0:%d",second];
    }
}

-(void)setCurrentValueColor:(UIColor *)currentValueColor{
    
    self.leftView.backgroundColor = currentValueColor;
}

-(void)setShowTextColor:(UIColor *)showTextColor
{
    _textLabel.textColor = showTextColor;
    _scrollShowTextLabel.textColor = showTextColor;
}

-(void)setTouchViewColor:(UIColor *)touchViewColor{
    _touchView.backgroundColor = touchViewColor;
}


- (void)setShowScrollTextView:(BOOL)showScrollTextView
{
    
    _showScrollTextView = showScrollTextView;
    
    self.scrollShowTextView.hidden = !showScrollTextView;
    self.scrollShowTextView.frame = CGRectMake((self.touchView.frame.origin.x)>= 0 ? (self.touchView.frame.origin.x):(0) ,- 48, 36, 43);
    self.scrollShowTextLabel.text = [NSString stringWithFormat:@"%.f",self.currentSliderValue];
}

- (void)setup{
    
//    self.layer.cornerRadius = self.frame.size.height/2;
    self.backgroundColor = RGB(37, 112, 255, 0.5);
    
    //总时间和时间图片
    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-40, 2, 8, 8)];
    [imgv setImage:[UIImage imageNamed:@"icon_shijian.png"]];
    [self addSubview:imgv];
    
    _lbl_maxValue = [[UILabel alloc]initWithFrame: CGRectMake(self.frame.size.width - 30, 1, 25, self.frame.size.height)];
    _lbl_maxValue.textColor = RGB(255, 255, 255, 1);
    _lbl_maxValue.font = [UIFont systemFontOfSize:9.0];
    _lbl_maxValue.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_lbl_maxValue];
    
    /** 显示文字label*/
    _textLabel = [[UILabel alloc]init];
    _textLabel.textColor = RGB(38, 38, 38, 1);
    _textLabel.font = [UIFont systemFontOfSize:9.0];
    _textLabel.textAlignment = NSTextAlignmentRight;
    [self.leftView addSubview:_textLabel];
    
    /** 数值视图*/
    _leftView = [[UIView alloc]init];
    [self addSubview:_leftView];
    
    _scrollShowTextView  = [[UIView alloc]init];
    _scrollShowTextView.hidden = YES;
    _scrollShowTextView.backgroundColor = [UIColor clearColor];
    [self addSubview:_scrollShowTextView];
    
    
    /** 浮标image*/
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,36,43)];
    _imageView.image = [UIImage imageNamed:@"亮度显示_"];
    
    /** 浮标数值显示label*/
    _scrollShowTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 36, 36)];
    _scrollShowTextLabel.textAlignment = NSTextAlignmentCenter;
    _scrollShowTextLabel.textColor = [UIColor whiteColor];
    _scrollShowTextLabel.font = [UIFont systemFontOfSize:13.0];
//    [_scrollShowTextView addSubview:_scrollShowTextLabel];
    
    
    /** 圆形触摸块*/
    _touchView  = [[UIView alloc]init];
    _touchView.layer.cornerRadius = (self.frame.size.height + 10) /2;
    _touchView.layer.masksToBounds = YES;
    _touchView.layer.borderColor = [UIColor whiteColor].CGColor;
    _touchView.layer.borderWidth = 2.0;
    _touchView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_touchView];
    
    /** 默认最大值*/
    _hyMaxValue = 255.0;
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.scrollShowTextView.hidden = NO;
    UITouch *touch = [touches anyObject];
    
    CGPoint translation = [touch locationInView:self];
    
    
    if((translation.x >=0 && ((_hyMaxValue/self.frame.size.width) * translation.x) <= _hyMaxValue)){
        
        self.leftView.frame           = CGRectMake(0, 0, translation.x, self.frame.size.height);
        self.scrollShowTextView.frame = CGRectMake((translation.x-18)>= 0 ? (translation.x-18):(0) ,- 48, 36, 43);
        self.textLabel .frame             = CGRectMake((self.leftView.frame.size.width - 20) >= 0 ? (self.leftView.frame.size.width - 20):(0) , 0, 20, self.frame.size.height);
        self.textLabel.text           = [NSString stringWithFormat:@"%.f",(_hyMaxValue/self.frame.size.width) * translation.x];
        self.scrollShowTextLabel.text = [NSString stringWithFormat:@"%.f",(_hyMaxValue/self.frame.size.width) * translation.x];
        
        if(_showTouchView){
            _touchView .frame             = CGRectMake(0, 0, self.frame.size.height + 10, self.frame.size.height + 10);
            _touchView.center = CGPointMake(0, _textLabel.center.y);
        }
        
        
        /** delegate*/
        if([self.delegate respondsToSelector:@selector(HYSlider:didScrollValue:)]){
            [self.delegate HYSlider:self didScrollValue:(_hyMaxValue/self.frame.size.width) * translation.x];
        }
    }
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    self.scrollShowTextView.hidden = NO;
    CGPoint translation = [tap locationInView:self];
    
    if((translation.x >=0 && ((_hyMaxValue/self.frame.size.width) * translation.x) <= _hyMaxValue)){
        
        self.leftView.frame           = CGRectMake(0, 0, translation.x, self.frame.size.height);
        self.scrollShowTextView.frame = CGRectMake((translation.x-18)>= 0 ? (translation.x-18):(0) ,- 48, 36, 43);
        self.textLabel .frame         = CGRectMake((self.leftView.frame.size.width - 30) >= 0 ? (self.leftView.frame.size.width - 30):(0) , 0, 30, self.frame.size.height);

        _currentSliderValue = [[NSString stringWithFormat:@"%.f",(_hyMaxValue/self.frame.size.width) * translation.x] intValue];
        int munite = _currentSliderValue/60;
        int second = (int)_currentSliderValue%60;
        if(munite>0){
            self.textLabel.text = [NSString stringWithFormat:@"%d:%d",munite,second];
        }else{
            self.textLabel.text = [NSString stringWithFormat:@"0:%d",second];
        }
        
        self.scrollShowTextLabel.text = [NSString stringWithFormat:@"%.f",(_hyMaxValue/self.frame.size.width) * translation.x];
        
        if(_showTouchView){
            _touchView .frame             = CGRectMake(0, 0, self.frame.size.height + 10, self.frame.size.height + 10);
            _touchView.center = CGPointMake(0, _textLabel.center.y);
        }
        
        /** delegate*/
        if([self.delegate respondsToSelector:@selector(HYSlider:didScrollValue:)]){
            [self.delegate HYSlider:self didScrollValue:(_hyMaxValue/self.frame.size.width) * translation.x];
        }
    }
}


@end
