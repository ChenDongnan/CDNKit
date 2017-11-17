//
//  CDNDropDownMenu.m
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/11/16.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#import "CDNDropDownMenu.h"
#import "UIView+CDNKit.h"
#import "CDNDeviceModel.h"
#import "CDNRightImageButton.h"
#import "CDNMacro.h"
#import "Masonry.h"
#import "CDNNoHighlightButton.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface CDNDropDownMenu()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray<UIButton *> *titleBtnArr;
@property (nonatomic, weak)   UIView *topBar;
@property (nonatomic, weak)   UICollectionView *collectionView;


@property (nonatomic, strong) UICollectionViewCell *selectedCell;

@property (nonatomic, strong) NSMutableArray *historyOfSelected;

@property (nonatomic, weak)   UIButton *cover;

@end


@implementation CDNDropDownMenu
static NSInteger const KCellButtonTag = 99;
#pragma mark - lazy
- (NSMutableArray<UIButton *> *)titleBtnArr{
    if (!_titleBtnArr) {
        _titleBtnArr = [NSMutableArray array];
    }
    return _titleBtnArr;
}

#pragma mark - init
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    UIView *bar = [[UIView alloc] init];
    bar.backgroundColor = [UIColor whiteColor];
    [self addSubview:bar];
    self.topBar = bar;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    collection.backgroundColor = [UIColor whiteColor];
    collection.delegate = self;
    collection.dataSource = self;
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [self insertSubview:collection belowSubview:_topBar];
    self.collectionView = collection;
    collection.alpha = 0;
    
    _itemHeight = 32;
    _itemMarginX = 21.5;
    _itemMarginY = 24;
    _topBarHeight = 44;
    _contentEdgeInsets = UIEdgeInsetsMake(16, 16, 16, 16);
    
    _historyOfSelected = [NSMutableArray array];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topBar.frame = CGRectMake(0, 0, self.width, _topBarHeight);
    
    
    CGFloat btnW = self.width/self.titleBtnArr.count;
    [self.titleBtnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.x = btnW * idx;
        obj.y = 0;
        obj.width = btnW;
        obj.height = self.topBar.height;
        
    }];
    
    self.collectionView.x = 0;
    self.collectionView.width = self.width;
}

#pragma mark - setter
- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets{
    _contentEdgeInsets = contentEdgeInsets;
    
    [self layoutIfNeeded];
}

- (void)setTopBarColor:(UIColor *)topBarColor{
    _topBarColor = topBarColor;
    
    _topBar.backgroundColor = topBarColor;
}

- (void)setTopBarHeight:(CGFloat)topBarHeight{
    _topBarHeight = topBarHeight;
    
    [self layoutIfNeeded];
}

- (void)setDataSource:(id<CDNDropDownMenuDataSource>)dataSource{
    _dataSource = dataSource;
    
    UIButton* (^getBtn)(UIImage *up, UIImage *down) = ^(UIImage *up, UIImage *down){
        CDNRightImageButton *btn = [[CDNRightImageButton alloc] init];
        [btn setTitleColor:CDNRGBColor(68, 68, 68, 1) forState:UIControlStateNormal];
        
        /** 适配 5s 屏幕尺寸 */
        if ([CDNDeviceModel is_iPhone4] || [CDNDeviceModel is_iPhone5]) {
            _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
        }
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4);
        [btn setImage:down forState:UIControlStateNormal];
        [btn setImage:up forState:UIControlStateSelected];
        [btn setTitleColor:CDNRGBColor(68, 68, 68, 1) forState:UIControlStateNormal];
        [btn setTitleColor:CDNRGBColor(68, 68, 68, 1) forState:UIControlStateSelected];
        return btn;
    };
    
    NSInteger btnCount = [_dataSource numberOfSectionsInMenu:self];
    
    for (NSInteger i=0; i<btnCount; i++) {
        UIImage *pulldown = [UIImage imageNamed:@"pulldown-2"];
        UIImage *pullup = [UIImage imageNamed:@"pullup-2"];
        if ([_dataSource respondsToSelector:@selector(menu:titleUpIconForSection:)]) {
            pullup = [_dataSource menu:self titleUpIconForSection:i];
        }
        if ([_dataSource respondsToSelector:@selector(menu:titleDownIconForSection:)]) {
            pulldown = [_dataSource menu:self titleDownIconForSection:i];
        }
        
        UIButton *btn = getBtn(pullup, pulldown);
        btn.tag = i+1;
        NSString *title = [_dataSource menu:self titleForSection:i];
        [btn setTitle:title forState:UIControlStateNormal];
        [self.titleBtnArr addObject:btn];
        [self.topBar addSubview:btn];
        
        if (_dataSource && [_dataSource respondsToSelector:@selector(menu:defaultSelectIndexInSection:)]) {
            NSInteger index = [_dataSource menu:self defaultSelectIndexInSection:i];
            [_historyOfSelected addObject:@(index)];
        } else {
            [_historyOfSelected addObject:@(0)];
        }
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)titleBtnClick:(UIButton *)x{
    
    if (![x isEqual:_selectedBtn])  _selectedBtn.selected = NO;
    _selectedBtn = x;
    x.selected = !x.selected;
    if (x.selected==YES) {
        _cover.hidden = NO;
        if (_delegate && [_delegate respondsToSelector:@selector(menu:coverWillDisplay:)] && _cover) {
            [_delegate menu:self coverWillDisplay:_cover];
        }
        UIButton *btn = [_selectedCell viewWithTag:KCellButtonTag];
        btn.selected = NO;
        btn.backgroundColor = CDNRGBColor(246, 246, 246, 1);
        NSInteger count = [_dataSource menu:self numberOfItemsInSection:x.tag-1];
        NSInteger cols = [_dataSource menu:self numberOfColumnInSection:x.tag-1];
        
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        CGFloat w = (self.width-self.contentEdgeInsets.left-self.contentEdgeInsets.right-_itemMarginX*(cols-1))/cols;
        layout.itemSize = CGSizeMake(w,  _itemHeight);
        layout.sectionInset = _contentEdgeInsets;
        layout.minimumLineSpacing =  _itemMarginY;
        layout.minimumInteritemSpacing = _itemMarginX;
        
        NSInteger rows = ceil(((float)count)/cols);
        if (self.maxCollectionViewH) {
            _collectionView.height = MIN(self.maxCollectionViewH, _itemHeight*rows + _itemMarginY*(rows-1)+ _contentEdgeInsets.top + _contentEdgeInsets.bottom);
        } else {
            _collectionView.height = _itemHeight*rows + _itemMarginY*(rows-1)+ _contentEdgeInsets.top + _contentEdgeInsets.bottom;
        }
        [_collectionView reloadData];
        
        _collectionView.y = -_collectionView.height;
        [UIView animateWithDuration:0.2 animations:^{
            _collectionView.y = _topBarHeight;
            _collectionView.alpha = 1;
        }];
        
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(menu:coverWillHidden:)] && _cover) {
            [_delegate menu:self coverWillHide:_cover];
        }
        _cover.hidden = YES;
        [UIView animateWithDuration:0.2 animations:^{
            _collectionView.y = -_collectionView.height;
            _collectionView.alpha = 0;
        }];
    }
}

