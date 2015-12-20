//
//  ViewController.m
//  CustomSegmentedControl
//
//  Created by NCS on 17/12/15.
//  Copyright © 2015年 Balwant. All rights reserved.
//

#import "ViewController.h"

#import "DVSwitch.h"

@interface ViewController ()

{
    DVSwitch *segmentedControl;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    segmentedControl = [[DVSwitch alloc] initWithStringsArray:@[@"First",@"Second"]];
    segmentedControl.frame = CGRectMake(100, 50, 150, 30);
    
    
    // 未被选中的  item 的背景色
    segmentedControl.backgroundColor = [UIColor colorWithRed:80.0/255 green:175.0/255 blue:244.0/255 alpha:1.0];
    // 被选中的   item   的背景色
    segmentedControl.sliderColor = [UIColor whiteColor];
    
    
    // 未被选中的  item  的 title 的字体颜色
    segmentedControl.labelTextColorOutsideSlider = [UIColor whiteColor];
    
    // 被选中的    item  的 title 的字体颜色
    segmentedControl.labelTextColorInsideSlider = [UIColor colorWithRed:80.0/255 green:175.0/255 blue:244.0/255 alpha:1.0];
    
    
    
    
    // 设置  segmentedControl 的 border
    CALayer *layer = [segmentedControl.backgroundView layer];
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.borderWidth = .5f;
    
    /*
     
     // 这是判断一下是iPhone 还是  iPad ，然后设置不同的style
     
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        segmentedControl.backgroundColor = [UIColor whiteColor];
        segmentedControl.labelTextColorInsideSlider = [UIColor whiteColor];
        segmentedControl.labelTextColorOutsideSlider = [UIColor colorWithRed:80.0/255 green:175.0/255 blue:244.0/255 alpha:1.0];
        segmentedControl.sliderColor = [UIColor colorWithRed:80.0/255 green:175.0/255 blue:244.0/255 alpha:1.0];
        CALayer *layer = [segmentedControl.backgroundView layer];
        layer.borderColor = [[UIColor colorWithRed:80.0/255 green:175.0/255 blue:244.0/255 alpha:1.0] CGColor];
        layer.borderWidth = .5f;
    }else{
        // 未被选中的  item 的背景色
        segmentedControl.backgroundColor = [UIColor colorWithRed:80.0/255 green:175.0/255 blue:244.0/255 alpha:1.0];
        // 被选中的   item   的背景色
        segmentedControl.sliderColor = [UIColor redColor];
        
        
        // 未被选中的  item  的 title 的字体颜色
        segmentedControl.labelTextColorOutsideSlider = [UIColor whiteColor];
        
        // 被选中的    item  的 title 的字体颜色
        segmentedControl.labelTextColorInsideSlider = [UIColor colorWithRed:80.0/255 green:175.0/255 blue:244.0/255 alpha:1.0];
        
        
        
        
        // 设置  segmentedControl 的 border
        CALayer *layer = [segmentedControl.backgroundView layer];
        layer.borderColor = [[UIColor whiteColor] CGColor];
        layer.borderWidth = .5f;
        
        
    }
     */
    
    
    segmentedControl.font = [UIFont systemFontOfSize:12];
    segmentedControl.cornerRadius = segmentedControl.bounds.size.height * 0.5;
    
    [self.view addSubview:segmentedControl];
    
    segmentedControl.selectedIndex = 0;
    
    
    

    [segmentedControl setPressedHandler:^(NSUInteger index) {
        switch (index) {
            case 0:
                NSLog(@"index = %ld",index);
                break;
                
            case 1:
                NSLog(@"index = %ld",index);
                
            default:
                break;
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
