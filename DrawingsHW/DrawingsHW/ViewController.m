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

#pragma mark - Outlets
@property (weak, nonatomic) IBOutlet KIView *drawingView;
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UILabel *radiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *opacityLabel;
@property (weak, nonatomic) IBOutlet UILabel *shadowOffsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *borderWidthLabel;


#pragma mark - Outlet Actions
- (IBAction)actionRGBASwitch:(UISwitch *)sender;
- (IBAction)actionRadiusSlider:(UISlider *)sender;
- (IBAction)actionOpacitySlider:(UISlider *)sender;
- (IBAction)actionShadowOffsetSlider:(UISlider *)sender;
- (IBAction)actionBorderWidthSlider:(UISlider *)sender;
- (IBAction)actionScrollLayerSwitch:(UISwitch *)sender;
- (IBAction)actionTextLayerSwitch:(UISwitch *)sender;
- (IBAction)actionGradientLayerSwitch:(UISwitch *)sender;
- (IBAction)actionReplicatorLayerSwitch:(UISwitch *)sender;

@property(strong,nonatomic) NSString* messageTitle;
@property(strong,nonatomic) NSString* messageText;
@property(assign,nonatomic) CGPoint   point;
@property(strong,nonatomic) CAScrollLayer* scrollLayer;
@property(strong,nonatomic) CATextLayer* textLayer;
@property(strong,nonatomic) CAGradientLayer* gradientLayer;
@property(strong,nonatomic) CAReplicatorLayer* replicatorLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.drawingView.frameSize  = self.view.frame.size;
    
    self.messageTitle = @"Info Message";
    self.messageText = @"Default color\nUse Switch to get New";
    self.alertController = [UIAlertController alertControllerWithTitle:self.messageTitle
                                                               message:self.messageText
                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    [self.alertController addAction:defaultAction];
    self.point = self.testView.layer.position;
    

    
}

#pragma mark - Actions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch = [touches anyObject];
    
    CGPoint  point  = [touch locationInView:self.testView];
    
    UIView*  view   = [self.testView  hitTest:point withEvent:event];
    
    
    if ([view isEqual:self.testView]) {
        
        self.messageTitle = @"RGBA color";
        
        [self showMessageWithTitle:self.messageTitle andText:self.messageText];
        
    }
    
}



-(void) showMessageWithTitle:(NSString*) title andText:(NSString*) text{
    
    self.alertController.title = title;
    self.alertController.message = text;
    
    [self presentViewController:self.alertController animated:YES completion:nil];
    
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [self.drawingView setNeedsDisplay];
    
    
}



- (IBAction)actionRGBASwitch:(UISwitch *)sender {
    
    
    if(sender.isOn){
        
        self.testView.backgroundColor = [self randomColor];
        
    }

}

- (IBAction)actionRadiusSlider:(UISlider *)sender {
    
    self.radiusLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
    self.testView.layer.cornerRadius = sender.value;
    
}

- (IBAction)actionOpacitySlider:(UISlider *)sender {
    
    self.opacityLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
    self.testView.layer.opacity = sender.value;
}

- (IBAction)actionShadowOffsetSlider:(UISlider *)sender {
    
    self.shadowOffsetLabel.text = [NSString stringWithFormat:@"%.0f",sender.value];
    self.testView.layer.shadowOffset = CGSizeMake(sender.value, sender.value);
    self.testView.layer.shadowOpacity = sender.value/10.f;
    self.testView.layer.shadowRadius = sender.value;
    self.testView.layer.shadowColor = [UIColor blackColor].CGColor;
}

- (IBAction)actionBorderWidthSlider:(UISlider *)sender {
    
    self.borderWidthLabel.text = [NSString stringWithFormat:@"%.1f",sender.value];
    self.testView.layer.borderColor = [UIColor blackColor].CGColor;
    self.testView.layer.borderWidth = sender.value;
  
}

-(UIColor*) randomColor {
    
    CGFloat red   = (float)(arc4random()%256)/255;
    CGFloat green = (float)(arc4random()%256)/255;
    CGFloat blue  = (float)(arc4random()%256)/255;
    
    self.messageText = [NSString stringWithFormat:@"R:%.3f G:%.3f B:%.3f A:1.",red,green,blue];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.];
}

