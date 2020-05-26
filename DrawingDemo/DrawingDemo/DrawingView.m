//
//  DrawingView.m
//  DrawingDemo
//
//  Created by everyu on 2020/5/25.
//  Copyright © 2020 everyu. All rights reserved.
//

#import "DrawingView.h"
#import "DrawingTileView.h"


#define TileWidth  (self.frame.size.width / 3)
#define TileHeight TileWidth

@interface DrawingView ()

@property (nonatomic, strong)NSMutableArray <NSIndexPath *> *indexPaths;
@property (nonatomic, strong)NSMutableArray *tileViews;
@property (nonatomic, strong)DrawingTileView *currentLocationTileView;
@property (nonatomic, strong)DrawingTileView *lastTileView;

@property (nonatomic, assign)NSInteger maxRow;

@property (nonatomic, strong)UIColor *lineColor;
@property (nonatomic, assign)CGFloat lineWidth;


@end

@implementation DrawingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineColor = UIColor.blackColor;
        self.lineWidth = 2;
        self.maxRow = -1;
        self.tileViews = NSMutableArray.array;
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}


- (NSInteger)tileIndexPathForPoint:(CGPoint)point
{
    NSInteger row = point.y / TileWidth;
    
    return row;
}

- (void)addTileViewAtRow:(NSInteger)row
{
    DrawingTileView *view0 = [[DrawingTileView alloc] init];
    view0.frame = CGRectMake(0, row * TileHeight, TileWidth, TileHeight);
    [self addSubview:view0];
    [self.tileViews addObject:view0];
    
    DrawingTileView *view1 = [[DrawingTileView alloc] init];
    view1.frame = CGRectMake(TileWidth, row * TileHeight, TileWidth, TileHeight);
    [self addSubview:view1];
    [self.tileViews addObject:view1];

    DrawingTileView *view2 = [[DrawingTileView alloc] init];
    view2.frame = CGRectMake(TileWidth * 2, row * TileHeight, TileWidth, TileHeight);
    [self addSubview:view2];
    [self.tileViews addObject:view2];

    self.maxRow = row;
}

- (void)checkTileViewForRow:(NSInteger)row
{
    if (row <= self.maxRow) {
        return;
    }
    
    do {
        [self addTileViewAtRow:self.maxRow + 1];
    } while (self.maxRow < row);
}

- (DrawingTileView *)tileViewForPoint:(CGPoint)point
{
    NSInteger row = point.y / TileWidth;
    NSInteger column = point.x / TileHeight;
    
    NSInteger index = row * 3 + column;
    
    if (index < self.tileViews.count) {
        return self.tileViews[index];
    }
    return nil;
}
#pragma mark - touch action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.anyObject locationInView:self];
    NSInteger row = [self tileIndexPathForPoint:point];
    [self checkTileViewForRow:row];
    
    DrawingTileView *v = [self tileViewForPoint:point];
    point = [self convertPoint:point toView:v];
    [v addLineStartPoint:point color:self.lineColor lineWidth:self.lineWidth];
    
    self.currentLocationTileView = v;
    self.lastTileView = nil;
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint prePoint = [touch previousLocationInView:self];
    CGPoint point = [touch locationInView:self];
    
    NSInteger row = [self tileIndexPathForPoint:point];
    [self checkTileViewForRow:row];
    
    if (self.lastTileView) {
        CGPoint p = [self convertPoint:point toView:self.lastTileView];
        [self.lastTileView appendPoint:p];
        [self.lastTileView setNeedsDisplay];
        self.lastTileView = nil;
    }
    

    DrawingTileView *v = [self tileViewForPoint:point];
    if (v == self.currentLocationTileView) {
        point = [self convertPoint:point toView:v];
        [v appendPoint:point];
        [v setNeedsDisplay];
    }else{
        point = [self convertPoint:point toView:self.currentLocationTileView];
        
        [self.currentLocationTileView appendPoint:point];
        [self.currentLocationTileView setNeedsDisplay];
        
        prePoint = [self convertPoint:prePoint toView:v];
        point = [self.currentLocationTileView convertPoint:point toView:v];
        [v addLineStartPoint:prePoint color:self.lineColor lineWidth:self.lineWidth];
        [v appendPoint:point];
        [v setNeedsDisplay];
        self.lastTileView = self.currentLocationTileView;
        self.currentLocationTileView = v;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    CGPoint point = [touches.anyObject locationInView:self];

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
