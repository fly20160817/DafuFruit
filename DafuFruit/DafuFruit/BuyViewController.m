//
//  BuyViewController.m
//  testLogin
//
//  Created by huangzhibiao on 15/12/21.
//  Copyright © 2015年 haiwang. All rights reserved.
//

#import "BuyViewController.h"
#import "global.h"
#import "BuyTopView.h"
#import "BuyMiddleView.h"
#import "BuyBottomView.h"
#import "MyOrderTopTabBar.h"
#import "MJRefresh.h"
#import "NaviBase.h"
#import "ChoseView.h"

#define TopViewH 380
#define MiddleViewH 195
#define BottomH 52
#define TopTabBarH [global pxTopt:100]
#define NaviBarH 64.0

@interface BuyViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,MyOrderTopTabBarDelegate,UITextFieldDelegate,TypeSeleteDelegete>
{
    ChoseView *choseView;
    UIView *bgview;
    CGPoint center;
    NSArray *sizearr;//型号数组
    NSArray *colorarr;//分类数组
    NSDictionary *stockarr;//商品库存量
    int goodsStock;
}

@property(nonatomic,weak)MyOrderTopTabBar* TopTabBar;
@property(nonatomic,weak)UIView* NavBarView;

@property (weak, nonatomic) UIScrollView *MyScrollView;
@property (weak, nonatomic) BuyTopView* topView;
@property (weak, nonatomic) BuyMiddleView* middleView;
@property (weak, nonatomic) BuyBottomView* bottomView;
@property (weak, nonatomic) UITableView* detailTableview;
@property (weak, nonatomic)MJRefreshHeaderView* header;
@property (assign, nonatomic)float TopViewScale;


@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TopViewScale = 1.0;
    [self initView];
    [self addNavBarView];//提示,要在最后添加
//    sizearr = [[NSArray alloc] initWithObjects:@"S",@"M",@"L",nil];
//    colorarr = [[NSArray alloc] initWithObjects:@"蓝色",@"红色",@"湖蓝色",@"咖啡色",nil];
//    NSString *str = [[NSBundle mainBundle] pathForResource: @"stock" ofType:@"plist"];
//    stockarr = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:str]];
    
    [self initBottomView];
}

/**
 添加导航栏背后的View
 */
-(void)addNavBarView{
    UIView* view = [[UIView alloc] init];
    self.NavBarView = view;
    view.frame = CGRectMake(0, 0, screenW, 64.0);
    [self.view addSubview:view];
}
-(void)viewDidDisappear:(BOOL)animated{
    //释放下拉刷新内存
    [self.header free];
    [self.MyScrollView removeFromSuperview];
    [super viewDidDisappear:animated];
}
-(UIScrollView *)MyScrollView{
    if (_MyScrollView == nil) {
        UIScrollView* scroll = [[UIScrollView alloc] init];
        _MyScrollView = scroll;
        scroll.delegate = self;
        scroll.frame = CGRectMake(0.0, 0.0, screenW, screenH-BottomH);
        scroll.pagingEnabled = YES;//进行分页
        scroll.showsVerticalScrollIndicator = NO;
        scroll.tag = 0;
        [self.view addSubview:scroll];
    }
    return _MyScrollView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 隐藏导航栏方法
//    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = NO;
}
/**
 添加底部购买按钮和加入购物车按钮的view
 */
-(void)initBottomView{
    
    
    UIView* view = [[UIView alloc] init];
    view.frame = CGRectMake(0,CGRectGetMaxY(self.MyScrollView.frame), screenW, BottomH);
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat btnW = 100;
    CGFloat btnH = 52;
    CGFloat margin = 3;
    //加入购物车按钮
    CGFloat aX = screenW - btnW;
    UIButton* aBtn = [[UIButton alloc] init];
    aBtn.frame = CGRectMake(aX, 0, btnW, btnH);
    [aBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [aBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    aBtn.backgroundColor = color(250.0, 63.0, 51.0, 1.0);
    [aBtn addTarget:self action:@selector(addShoppingCar:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:aBtn];
    [self initChoseView];
    
    //立即购买按钮
    CGFloat bX = screenW - 2*btnW - margin;
    UIButton* bBtn = [[UIButton alloc] init];
    bBtn.frame = CGRectMake(bX, 0, btnW, btnH);
    [bBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [bBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bBtn.backgroundColor = color(0.0, 162.0, 154.0, 1.0);
    [bBtn addTarget:self action:@selector(nowBuy:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bBtn];

    
    [self.view addSubview:view];
}

-(void)initChoseView
{
    
    
    //选择尺码颜色的视图
    choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:choseView];
    
    //尺码
    choseView.sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, choseView.frame.size.width, 50) andDatasource:sizearr :@"尺码"];
    choseView.sizeView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.sizeView];
    choseView.sizeView.frame = CGRectMake(0, 0, choseView.frame.size.width, choseView.sizeView.height);
    //颜色分类
    choseView.colorView = [[TypeView alloc] initWithFrame:CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, 50) andDatasource:colorarr :@"颜色分类"];
    choseView.colorView.delegate = self;
    [choseView.mainscrollview addSubview:choseView.colorView];
    choseView.colorView.frame = CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, choseView.colorView.height);
    //购买数量
    choseView.countView.frame = CGRectMake(0, choseView.colorView.frame.size.height+choseView.colorView.frame.origin.y, choseView.frame.size.width, 50);
    choseView.mainscrollview.contentSize = CGSizeMake(self.view.frame.size.width, choseView.countView.frame.size.height+choseView.countView.frame.origin.y);
    
    choseView.lb_price.text = @"¥100";
    choseView.lb_stock.text = @"库存100000件";
    choseView.lb_detail.text = @"请选择 尺码 颜色分类";
    [choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [choseView.bt_sure addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [choseView.alphaiView addGestureRecognizer:tap];
    //点击图片放大图片
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    choseView.img.userInteractionEnabled = YES;
    [choseView.img addGestureRecognizer:tap1];
}
/**
 *  此处嵌入浏览图片代码
 */
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"放大图片");
}

