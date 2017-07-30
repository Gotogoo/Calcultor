//
//  CalcultorCore.m
//  Calcultor
//
//  Created by Facheng Liang  on 2017/7/30.
//  Copyright © 2017年 Facheng Liang . All rights reserved.
//

#import "CalcultorCore.h"

@class CalcultorCore;

@interface CalcultorCore()

@property (strong,nonatomic)NSMutableArray  *operandStack;
@property (strong,nonatomic)NSMutableArray *operationalSymbolStack;

- (BOOL)isSymbolHighPriority:(NSString *)symbol;

@end


@implementation CalcultorCore

- (NSMutableArray *)operandStack {
    if(!_operandStack){
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}
- (NSMutableArray *)operationalSymbolStack {
    if(!_operationalSymbolStack){
        _operationalSymbolStack = [[NSMutableArray alloc] init];
    }
    return _operationalSymbolStack;
}

- (void)pushOperationalSymbolInStack: (NSString *)operationalSymbol {
    
    if(!(operationalSymbol == NULL || operationalSymbol == nil) ) {
        [self.operationalSymbolStack addObject:operationalSymbol];
    }
}
- (void)pushOperandInStack: (double)operand  AtIndex: (NSUInteger)index {
    
    [self.operandStack insertObject:[NSNumber numberWithDouble:operand] atIndex:index];
    
}

- (void)pushOperandInStack: (double)operand {
    
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
    
}

- (double)calcResult {
    
    double stepResult = 0;
    while([self.operationalSymbolStack count] > 0) {
        NSUInteger indexOfBeginCalc = [self whereBeginCalc];
        NSString *symbol = [self popSymbol:indexOfBeginCalc];
        double firstOperand = [self popOperand:indexOfBeginCalc];
        double secondOperand = [self popOperand:indexOfBeginCalc];
        
        if ([symbol isEqualToString:@"+"]) stepResult = firstOperand + secondOperand;
        else if ([symbol isEqualToString:@"-"]) stepResult = firstOperand - secondOperand;
        else if ([symbol isEqualToString:@"*"]) stepResult = firstOperand * secondOperand;
        else if ([symbol isEqualToString:@"/"]) stepResult = firstOperand / secondOperand;
        //注意 push进了结果
        if([self.operandStack count] > 0) {
            [self pushOperandInStack:stepResult AtIndex:indexOfBeginCalc];
        }
    }
    return stepResult;
}



- (NSUInteger)whereBeginCalc {
    NSUInteger index = 0;
    for(NSInteger i=0;i<[self.operationalSymbolStack count];i++) {
        if([self isSymbolHighPriority:[self.operationalSymbolStack objectAtIndex:i]]) {
            index = i;
        }
    }
    return index;
}

- (BOOL)isSymbolHighPriority: (NSString *)symbol {
    if([symbol isEqualToString:@"*"] || [symbol isEqualToString:@"/"]) {
        return TRUE;
    }
    return FALSE;
}

- (NSString *)popSymbol :(NSUInteger)index {
    NSString *symbol = [self.operationalSymbolStack objectAtIndex:index];
    [self.operationalSymbolStack removeObjectAtIndex:index];
    return symbol;
    
}
- (double)popOperand :(NSUInteger)index {
    
    double operand = [[self.operandStack objectAtIndex:index]doubleValue];
    [self.operandStack removeObjectAtIndex:index];
    return operand;
}

- (void)popAllSymbols {
    [self.operationalSymbolStack removeAllObjects];
    
}
- (void)popAllOperands {
    [self.operandStack removeAllObjects];
    
}

@end
