//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Huned Botee on 10/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {
  double operand;
  double memory;
  NSString *waitingOperation;
  double waitingOperand;
}

- (void)setOperand:(double)anOperand;
- (double)performOperation:(NSString *)operation;
- (NSString *)waitingOperation;
- (void)reset;
@end