/**
 加入购物车按钮点击动作
 */
-(void)addShoppingCar:(id)sender{
    NSLog(@"加入购物车");
    [UIView animateWithDuration: 0.35 animations: ^{
        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
        bgview.center = CGPointMake(self.view.center.x, self.view.center.y-50);
        choseView.center = self.view.center;
        choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion: nil];
}
/**
 立即购买按钮动作
 */
-(void)nowBuy:(id)sender{
     NSLog(@"购买");
}

-(void)dismiss
{
    center.y = center.y+self.view.frame.size.height;
    [UIView animateWithDuration: 0.35 animations: ^{
        choseView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        bgview.center = self.view.center;
    } completion: nil];
    
}
#pragma mark-typedelegete
-(void)btnindex:(int)tag
{
    //通过seletIndex是否>=0来判断尺码和颜色是否被选择，－1则是未选择状态
    if (choseView.sizeView.seletIndex >=0&&choseView.colorView.seletIndex >=0) {
        //尺码和颜色都选择的时候
        NSString *size =[sizearr objectAtIndex:choseView.sizeView.seletIndex];
        NSString *color =[colorarr objectAtIndex:choseView.colorView.seletIndex];
        choseView.lb_stock.text = [NSString stringWithFormat:@"库存%@件",[[stockarr objectForKey: size] objectForKey:color]];
        choseView.lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\" \"%@\"",size,color];
        choseView.stock =[[[stockarr objectForKey: size] objectForKey:color] intValue];
        
        [self reloadTypeBtn:[stockarr objectForKey:size] :colorarr :choseView.colorView];
        [self reloadTypeBtn:[stockarr objectForKey:color] :sizearr :choseView.sizeView];
        NSLog(@"%d",choseView.colorView.seletIndex);
        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
    }else if (choseView.sizeView.seletIndex ==-1&&choseView.colorView.seletIndex == -1)
    {
        //尺码和颜色都没选的时候
        choseView.lb_price.text = @"¥100";
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 尺码 颜色分类";
        choseView.stock = 100000;
        //全部恢复可点击状态
        [self resumeBtn:colorarr :choseView.colorView];
        [self resumeBtn:sizearr :choseView.sizeView];
        
    }else if (choseView.sizeView.seletIndex ==-1&&choseView.colorView.seletIndex >= 0)
    {
        //只选了颜色
        NSString *color =[colorarr objectAtIndex:choseView.colorView.seletIndex];
        //根据所选颜色 取出该颜色对应所有尺码的库存字典
        NSDictionary *dic = [stockarr objectForKey:color];
        [self reloadTypeBtn:dic :sizearr :choseView.sizeView];
        [self resumeBtn:colorarr :choseView.colorView];
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 尺码";
        choseView.stock = 100000;
        
        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
    }else if (choseView.sizeView.seletIndex >= 0&&choseView.colorView.seletIndex == -1)
    {
        //只选了尺码
        NSString *size =[sizearr objectAtIndex:choseView.sizeView.seletIndex];
        //根据所选尺码 取出该尺码对应所有颜色的库存字典
        NSDictionary *dic = [stockarr objectForKey:size];
        [self resumeBtn:sizearr :choseView.sizeView];
        [self reloadTypeBtn:dic :colorarr :choseView.colorView];
        choseView.lb_stock.text = @"库存100000件";
        choseView.lb_detail.text = @"请选择 颜色分类";
        choseView.stock = 100000;
        
        //        for (int i = 0; i<colorarr.count; i++) {
        //            int count = [[dic objectForKey:[colorarr objectAtIndex:i]] intValue];
        //            //遍历颜色字典 库存为零则改尺码按钮不能点击
        //            if (count == 0) {
        //                UIButton *btn =(UIButton *) [choseView.colorView viewWithTag:100+i];
        //                btn.enabled = NO;
        //            }
        //        }
        
    }
}
//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}
//根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
-(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i<arr.count; i++) {
        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        //库存为零 不可点击
        if (count == 0) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        }else
        {
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:0];
        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}

