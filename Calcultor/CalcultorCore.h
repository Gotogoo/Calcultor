//
//  CalcultorCore.h
//  Calcultor
//
//  Created by Facheng Liang  on 2017/7/30.
//  Copyright © 2017年 Facheng Liang . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalcultorCore : NSObject

- (void)pushOperandInStack: (double)operand;
- (void)pushOperationalSymbolInStack: (NSString *)operationalSymbol;
- (double)calcResult;
- (void)popAllSymbols;
- (void)popAllOperands;



@end
