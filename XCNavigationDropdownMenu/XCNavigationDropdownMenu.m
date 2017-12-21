
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖保佑             永无BUG
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//


/**
 *     类名：       NavigationDropdownMenu.m
 *
 *     工程名称：   轮播图下拉放大
 *
 *     创建人：     樊小聪
 *
 *     创建时间：   16/8/29
 */


/**
 *     备注：导航栏下拉菜单
 */

#import "XCNavigationDropdownMenu.h"

#import "UIColor+XCExtension.h"
#import "UIView+XCExtension.h"


#define IMG_WIDTH 6
#define MARGIN 5
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width


// cell 分隔线的颜色
#define CELL_SEPRATOR_COLOR         [UIColor colorWithHexString:@"e2e2e2"]


@implementation XCCustomButton

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat textW = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width;   // 文字宽度
    CGFloat imgW = IMG_WIDTH;           // 图片宽度
    CGFloat marginX = MARGIN;           // 图片与文字的间隙
    
    self.titleLabel.left = (self.width - (textW + imgW + marginX)) * 0.5;
    self.imageView.left  = CGRectGetMaxX(self.titleLabel.frame) + 5;
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end



/* 🐖 ******************* 🐖 XCNavigationDropdownMenuDataSource 🐖 *******************  🐖 */


@interface XCNavigationDropdownMenu () <UITableViewDataSource, UITableViewDelegate>

/** 👀 导航控制器 👀 */
@property (weak, nonatomic) UINavigationController *navVC;

/** 👀 下拉的tableView 👀 */
@property (strong, nonatomic) UITableView *menuTableView;

/** 👀 头部视图 👀 */
@property (strong, nonatomic) UIView *menuHeaderView;

/** 👀 背景视图 👀 */
@property (strong, nonatomic) UIView *menuBackgroundView;

@property (assign, nonatomic) NSInteger selectedIndex;

@end

@implementation XCNavigationDropdownMenu

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

#pragma mark - ⏳ 👀 LifeCycle Method 👀

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    self = [XCNavigationDropdownMenu buttonWithType:UIButtonTypeCustom];
    
    if (self)
    {
        self.frame = navigationController.navigationItem.titleView.frame;
        self.navVC = navigationController;
    }
    
    return self;
}

#pragma mark Layout method

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect menuHeaderViewFrame = self.menuHeaderView.frame;
    menuHeaderViewFrame.size.width = CGRectGetWidth(self.navVC.navigationBar.frame);
    menuHeaderViewFrame.size.height = self.cellHeight;
    self.menuHeaderView.frame = menuHeaderViewFrame;
    CGRect menuBackgroundViewFrame = [UIScreen mainScreen].bounds;
    menuBackgroundViewFrame.origin.y += CGRectGetMaxY(self.navVC.navigationBar.frame);
    menuBackgroundViewFrame.size.height -= CGRectGetMaxY(self.navVC.navigationBar.frame);
    self.menuBackgroundView.frame = menuBackgroundViewFrame;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

#pragma mark - 💤 👀 LazyLoad Method 👀

- (UITableView *)menuTableView
{
    if (_menuTableView == nil)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.menuBackgroundView.bounds style:UITableViewStylePlain];
        _menuTableView = tableView;
        _menuTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _menuTableView.dataSource = self;
        _menuTableView.delegate   = self;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _menuTableView.separatorColor = CELL_SEPRATOR_COLOR;
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.titleArray.count * self.cellHeight - 64)];
        if (self.footerView)
        {
            [_menuTableView.tableFooterView addSubview:self.footerView];
        }
        
        [_menuTableView.tableFooterView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
  
        [_menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self.menuBackgroundView addSubview:_menuTableView];
    }
    return _menuTableView;
}

- (UIView *)menuHeaderView
{
    if (_menuHeaderView == nil)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
        _menuHeaderView = headerView;
        _menuHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _menuHeaderView.backgroundColor =  self.cellBackgroundColor;
        [self.menuBackgroundView addSubview:_menuHeaderView];
    }
    return _menuHeaderView;
}

