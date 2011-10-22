//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Huned Botee on 10/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

- (void)reset {
  waitingOperand = operand = memory = 0;
  waitingOperation = nil;
}

- (void)setOperand:(double)anOperand {
  operand = anOperand;
}

- (void)performWaitingOperation
{
  if ([@"+" isEqual:waitingOperation]) {
    operand = waitingOperand + operand;
  } else if ([@"*" isEqual:waitingOperation]) {
    operand = waitingOperand * operand;
  } else if ([@"-" isEqual:waitingOperation]) {
    operand = waitingOperand - operand;
  } else if ([@"/" isEqual:waitingOperation]) {
    if (operand) {
      operand = waitingOperand / operand;
    }
  }
}

- (double)performOperation:(NSString *)operation {
  if ([operation isEqual:@"sqrt"]) {
    operand = sqrt(operand);
  } else if ([@"sin" isEqual:operation]) {
    operand = sin(operand);  
  } else if ([@"cos" isEqual:operation]) {
    operand = cos(operand);
  } else if ([@"1/x" isEqual:operation]) {
    operand = 1 / operand;
  } else if ([@"+/-" isEqual:operation]) {
    operand = -operand;
  } else if ([@"store" isEqual:operation]) {
    memory = operand;
  } else if ([@"recall" isEqual:operation]) {
    operand = memory;
  } else if ([@"mem+" isEqual:operation]) {
    memory = memory + operand;
  } else if ([@"C" isEqual:operation]) {
    [self reset];
  } else {
    [self performWaitingOperation];
    waitingOperation = operation;
    waitingOperand = operand;
  }
  return operand;
}

- (NSString *)waitingOperation {
  return waitingOperation;
}

@end
