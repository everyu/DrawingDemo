//
//  DrawingLine.h
//  DrawingDemo
//
//  Created by everyu on 2020/5/26.
//  Copyright © 2020 everyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawingLine : NSObject
@property (nonatomic, strong)NSMutableArray <NSValue *>*points;
@property (nonatomic, strong)UIColor *lineColor;
@property (nonatomic, assign)CGFloat lineWidth;

@end

NS_ASSUME_NONNULL_END
