//
//  ViewController.m
//  CDNKitDemo
//
//  Created by 陈栋楠 on 2017/2/3.
//  Copyright © 2017年 陈栋楠. All rights reserved.
//

#import "ViewController.h"
#import "CDNDropDownMenu.h"
@interface ViewController ()<CDNDropDownMenuDelegate,CDNDropDownMenuDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"CDNKitDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    CDNDropDownMenu *menu = [[CDNDropDownMenu alloc] init];
    [self.view addSubview:menu];
    [menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(64);
        make.height.mas_equalTo(49);
    }];
    menu.delegate = self;
    menu.dataSource = self;
}


#pragma mark - CDNDropDownMenuDelegate & DataSource
- (NSInteger)numberOfSectionsInMenu:(CDNDropDownMenu *)menu {
    return 3;
}
- (NSInteger)menu:(CDNDropDownMenu *)menu numberOfColumnInSection:(NSInteger)section {
    return 4;
}
- (NSInteger)menu:(CDNDropDownMenu *)menu numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (NSString *)menu:(CDNDropDownMenu *)menu titleForItemAtIndexPath:(NSIndexPath *)indexPath {
    return @"test";
}
- (NSString *)menu:(CDNDropDownMenu *)menu titleForSection:(NSInteger)section {
    return @"test";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
