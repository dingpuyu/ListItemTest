//
//  ListItemView.m
//  ListItemTest
//
//  Created by xiaotei's on 15/11/11.
//  Copyright © 2015年 xiaotei's. All rights reserved.
//

#import "ListItemView.h"


#define ItemRowNumber

@interface ListItemView()

//删除按钮，默认隐藏，在长按抖动后出现
@property (nonatomic,weak)UIButton* deleteBtn;

@property (nonatomic,strong)ListItemModel* model;

@property (nonatomic,weak)UILabel* titleLabel;

@end


@implementation ListItemView

+(instancetype)itemViewWithModel:(ListItemModel *)model{
    return [[self alloc]initWithItemModel:model];
}

-(instancetype)initWithItemModel:(ListItemModel *)model{
    if (self = [super init]) {
        _model = model;
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
        //        longPress.minimumPressDuration = 1.0;
        [self addGestureRecognizer:longPress];
    }
    return self;
}



-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self];
        
        NSLog(@"%@",NSStringFromCGPoint(point));
        
//        [self startAnimation];
//        发生了长按event
        if ([_delegate respondsToSelector:@selector(listItemView:longPress:)]) {
            [_delegate listItemView:self longPress:NO];
        }
        
        
        
        /**
         *  为item添加通知，在应用进入后台后，取消动画
         */
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
//    self.frame = newSuperview.bounds;
    self.backgroundColor = [UIColor lightGrayColor];
    

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    
}

-(void)applicationDidEnterBackground:(NSNotification*)notif{
    [self stopAnimation];
    NSLog(@"去往后台");
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0,0, self.frame.size.width, self.frame.size.height);

}


-(void)startAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-0.05, 0, 0, 1.0)];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.05, 0, 0, 1.0)];
    animation.autoreverses = YES;
    animation.duration = 0.12;
    animation.repeatCount = MAXFLOAT;
    animation.delegate = self;
    self.deleteBtn.hidden = NO;
    [[self layer] addAnimation:animation forKey:@"wiggleAnimation"];
}

-(void)stopAnimation{
    self.deleteBtn.hidden = YES;
    [[self layer] removeAnimationForKey:@"wiggleAnimation"];
}

#pragma mark - getter
-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        UIButton* btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(0, 0, 25, 25);
        [self addSubview:btn];
        [btn setBackgroundColor:[UIColor redColor]];
        _deleteBtn = btn;
        [btn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

-(void)deleteBtnClick:(UIButton*)btn{
//    [self removeFromSuperview];
//    NSLog(@"button did deleted");
//    点击了删除按钮，告诉它的代理
    if ([_delegate respondsToSelector:@selector(listItemView:touchDeleteBtn:)]) {
        [_delegate listItemView:self touchDeleteBtn:_model];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel* label = [[UILabel alloc]init];
        label.text = _model.itemTitle;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
