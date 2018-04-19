//
//  KIView.m
//  DrawingsHW
//
//  Created by Ivan Kozaderov on 18.04.2018.
//  Copyright © 2018 Ivan Kozaderov. All rights reserved.
//

#import "KIView.h"

@implementation KIView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    

    /*
     for (NSUInteger k = 0    ;k < 5  ;k++ ) {
     
     CGPoint p = CGPointMake(arc4random_uniform(self.frameSize.width - 50),
     arc4random_uniform(self.frameSize.height - 50));
     
     [self drawStarInPoint:p];
     }
     
     */
    
}

-(UIColor*) randomColor {
    
    CGFloat red   = (float)(arc4random()%256)/255;
    CGFloat green = (float)(arc4random()%256)/255;
    CGFloat blue  = (float)(arc4random()%256)/255;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.];
}

-(void) drawStarInPoint:(CGPoint) point{
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSMutableArray* points     = [NSMutableArray array];
    NSMutableArray* linePoints = [NSMutableArray array];
    
    CGPoint p   = CGPointZero;
    float   w   = 50.0;
    double  r   = w / 2.0;
    float flip  = -1.0;
    
    
    CGContextSetFillColorWithColor(context, [self randomColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    double theta = 2.0 * M_PI * (2.0 / 5.0);//144 degrees
    
    CGContextMoveToPoint(context, point.x, r * flip + point.y);
    
    p = CGPointMake(point.x, r * flip + point.y);
    
    [points addObject:[NSValue valueWithCGPoint:p]];
    
    for (NSUInteger k = 1;k < 5;k++ ) {
        
        float x = r* sin(k * theta);
        float y = r* cos(k * theta);
        
        CGContextAddLineToPoint(context, x + point.x, y * flip + point.y);
        
        p = CGPointMake(x + point.x, y * flip + point.y);
        
        [points addObject:[NSValue valueWithCGPoint:p]];
        
    }
    
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    UIColor* circleColor = [self randomColor];
    //Draw Cirkles
    for (NSValue* value in points) {
        
        CGPoint centerOfCirkle = value.CGPointValue;
        // NSLog(@"%@",NSStringFromCGPoint(centerOfCirkle));
        CGContextSetStrokeColorWithColor(context, circleColor.CGColor);
        CGRect rect = CGRectMake(centerOfCirkle.x - 5, centerOfCirkle.y - 5, 10, 10);
        CGContextStrokeEllipseInRect(context, rect);
        CGContextStrokePath(context);
    }
    
    //Draw Lines
    NSValue* val0 = [points objectAtIndex:0];
    [linePoints addObject:val0];
    NSValue* val1 = [points objectAtIndex:3];
    [linePoints addObject:val1];
    NSValue* val2 = [points objectAtIndex:1];
    [linePoints addObject:val2];
    NSValue* val3 = [points objectAtIndex:4];
    [linePoints addObject:val3];
    NSValue* val4 = [points objectAtIndex:2];
    [linePoints addObject:val4];
    
    UIColor* lineColor = [self randomColor];
    for (NSUInteger i = 0 ;i < [linePoints count];i++ ) {
        
        // NSLog(@"i = %lu",i);
        NSValue* startValue = [linePoints objectAtIndex:i];
        CGPoint startPoint = startValue.CGPointValue;
        // NSLog(@"startPoint%@",NSStringFromCGPoint(startPoint));
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        
        if ( i==4) {
            
            NSValue* endValue = [linePoints firstObject];
            CGPoint endPoint = endValue.CGPointValue;
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
            CGContextStrokePath(context);
        }
        else{
            
            NSValue* endValue = [linePoints objectAtIndex:i+1];
            CGPoint endPoint = endValue.CGPointValue;
            //  NSLog(@"endPoint%@",NSStringFromCGPoint(endPoint));
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
            CGContextStrokePath(context);
        }
        
    }
    points     = nil;
    linePoints = nil;
    
}


@end