- (UIView *)menuBackgroundView
{
    if (_menuBackgroundView == nil)
    {
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _menuBackgroundView = backgroundView;
        _menuBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _menuBackgroundView.clipsToBounds = YES;
        _menuBackgroundView.alpha = 0.0;
        _menuBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    }
    return _menuBackgroundView;
}

#pragma mark - 👀 Getter Method 👀 💤

- (NSArray<NSString *> *)titleArray
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleArrayForNavigationDropdownMenu:)])
    {
        return [self.dataSource titleArrayForNavigationDropdownMenu:self];
    }
    else
    {
        return nil;
    }
}

- (UIFont *)titleFont
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleFontForNavigationDropdownMenu:)])
    {
        return [self.dataSource titleFontForNavigationDropdownMenu:self];
    }
    else
    {
        return [UIFont systemFontOfSize:17.0];
    }
}

- (UIColor *)titleColor
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleColorForNavigationDropdownMenu:)])
    {
        return [self.dataSource titleColorForNavigationDropdownMenu:self];
    }
    else
    {
        return [UIColor blackColor];
    }
}

- (UIImage *)arrowImage
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(arrowImageForNavigationDropdownMenu:)])
    {
        return [self.dataSource arrowImageForNavigationDropdownMenu:self];
    }
    else
    {
        return nil;
    }
}

- (NSTimeInterval)animationDuration
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(animationDurationForNavigationDropdownMenu:)])
    {
        return [self.dataSource animationDurationForNavigationDropdownMenu:self];
    }
    else
    {
        return 0.25;
    }
}

- (CGFloat)cellHeight
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(cellHeightForNavigationDropdownMenu:)])
    {
        return [self.dataSource cellHeightForNavigationDropdownMenu:self];
    }
    else
    {
        return 45.0;
    }
}

- (UIEdgeInsets)cellSeparatorInsets
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(cellSeparatorInsetsForNavigationDropdownMenu:)])
    {
        return [self.dataSource cellSeparatorInsetsForNavigationDropdownMenu:self];
    }
    else
    {
        return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    }
}

- (NSTextAlignment)cellTextAlignment
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(cellTextAlignmentForNavigationDropdownMenu:)])
    {
        return [self.dataSource cellTextAlignmentForNavigationDropdownMenu:self];
    }
    else
    {
        return NSTextAlignmentCenter;
    }
}

- (UIFont *)cellTextFont
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(cellTextFontForNavigationDropdownMenu:)])
    {
        return [self.dataSource cellTextFontForNavigationDropdownMenu:self];
    }
    else
    {
        return [UIFont systemFontOfSize:16.0];
    }
}

- (UIColor *)cellTextColor
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(cellTextColorForNavigationDropdownMenu:)])
    {
        return [self.dataSource cellTextColorForNavigationDropdownMenu:self];
    }
    else
    {
        return [UIColor blackColor];
    }
}

- (UIColor *)cellSelectedTextColor
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(cellSelectionTextColorForNavigationDropdownMenu:)])
    {
        return [self.dataSource cellSelectionTextColorForNavigationDropdownMenu:self];
    }
    else
    {
        return [UIColor blackColor];
    }
}

- (UIColor *)cellBackgroundColor
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(cellBackgroundColorForNavigationDropdownMenu:)])
    {
        return [self.dataSource cellBackgroundColorForNavigationDropdownMenu:self];
    }
    else
    {
        return [UIColor whiteColor];
    }
}

- (UIColor *)cellSelectedColor
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(cellSelectionBackgroundColorForNavigationDropdownMenu:)])
    {
        return [self.dataSource cellSelectionBackgroundColorForNavigationDropdownMenu:self];
    }
    else
    {
        return nil;
    }
}

- (UIView *)footerView
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(footerViewForNavigationDropdownMenu:)])
    {
        return [self.dataSource footerViewForNavigationDropdownMenu:self];
    }
    else
    {
        return nil;
    }
}

#pragma mark - 👀 Setter Method 👀 💤

- (void)setDataSource:(id<XCNavigationDropdownMenuDataSource>)dataSource
{
    _dataSource = dataSource;
    [self setTitle:self.titleArray.firstObject forState:UIControlStateNormal];
}

