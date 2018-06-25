//
//  ViewController.m
//  ScrollViewTest
//
//  Created by 梁超 on 2018/6/19.
//  Copyright © 2018年 梁超. All rights reserved.
//

#import "ViewController.h"
#import "ADView.h"
#import "MTConfig.h"

@interface ViewController ()

@property (nonatomic,strong) ADView *adView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rect = CGRectMake(0, 100, kDeviceWidth, kDeviceWidth/1.78);
    
    NSMutableArray *imgData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 9; i++) {
        NSString *imgName = [NSString stringWithFormat:@"pic_hd%d", i+1];
        UIImage *img = [UIImage imageNamed:imgName];
        [imgData addObject:img];
    }
    
    self.adView = [[ADView alloc] initWithFrame:rect withImgData:imgData];
    [self.view addSubview:self.adView];
    
    self.view.backgroundColor = [UIColor blackColor];
}


@end