- (IBAction)actionScrollLayerSwitch:(UISwitch *)sender{
    
    if(sender.isOn){
        self.scrollLayer = [CAScrollLayer layer];
        self.scrollLayer.scrollMode = kCAScrollBoth;
        self.scrollLayer.frame = CGRectMake(CGRectGetMinX(self.testView.bounds), CGRectGetMinY(self.testView.bounds),                  CGRectGetWidth(self.testView.bounds),CGRectGetHeight(self.testView.bounds));
        self.scrollLayer.backgroundColor = [self.testView.backgroundColor CGColor];
        [self.testView.layer addSublayer:self.scrollLayer];
       

    }
    else [self.scrollLayer removeFromSuperlayer];
}

- (IBAction)actionTextLayerSwitch:(UISwitch *)sender{
    
    if(sender.isOn){
        
        self.textLayer = [CATextLayer layer];
        [self.textLayer setString:@"Text"];
        [self.textLayer setFont:(__bridge CFTypeRef)([UIFont boldSystemFontOfSize:14])];
        self.textLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.textLayer.foregroundColor = [UIColor grayColor].CGColor;
        self.textLayer.alignmentMode =  kCAAlignmentJustified;
        self.textLayer.frame = CGRectMake(CGRectGetMinX(self.testView.bounds), CGRectGetMinY(self.testView.bounds), CGRectGetWidth(self.testView.bounds),CGRectGetHeight(self.testView.bounds));
        [self.testView.layer addSublayer:self.textLayer];
        
        
    }
    else [self.textLayer removeFromSuperlayer];
}

- (IBAction)actionGradientLayerSwitch:(UISwitch *)sender{
    
    if(sender.isOn){
        
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.frame = CGRectMake(CGRectGetMinX(self.testView.bounds), CGRectGetMinY(self.testView.bounds), CGRectGetWidth(self.testView.bounds),CGRectGetHeight(self.testView.bounds));
        self.gradientLayer.colors = [NSArray arrayWithObjects:(id)[self.testView.backgroundColor CGColor], (id)[[UIColor whiteColor] CGColor], nil];
        [self.testView.layer addSublayer:self.gradientLayer];
        
    }
    else [self.gradientLayer removeFromSuperlayer];
    
}


- (IBAction)actionReplicatorLayerSwitch:(UISwitch *)sender{
    
    if(sender.isOn){

        self.replicatorLayer = [CAReplicatorLayer layer];
        self.replicatorLayer.frame = CGRectMake(CGRectGetMinX(self.testView.bounds), CGRectGetMinY(self.testView.bounds), CGRectGetWidth(self.testView.bounds),CGRectGetHeight(self.testView.bounds));
        self.replicatorLayer.instanceCount = 30;
        self.replicatorLayer.instanceDelay = 1/30.f;
        self.replicatorLayer.preservesDepth = NO;
        self.replicatorLayer.instanceColor = [UIColor whiteColor].CGColor;
        self.replicatorLayer.instanceRedOffset = 0.0;
        self.replicatorLayer.instanceGreenOffset = -0.5;
        self.replicatorLayer.instanceBlueOffset = -0.5;
        self.replicatorLayer.instanceAlphaOffset = 0.0;
        CGFloat angle = (CGFloat)(3.14 * 2.0) / 30;
        self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0);
        [self.testView.layer addSublayer:self.replicatorLayer];
        
        CALayer* instanceLayer = [CALayer layer];
        CGFloat layerWidth = 10.0;
        CGFloat midX = CGRectGetMidX(self.testView.bounds) - layerWidth / 2.0;
        instanceLayer.frame = CGRectMake(midX, 0, layerWidth, layerWidth * 3.0);

        instanceLayer.backgroundColor = [UIColor whiteColor].CGColor;
         [self.replicatorLayer addSublayer:instanceLayer];
        
        CABasicAnimation* fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnimation.fromValue = [NSNumber numberWithFloat:1.];
        fadeAnimation.toValue = [NSNumber numberWithFloat:0.];
        fadeAnimation.duration = 1;
        fadeAnimation.repeatCount = 400.0;
        instanceLayer.opacity = 0.0;
        [instanceLayer addAnimation:fadeAnimation forKey:@"FadeAnimation"];

    }
    else [self.replicatorLayer removeFromSuperlayer];
}
@end