- (void)setDelegate:(id<XCNavigationDropdownMenuDelegate>)delegate
{
    _delegate = delegate;
    if ([delegate respondsToSelector:@selector(navigationDropdownMenu:didSelectRowAtIndex:)])
    {
        [self addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:self.animationDuration animations:^{
        
        if (selected)
        {
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
        else
        {
            self.imageView.transform = CGAffineTransformMakeRotation(0.0);
        }
        
    } completion:^(BOOL finished) {
        
        self.userInteractionEnabled = YES;
    }];
}

#pragma mark - 🎬 👀 Action Method 👀

- (void)menuAction:(XCNavigationDropdownMenu *)sender
{
    self.isSelected ? [self hide] : [self show];
}


#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.dataSource titleArrayForNavigationDropdownMenu:self][indexPath.row];
    cell.textLabel.font = self.cellTextFont;
    cell.textLabel.textColor     = self.cellTextColor;
    cell.textLabel.textAlignment = self.cellTextAlignment;
    cell.backgroundColor = self.cellBackgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.selectedIndex == indexPath.row)
    {
        cell.textLabel.textColor = self.cellSelectedTextColor;
        
        if (self.cellSelectedColor)
        {
            cell.backgroundColor = self.cellSelectedColor;
        }
    }
    
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

// 设置分隔线的样式
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:self.cellSeparatorInsets];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:self.cellSeparatorInsets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:self.cellSeparatorInsets];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hide];
    
    if (self.selectedIndex == indexPath.row)
    {
        return;
    }
    
    self.selectedIndex = indexPath.row;
    
    [tableView reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationDropdownMenu:didSelectRowAtIndex:)])
    {
        [self.delegate navigationDropdownMenu:self didSelectRowAtIndex:indexPath.row];
    }
    
    [self setTitle:self.titleArray[indexPath.row] forState:UIControlStateNormal];
}

#pragma mark - 💉 👀 UISCrollViewDelegate 👀

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect menuHeaderViewFrame = self.menuHeaderView.frame;
    menuHeaderViewFrame.size.height = MAX(0.0, self.cellHeight-scrollView.contentOffset.y);
    self.menuHeaderView.frame = menuHeaderViewFrame;
}


#pragma mark - 🔓 👀 Public Method 👀

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.menuBackgroundView];
    CGRect menuTableViewFrame = self.menuTableView.frame;
    menuTableViewFrame.origin.y = -(MIN(self.titleArray.count * self.cellHeight, CGRectGetHeight(self.menuBackgroundView.frame)));
    self.menuTableView.frame = menuTableViewFrame;
    self.selected = YES;
    
    CALayer *topSepratorLine = [CALayer layer];
    topSepratorLine.frame = CGRectMake(0, 0, SCREEN_WIDTH, .5f);
    topSepratorLine.backgroundColor = CELL_SEPRATOR_COLOR.CGColor;
    [self.menuBackgroundView.layer addSublayer:topSepratorLine];
    
    [self.titleLabel setFont:self.titleFont];
    [self setTitleColor:self.titleColor forState:UIControlStateNormal];
    
    if (self.arrowImage)
    {
        [self setImage:self.arrowImage forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:self.animationDuration * 1.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:kNilOptions animations:^{
        
        CGRect menuTableViewFrame = self.menuTableView.frame;
        menuTableViewFrame.origin.y = 0.0;
        self.menuTableView.frame = menuTableViewFrame;
        self.menuBackgroundView.alpha = 1.0;
        
    } completion:nil];
}

- (void)hide
{
    self.selected = NO;
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        
        CGRect menuTableViewFrame = self.menuTableView.frame;
        menuTableViewFrame.origin.y = -(MIN(self.titleArray.count * self.cellHeight, CGRectGetHeight(self.menuBackgroundView.frame)));
        self.menuTableView.frame = menuTableViewFrame;
        self.menuBackgroundView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self.menuBackgroundView removeFromSuperview];
    }];
}

/**
 刷新数据
 */
- (void)reloadData
{
    [self.menuTableView reloadData];
}

@end