#pragma mark - public
- (UIButton *)topButtonAtIndex:(NSInteger)index{
    return [self.topBar viewWithTag:index+1];
}

- (void)selectIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.section>[_dataSource numberOfSectionsInMenu:self]) {
    //        DLog(@"Error : 选择的IndexPath越界");
    //        return;
    //    }
    //
    //    if (indexPath.item>[_dataSource menu:self numberOfItemsInSection:indexPath.section]) {
    //        DLog(@"Error : 选择的IndexPath越界");
    //        return;
    //    }
    //
    //    [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]];
    
    UIButton *oldBtn = [_selectedCell viewWithTag:KCellButtonTag];
    oldBtn.backgroundColor = CDNRGBColor(246, 246, 246, 1);
    oldBtn.selected = NO;
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]];
    
    UIButton *newBtn = [cell viewWithTag:KCellButtonTag];
    newBtn.backgroundColor = CDNRGBColor(14, 201, 195, 1);
    newBtn.selected = YES;
    
    [_historyOfSelected replaceObjectAtIndex:_selectedBtn.tag-1 withObject:@(indexPath.item)];
    
    _selectedCell = cell;
    
    [self titleBtnClick:_selectedBtn];
    
    NSString *newTitle = [_dataSource menu:self titleForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:_selectedBtn.tag-1]];
    NSString *selectTitle = ([newTitle isEqualToString:@"全部"] || newTitle==nil) ? [_dataSource menu:self titleForSection:_selectedBtn.tag-1] : newTitle;
    [_selectedBtn setTitle:selectTitle forState:UIControlStateNormal];
    
    if ([_delegate respondsToSelector:@selector(menu:didSelectItemAtIndexPath:)]) {
        [_delegate menu:self didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:_selectedBtn.tag-1]];
    }
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataSource menu:self numberOfItemsInSection:_selectedBtn.tag-1];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.layer.cornerRadius = 2;
    cell.clipsToBounds = YES;
    UIButton *btn = [cell viewWithTag:KCellButtonTag];
    if (!btn) {
        btn = [[UIButton alloc] init];
        btn.tag = KCellButtonTag;
        /** 适配 5s 屏幕尺寸 */
        if ([CDNDeviceModel is_iPhone4] || [CDNDeviceModel is_iPhone5]) {
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:CDNRGBColor(68, 68, 68, 1) forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(cell);
        }];
        
        btn.userInteractionEnabled = NO;
        btn.backgroundColor = CDNRGBColor(246, 246, 246, 1);
    }
    
    btn.backgroundColor = CDNRGBColor(246, 246, 246, 1);
    btn.selected = NO;
    
    if (indexPath.item==[_historyOfSelected[_selectedBtn.tag-1] integerValue]) {
        btn.backgroundColor = CDNRGBColor(14, 201, 195, 1);
        btn.selected = YES;
        _selectedCell = cell;
    }
    
    NSString *str = [_dataSource menu:self titleForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:_selectedBtn.tag-1]];
    [btn setTitle:str forState:UIControlStateNormal];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self selectIndexPath:indexPath];
}

- (void)showCoverWithColor:(UIColor *)coverColor inView:(UIView *)view{
    CDNNoHighlightButton *cover = [[CDNNoHighlightButton alloc] init];
    if (cover) {
        cover.backgroundColor = coverColor;
    }
    if ([view.subviews containsObject:self]) {
        [view insertSubview:cover belowSubview:self];
    } else {
        [view addSubview:cover];
    }
    
    cover.hidden = YES;
    
    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    __weak typeof(self) weakSelf = self;
    [[cover rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf titleBtnClick:_selectedBtn];
    }];
    
    _cover = cover;
}

- (void)exitMenu{
    [self titleBtnClick:_selectedBtn];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!self.clipsToBounds && !self.hidden && self.alpha>0) {
        for (UIView *member in self.subviews) {
            CGPoint subPoint = [member convertPoint:point fromView:self];
            UIView *res = [member hitTest:subPoint withEvent:event];
            if (res != nil) {
                return res;
            }
        }
    }
    return nil;
}


@end
