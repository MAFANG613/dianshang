//
//  DSMFTabbarController.m
//  sxt项目
//
//  Created by MacBook on 16/6/16.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "DSMFTabbarController.h"
#import "DSMFNaviController.h"

//#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface DSMFTabbarController ()

@property (strong, nonatomic) NSArray      *viewControllersArray;

@end

@implementation DSMFTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    NSMutableArray *controllersArray = [NSMutableArray arrayWithCapacity:self.viewControllersArray.count];
    
    [self.viewControllersArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Class viewControllerClass = NSClassFromString(dict[@"ViewController"]);
        
        UIViewController *viewController = [[viewControllerClass alloc] init];
        viewController.title = dict[@"TitleName"];
        
        /*
         imageWithRenderingMode:设置UIImage的渲染模式
         */
        viewController.tabBarItem.selectedImage = [[UIImage imageNamed:dict[@"SelectImage"]]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        viewController.tabBarItem.image = [[UIImage imageNamed:dict[@"NorImage"]] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        
        DSMFNaviController *naviController = [[DSMFNaviController alloc] initWithRootViewController:viewController];
        
        [controllersArray addObject:naviController];
    }];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0],NSForegroundColorAttributeName:[UIColor grayColor]} forState:(UIControlStateNormal)];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],NSForegroundColorAttributeName : RGB(65, 179, 241)} forState:(UIControlStateSelected)];
    
    
    
    self.viewControllers = controllersArray;
    
    self.selectedIndex = 0;
    
}

#pragma mark -
#pragma mark - 懒加载
- (NSArray *)viewControllersArray {
    if (!_viewControllersArray) {
        _viewControllersArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TabBarPlist" ofType:@"plist" ] ];
    }
    return _viewControllersArray;
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
