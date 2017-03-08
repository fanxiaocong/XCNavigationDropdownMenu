//
//  ViewController.m
//  XCNavigationDropdownMenuExample
//
//  Created by 樊小聪 on 2017/3/7.
//  Copyright © 2017年 樊小聪. All rights reserved.
//

#import "ViewController.h"

#import "XCNavigationDropdownMenu.h"

@interface ViewController () <XCNavigationDropdownMenuDataSource, XCNavigationDropdownMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置 UI
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor orangeColor];
    
    XCNavigationDropdownMenu *menu = [[XCNavigationDropdownMenu alloc] initWithNavigationController:self.navigationController];
    
    [menu setTitle:@"全部数据" forState:UIControlStateNormal];
    [menu setImage:[UIImage imageNamed:@"icon_down_gn"] forState:UIControlStateNormal];
    
    menu.dataSource = self;
    menu.delegate   = self;
    
    self.navigationItem.titleView = menu;
}

#pragma mark - 📕 👀 XCNavigationDropdownMenuDataSource 👀

- (NSArray<NSString *> *)titleArrayForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu
{
    return @[@"全部订单",  @"测试数据-", @"测试数据二", @"测试数据三", @"测试数据四",
             @"测试数据五", @"测试数据六", @"测试数据七", @"测试数据八",
             @"测试数据九", @"测试数据十", @"测试数据十一", @"测试数据十二",
             @"测试数据十三", @"测试数据十四", @"测试数据十五", @"测试数据十六",
             @"测试数据十七", @"测试数据十八", @"测试数据十九", @"测试数据二十"];
}

/**
 *  下拉菜单每一行选中状态下的背景颜色；默认为：空
 */
- (UIColor *)cellSelectionTextColorForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu
{
    return [UIColor orangeColor];
}

#pragma mark - 💉 👀 XCNavigationDropdownMenuDelegate 👀

- (void)navigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu didSelectRowAtIndex:(NSUInteger)index
{
//    [navigationDropdownMenu reloadData];
}


@end














