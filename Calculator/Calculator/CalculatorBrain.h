//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Huned Botee on 10/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {
  // calculator memory
  double memory;

  // operand waiting for another digit in order to compute.
  // eg, in "2 + 3 * (waiting for user input)" the 3 is the waiting operand
  double waitingOperand;
}

// operand
@property double operand;

// operation waiting for a digit in order to execute.
// eg, in "2 + 3 * (waiting for user input)" the * is the waiting operation
@property(retain) NSString * waitingOperation;

// error message
@property(retain) NSString * errorMessage;

// perform the given operation on the operand property
- (double)performOperation:(NSString *)operation;

// reset the instance's state: clear memory, operand, operation, etc
- (void)reset;

// whether or not the operand has a decimal place
- (BOOL)hasDecimal;

// whether there's an error condition
- (BOOL)isError;
@end