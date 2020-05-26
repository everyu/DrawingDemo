//
//  DrawingTileView.m
//  DrawingDemo
//
//  Created by everyu on 2020/5/26.
//  Copyright © 2020 everyu. All rights reserved.
//

#import "DrawingTileView.h"

@implementation DrawingTileView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.layer.borderWidth = 1/UIScreen.mainScreen.scale;
        self.layer.borderColor = UIColor.yellowColor.CGColor;
    }
    return self;
}


- (void)addLineStartPoint:(CGPoint)point color:(nonnull UIColor *)color lineWidth:(CGFloat)lineWidth
{
    DrawingLine *line = DrawingLine.new;
    line.lineColor = color;
    line.lineWidth = lineWidth;
    [line.points addObject:[NSValue valueWithCGPoint:point]];
    
    [self.lines addObject:line];
}

- (void)appendPoint:(CGPoint)point
{
    DrawingLine *line = self.lines.lastObject;
    [line.points addObject:[NSValue valueWithCGPoint:point]];
}


- (NSMutableArray<DrawingLine *> *)lines
{
    if (_lines == nil) {
        _lines = NSMutableArray.array;
    }
    return _lines;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    for (DrawingLine *line in self.lines) {
        //起点
        NSValue *firstV = line.points.firstObject;
        UIBezierPath *path = UIBezierPath.bezierPath;
        path.lineWidth = 1;
        [path moveToPoint:firstV.CGPointValue];
        
        //中间点处理
        CGPoint lastPoint = firstV.CGPointValue;
        for (NSValue *pointV in line.points) {
            CGPoint point = pointV.CGPointValue;
            CGPoint midPoint = [self midPoint:point pointB:lastPoint];
            [path addQuadCurveToPoint:midPoint controlPoint:lastPoint];
            
            lastPoint = point;
        }
        
        //终点
        CGPoint endPoint = line.points.lastObject.CGPointValue;
        [path addQuadCurveToPoint:endPoint controlPoint:lastPoint];
        [path addLineToPoint:endPoint];
        
        [line.lineColor setStroke];
        [path strokeWithBlendMode:kCGBlendModeNormal alpha:1];
    }
}

- (CGPoint)midPoint:(CGPoint)pointA pointB:(CGPoint)pointB
{
    return CGPointMake(pointA.x/2+pointB.x/2, pointA.y/2+pointB.y/2);
}
@end
