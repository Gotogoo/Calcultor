//
//  ViewController.m
//  Calcultor
//
//  Created by Facheng Liang  on 2017/7/29.
//  Copyright © 2017年 Facheng Liang . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)digitClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)digitClicked:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    NSLog(@"Cliecked %@",digit);
    self.displayLabel.text = [self.displayLabel.text stringByAppendingString:digit];
    
}



@end
