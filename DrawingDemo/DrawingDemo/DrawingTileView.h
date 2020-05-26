//
//  DrawingTileView.h
//  DrawingDemo
//
//  Created by everyu on 2020/5/26.
//  Copyright © 2020 everyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingLine.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawingTileView : UIView

@property (nonatomic, strong)NSMutableArray <DrawingLine *> *lines;

- (void)addLineStartPoint:(CGPoint)point color:(UIColor *)color lineWidth:(CGFloat)lineWidth;
- (void)appendPoint:(CGPoint)point;
@end

NS_ASSUME_NONNULL_END
