//
//  ViewController.m
//  Calcultor
//
//  Created by Facheng Liang  on 2017/7/29.
//  Copyright © 2017年 Facheng Liang . All rights reserved.
//

#import "ViewController.h"
#import "CalcultorCore.h"

@interface ViewController ()

- (IBAction)digitClicked:(UIButton *)sender;
- (IBAction)operationalSymbolClicked:(UIButton *)sender;
- (IBAction)plus_minusOrPercentageClicked:(UIButton *)sender;
- (IBAction)resetClicked:(UIButton *)sender;
- (IBAction)equalClicked:(UIButton *)sender;
- (BOOL)isResetisAC;

@property (nonatomic) CalcultorCore *calcCore;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;



@property BOOL isOperandInputComplete;

-(NSString *)removeDoubleInvalidZero:(double)stringDouble;


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

- (CalcultorCore *)calcCore{
    
    //注意self.xxx和_xxx的区别
    if (!_calcCore) {
        _calcCore = [[CalcultorCore alloc] init];
    }
    return _calcCore;
    
}

- (IBAction)digitClicked:(UIButton *)sender {
    NSString *digitString = sender.currentTitle;
    NSLog(@"Clicked %@",digitString);
    if (self.isOperandInputComplete) {
       self.displayLabel.text = digitString;
    }
    else{
        self.displayLabel.text = [self.displayLabel.text stringByAppendingString:digitString];
    }
    
    [self.resetBtn setTitle:@"C" forState:UIControlStateNormal];
    self.isOperandInputComplete = FALSE;
}

- (IBAction)operationalSymbolClicked:(UIButton *)sender {
    NSString *symbol = sender.currentTitle;
    NSLog(@"Cliecked %@",symbol);
    [self.calcCore pushOperandInStack:[self.displayLabel.text doubleValue]];
    [self.calcCore pushOperationalSymbolInStack:sender.currentTitle];
    
    self.isOperandInputComplete = TRUE;
}

- (IBAction)plus_minusOrPercentageClicked:(UIButton *)sender {
    NSString *symbol = sender.currentTitle;
    double operand = [self.displayLabel.text doubleValue];
    NSLog(@"Clicked %@",symbol);
    if ([symbol isEqual: @"+/-"]){
        self.displayLabel.text = [self removeDoubleInvalidZero:operand*(-1)];
    }
    else if ([symbol isEqual:@"%"]){
        self.displayLabel.text = [self removeDoubleInvalidZero:operand/100];
    }

}

- (IBAction)resetClicked:(UIButton *)sender {
    self.displayLabel.text = [NSString stringWithFormat:@"0"];

    if (self.isResetisAC) {
        [self.calcCore popAllOperands];
        [self.calcCore popAllSymbols];
    }
    else {
        [self.resetBtn setTitle:@"AC" forState:UIControlStateNormal];
        self.isOperandInputComplete = TRUE;
    }
    
}

- (IBAction)equalClicked:(UIButton *)sender {
    [self.calcCore pushOperandInStack:[self.displayLabel.text doubleValue]];
    double result = [self.calcCore calcResult];
    self.displayLabel.text = [self removeDoubleInvalidZero:result];
    self.isOperandInputComplete = TRUE;
}

-(NSString *)removeDoubleInvalidZero:(double)digit
{
    NSString *stringDouble = [NSString stringWithFormat:@"%f",digit];
    const char *floatChars = [stringDouble UTF8String];
    NSUInteger length = [stringDouble length];
    NSUInteger zeroLength = 0;
    int i = length - 1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringDouble substringToIndex:i+1];
    }
    return returnString;
}

- (BOOL)isResetisAC {
    if([self.resetBtn.currentTitle isEqualToString:@"AC"]) {
        return TRUE;
    }
    return FALSE;
    
}



@end
