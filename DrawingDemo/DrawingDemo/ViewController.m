//
//  ViewController.m
//  DrawingDemo
//
//  Created by everyu on 2020/5/25.
//  Copyright © 2020 everyu. All rights reserved.
//

#import "ViewController.h"
#import "DrawingView.h"

@interface ViewController ()

@property (nonatomic, strong)DrawingView *drawingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(0, 20, self.view.frame.size.width, 50);
    clearBtn.backgroundColor = UIColor.whiteColor;
    [clearBtn setTitle:@"Draw/Clear" forState:UIControlStateNormal];
    [clearBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(onClear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    
    self.view.backgroundColor = UIColor.lightGrayColor;
}

- (void)onClear
{
    [self.drawingView removeFromSuperview];
    
    DrawingView *view = [[DrawingView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100)];
    [self.view addSubview:view];
    self.drawingView = view;
}

@end
