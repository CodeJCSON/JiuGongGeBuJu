//
//  ViewController.m
//  九宫格布局
//
//  Created by 云媒 on 16/10/13.
//  Copyright © 2016年 云媒. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
   NSInteger _ShopIndex;
   UIView *_shops;
   NSTimer *_timer;
}

/* 添加shopsView到跟视图上面 */
@property (nonatomic, strong) UIView *shopsView;
/* 添加按钮 */
@property (nonatomic, strong) UIButton *addBtn;
/* 删除按钮 */
@property (nonatomic, strong) UIButton *removeBtn;
/* 隐藏提示文本 */
@property (nonatomic, strong) UILabel *hudLable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.shopsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.shopsView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_shopsView];
    
     [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(add) userInfo:nil repeats:YES];
}

// 添加按钮
- (UIButton *)addButtonWithImage:(NSString *)image highImage:(NSString *)highImage disableImage:(NSString *)disableImage frame:(CGRect)frame action:(SEL)action{
    // 创建按钮
    UIButton *btn = [[UIButton alloc] init];
    // 设置背景图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:disableImage] forState:UIControlStateDisabled];
    // 设置位置和尺寸
    btn.frame = frame;
    // 监听按钮点击
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    // 添加按钮
    [self.view addSubview:btn];
    return  btn;
}

// 添加九宫格视图
 - (void)add
{
    // 图片索引
    if (_ShopIndex > 5) {
        
        _timer = nil;
        //取消定时器
        [_timer invalidate];
        //停止定时器
        _timer.fireDate = [NSDate distantFuture];
        //开启定时器
        //_timer.fireDate = [NSDate distantPast];
        return;
    }
    
    NSLog(@"添加。。。。%ld",_ShopIndex);
    
    // 计算每次新 view 的位置
    // 每个view 的宽度和高度
    CGFloat viewW = 70;
    CGFloat viewH = 110;
    // 列数，控制显示的列数，可以修改其他值
    NSInteger col = 3;
    // 每个view的索引
    NSInteger index  = self.shopsView.subviews.count;
    // 计算间隔
    CGFloat margin = (self.shopsView.frame.size.width - col*viewW) / (col - 1);
    // 计算xy坐标值
    CGFloat viewX = (index % col ) * (viewW + margin);
    CGFloat viewY = (index / col ) * (viewH + 10);
    
    
    // 创建一个父控件显示图片和文字
    UIView *shopView = [[UIView alloc] init];
    shopView.backgroundColor = [UIColor redColor];
    shopView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    [self.shopsView addSubview:shopView];
    
    // 添加图片
    UIImageView *iconView = [[UIImageView alloc] init];
    //iconView.image = [UIImage imageNamed:_shops[_ShopIndex][@"icon"]];
    iconView.frame = CGRectMake(0, 0, viewW, viewH - 20);
    iconView.backgroundColor = [UIColor blueColor];
    [shopView addSubview:iconView];
    
    // 添加文字
    UILabel *label = [[UILabel alloc] init];
    label.text = @"text";
    label.frame = CGRectMake(0,90, viewW, 20);
    label.font = [UIFont systemFontOfSize:11];
    label.backgroundColor = [UIColor greenColor];
    label.textAlignment = NSTextAlignmentCenter;
    [shopView addSubview:label];
    // 索引自增
    _ShopIndex ++;
    //[self checkBtn];
}

// 删除
 - (void)remove
{
    // 图片索引
    _ShopIndex --;
    //[self checkBtn];
    
    if(_ShopIndex < 0)
    {
        _ShopIndex = 0;
        return ;
    }
    
    NSLog(@"删除。。。。%ld",_ShopIndex);
    // 删除子控件
    [[self.shopsView.subviews lastObject] removeFromSuperview];
 }

// 判断按钮状态，
- (void)checkBtn
{
    // 添加按钮的状态
    //self.addBtn.enabled = (self.shopsView.subviews.count < _shops.count);
    // 删除按钮的状态
    self.removeBtn.enabled = (self.shopsView.subviews.count > 0);
    // 删除完毕
    if(self.removeBtn.enabled == NO )
    {
        self.hudLable.hidden = NO;
        self.hudLable.text = @"商品已经删除完毕！！";
        [self performSelector:@selector(hideHUD) withObject:nil afterDelay:2.0];
    }
    // 添加完毕
    else if (self.addBtn.enabled == NO && _ShopIndex == 6)
    {
        self.hudLable.hidden = NO;
        self.hudLable.text = @"商品已经添加完毕！！";
    }
    // 计时器3
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(hideHUD) userInfo:nil repeats:NO];
}

- (void)hideHUD
{
    // 隐藏 lable
    _hudLable.hidden = YES;
}


@end
