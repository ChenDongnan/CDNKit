//
//  CDNDropDownMenu.h
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/11/16.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//  下拉刷新组件

#import <UIKit/UIKit.h>
@class CDNDropDownMenu;

@protocol CDNDropDownMenuDelegate<NSObject>
@optional
/** 点击某个筛选小按钮回调，indexPath的Section组是按顶部按钮分的，点击一个按钮下来的下拉菜单属于一组 */
- (void)menu:(CDNDropDownMenu *)menu didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
/** 蒙版将要展示 */
- (void)menu:(CDNDropDownMenu *)menu coverWillDisplay:(UIView *)cover;
/** 蒙版将要隐藏 */
- (void)menu:(CDNDropDownMenu *)menu coverWillHide:(UIView *)cover;

@end


@protocol CDNDropDownMenuDataSource <NSObject>
@required
- (NSInteger)numberOfSectionsInMenu:(CDNDropDownMenu *)menu;
- (NSInteger)menu:(CDNDropDownMenu *)menu numberOfColumnInSection:(NSInteger)section;
- (NSInteger)menu:(CDNDropDownMenu *)menu numberOfItemsInSection:(NSInteger)section;
- (NSString *)menu:(CDNDropDownMenu *)menu titleForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)menu:(CDNDropDownMenu *)menu titleForSection:(NSInteger)section;

@optional
- (NSInteger)menu:(CDNDropDownMenu *)menu defaultSelectIndexInSection:(NSInteger)section;
- (UIImage *)menu:(CDNDropDownMenu *)menu titleUpIconForSection:(NSInteger)section;
- (UIImage *)menu:(CDNDropDownMenu *)menu titleDownIconForSection:(NSInteger)section;
@end

@interface CDNDropDownMenu : UIView
@property (nonatomic, weak) id<CDNDropDownMenuDelegate> delegate;
@property (nonatomic, weak) id<CDNDropDownMenuDataSource> dataSource;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, assign) CGFloat topBarHeight;
@property (nonatomic, strong) UIColor *topBarColor;
/** CollectionView四边的间距 */
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
/** 每个item之间的横向距离 */
@property (nonatomic, assign) CGFloat itemMarginX;
/** 每个item之间的纵向距离 */
@property (nonatomic, assign) CGFloat itemMarginY;
/** 每个item的高度 */
@property (nonatomic, assign) CGFloat itemHeight;
/** CollectionView的高度 */
@property (nonatomic, assign) CGFloat maxCollectionViewH;

/** 退出下拉菜单 */
- (void)exitMenu;

- (UIButton *)topButtonAtIndex:(NSInteger)index;

- (void)showCoverWithColor:(UIColor*)coverColor inView:(UIView *)view;

- (void)selectIndexPath:(NSIndexPath*)indexPath;

@end
