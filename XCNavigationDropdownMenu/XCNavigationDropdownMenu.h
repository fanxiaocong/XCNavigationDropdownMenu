
/**
 *     类名：       NavigationDropdownMenu.h
 *
 *     工程名称：   XCNavigationDropdownMenu
 *
 *     创建人：     樊小聪
 *
 *     创建时间：   16/8/29
 */


/**
 *     备注：导航栏下拉菜单
 */

#import <UIKit/UIKit.h>


@interface XCCustomButton : UIButton
@end

/* 🐖 ******************* 🐖 XCNavigationDropdownMenuDataSource 🐖 *******************  🐖 */


@class XCNavigationDropdownMenu;

@protocol XCNavigationDropdownMenuDataSource <NSObject>

@required
/**
 *  返回每一行对应的标题
 */
- (NSArray<NSString *> *)titleArrayForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

@optional
/**
 *  下拉菜单的标题字体的大小；默认为 17号字体
 */
- (UIFont *)titleFontForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *  下拉菜单的标题的字体颜色；默认为 黑色
 */
- (UIColor *)titleColorForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *  标题右侧的图片；默认没有
 *
 */
- (UIImage *)arrowImageForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *  动画执行的时间；默认为 0.25
 */
- (NSTimeInterval)animationDurationForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *  下拉菜单每行的高度；默认为 45
 */
- (CGFloat)cellHeightForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *  下拉菜单每行的分隔线的 insets；默认为 ：UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
 */
- (UIEdgeInsets)cellSeparatorInsetsForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *  下拉菜单每行文字的对齐方式；默认为：NSTextAlignmentCenter
 */
- (NSTextAlignment)cellTextAlignmentForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *  下拉菜单每行文字的字体的大小；默认为： [UIFont systemFontOfSize:16.0]
 */
- (UIFont *)cellTextFontForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *  下拉菜单每行文字的颜色；默认为：黑色
 */
- (UIColor *)cellTextColorForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *   下拉菜单每行文字选中状态下的颜色；默认为：黑色
 */
- (UIColor *)cellSelectionTextColorForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;


/**
 *  下拉菜单每一行未选中状态下的背景颜色；默认为：白色
 */
- (UIColor *)cellBackgroundColorForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *  下拉菜单每一行选中状态下的背景颜色；默认为：空
 */
- (UIColor *)cellSelectionBackgroundColorForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

/**
 *  下拉菜单的 footerView；默认为 空
 */
- (UIView *)footerViewForNavigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu;

@end

/* 🐖 ******************* 🐖 XCNavigationDropdownMenuDelegate 🐖 *******************  🐖 */

@protocol XCNavigationDropdownMenuDelegate <NSObject>

@required
- (void)navigationDropdownMenu:(XCNavigationDropdownMenu *)navigationDropdownMenu didSelectRowAtIndex:(NSUInteger)index;

@end


/* 🐖 ******************* 🐖 XCNavigationDropdownMenu 🐖 ******************* 🐖 */


@interface XCNavigationDropdownMenu : XCCustomButton

@property (nonatomic, weak) id <XCNavigationDropdownMenuDataSource> dataSource;
@property (nonatomic, weak) id <XCNavigationDropdownMenuDelegate> delegate;

/**
 *  根据一个导航控制器生成一个下拉菜单
 *
 *  @param navigationController 导航控制器
 */
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;


/**
 刷新数据
 */
- (void)reloadData;

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

@end