/**
 初始化相关的view
 */
-(void)initView{
    //初始化第一个页面
    //初始化第一个页面的父亲view
    UIView* firstPageView = [[UIView alloc] init];
    firstPageView.frame = CGRectMake(0, 0, screenW, screenH - BottomH);
    BuyTopView* topView = [BuyTopView view];
    self.topView = topView;
    topView.frame = CGRectMake(0,0, screenW, TopViewH);
    [firstPageView addSubview:topView];
    BuyMiddleView* middleView = [BuyMiddleView view];
    self.middleView = middleView;
    middleView.frame = CGRectMake(0,CGRectGetMaxY(topView.frame) + 6, screenW, MiddleViewH);
    [firstPageView addSubview:middleView];
    BuyBottomView* bottomView = [BuyBottomView view];
    self.bottomView = bottomView;
    CGFloat bottomViewY = 0.0;
    if (iphone6plus) {
        bottomViewY = self.MyScrollView.frame.size.height - BottomH;
    }else{
        bottomViewY = CGRectGetMaxY(middleView.frame);
    }
    bottomView.frame = CGRectMake(0,bottomViewY, screenW, BottomH);
    [firstPageView addSubview:bottomView];
    [self.MyScrollView addSubview:firstPageView];
    [self initBottomView];
    //初始化第二个页面
    [self addSecondPageTopTabBar];
    // 设置scrollview内容区域大小
    self.MyScrollView.contentSize = CGSizeMake(screenW, (screenH - BottomH)*2);
}
/**
 添加第二个页面顶部tabBar
 */
-(void)addSecondPageTopTabBar{
    //初始化第二个页面的父亲view
    UIView* secondPageView = [[UIView alloc] init];
    secondPageView.frame = CGRectMake(0, screenH - BottomH, screenW, screenH - BottomH);
    NSArray* array  = @[@"图文详情",@"宝贝评价",@"宝贝咨询"];
    MyOrderTopTabBar* tabBar = [[MyOrderTopTabBar alloc] initWithArray:array] ;
    tabBar.frame = CGRectMake(0,NaviBarH, screenW, TopTabBarH);
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.delegate = self;
    self.TopTabBar = tabBar;
    [secondPageView addSubview:tabBar];
    //初始化一个UITableView
    UITableView* tableview = [[UITableView alloc] init];
    self.detailTableview = tableview;
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.tag = 1;
    tableview.frame = CGRectMake(0, CGRectGetMaxY(tabBar.frame), screenW,secondPageView.frame.size.height - tabBar.frame.size.height-NaviBarH);
    MJRefreshHeaderView* RheaderView = [MJRefreshHeaderView header];
    RheaderView.scrollView = tableview;
    self.header = RheaderView;
    RheaderView.beginRefreshingBlock = ^(MJRefreshBaseView* refreshView){
        NSOperationQueue* Queue = [[NSOperationQueue alloc] init];
        [Queue addOperationWithBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 animations:^{
                    self.MyScrollView.contentOffset = CGPointMake(0, 0);
                } completion:^(BOOL finished) {
                    self.MyScrollView.scrollEnabled = YES;
                }];
                [self.header endRefreshing];
            });
        }];
    };

    [secondPageView addSubview:tableview];
    [self.MyScrollView addSubview:secondPageView];
}
#pragma -- <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@" --== %f",scrollView.contentOffset.y);
    if(scrollView.tag == 0){
        if(scrollView.contentOffset.y<0){
            if(self.TopViewScale<1.01){
                self.TopViewScale += 0.00015f;
                [self.topView.icon_img setTransform:CGAffineTransformScale(self.topView.icon_img.transform, self.TopViewScale, self.TopViewScale)];
            }
            scrollView.contentOffset = CGPointMake(0, 0);
        }else{
            self.NavBarView.backgroundColor = color(0.0,162.0,154.0, scrollView.contentOffset.y/(screenH-BottomH));
        }
        if(scrollView.contentOffset.y == (screenH-BottomH)){
            scrollView.scrollEnabled = NO;
        }else if (scrollView.contentOffset.y == -NaviBarH && !scrollView.isDragging){
            [UIView animateWithDuration:0.3 animations:^{
                scrollView.contentOffset = CGPointMake(0, 0);
            }];
        }else;
    }
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@" endd-- %f",self.TopViewScale);
    self.TopViewScale = 1.0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.topView.icon_img setTransform:CGAffineTransformIdentity];//恢复原来的大小
    }];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //NSLog(@" -- %f",scrollView.contentOffset.y);
}

#pragma -- MyOrderTopTabBarDelegate(顶部标题栏delegate)
-(void)tabBar:(MyOrderTopTabBar *)tabBar didSelectIndex:(NSInteger)index{
    NSLog(@"点击了 －－－ %ld",index);
}
#pragma -- UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
}

#pragma -- UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

@end
