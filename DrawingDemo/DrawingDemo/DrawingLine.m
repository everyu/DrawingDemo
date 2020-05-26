//
//  DrawingLine.m
//  DrawingDemo
//
//  Created by everyu on 2020/5/26.
//  Copyright © 2020 everyu. All rights reserved.
//

#import "DrawingLine.h"

@implementation DrawingLine

- (NSMutableArray<NSValue *> *)points
{
    if (_points == nil) {
        _points = NSMutableArray.array;
    }
    return _points;
}
@end
