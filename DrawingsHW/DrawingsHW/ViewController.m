//
//  ViewController.m
//  DrawingsHW
//
//  Created by Ivan Kozaderov on 17.04.2018.
//  Copyright © 2018 Ivan Kozaderov. All rights reserved.
//

#import "ViewController.h"
#import "KIView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet KIView *drawingView;

@property (weak, nonatomic) UIView *testView;
@property (weak, nonatomic) UIView *testView1;
@property (weak, nonatomic) UIView *testView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drawingView.frameSize  = self.view.frame.size;
    
    CGRect rect = CGRectMake(50, 100, 50, 50);
    UIView* testView = [[UIView alloc] initWithFrame:rect];
    testView.backgroundColor = [UIColor redColor];
    [self.drawingView addSubview:testView];
    self.testView = testView;
    
    CGRect rect1 = CGRectMake(110, 100, 50, 50);
    UIView* testView1 = [[UIView alloc] initWithFrame:rect1];
    testView1.backgroundColor = [UIColor orangeColor];
    [self.drawingView addSubview:testView1];
    self.testView1 = testView1;
    
    CGRect rect2 = CGRectMake(160, 100, 50, 50);
    UIView* testView2 = [[UIView alloc] initWithFrame:rect2];
    testView2.backgroundColor = [UIColor magentaColor];
    [self.drawingView addSubview:testView2];
    self.testView2 = testView2;
    
    testView.layer.cornerRadius  = 5;
    testView1.layer.cornerRadius = 10;
    testView2.layer.cornerRadius  = 15;
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Info" message:@"Alert" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch = [touches anyObject];
    
    CGPoint  point  = [touch locationInView:self.testView];
    CGPoint  point1 = [touch locationInView:self.testView1];
    CGPoint  point2 = [touch locationInView:self.testView2];
    
    UIView*  view   = [self.testView  hitTest:point withEvent:event];
    UIView*  view1  = [self.testView1 hitTest:point1 withEvent:event];
    UIView*  view2  = [self.testView2 hitTest:point2 withEvent:event];
    
    if ([view isEqual:self.testView]) {
        NSLog(@"cornerRadius  = 5");
    }
    else if ([view1 isEqual:self.testView1]){
        NSLog(@"cornerRadius  = 10");
    }
    else if ([view2 isEqual:self.testView2]){
        NSLog(@"cornerRadius  = 15");
    }
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
    
    
    [self.drawingView setNeedsDisplay];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
