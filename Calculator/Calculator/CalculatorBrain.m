//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Huned Botee on 10/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain
@synthesize operand;
@synthesize waitingOperation;
@synthesize errorMessage;

- (void)reset {
  waitingOperand = operand = memory = 0;
  waitingOperation = nil;
}

- (BOOL)hasDecimal {
  return floor(operand) < operand;
}

- (BOOL)isError {
  return ![self.errorMessage isEqual:@""];
}

- (void)performWaitingOperation {
  if ([@"+" isEqual:waitingOperation]) {
    self.operand = waitingOperand + self.operand;
  } else if ([@"*" isEqual:waitingOperation]) {
    self.operand = waitingOperand * self.operand;
  } else if ([@"-" isEqual:waitingOperation]) {
    self.operand = waitingOperand - self.operand;
  } else if ([@"/" isEqual:waitingOperation]) {
    if (self.operand == 0) {
      self.errorMessage = @"Divide by zero";
      [self reset];
      return;
    } else {
      self.operand = waitingOperand / self.operand;
    }
  }
  self.errorMessage = @"";
}

- (double)performOperation:(NSString *)operation {
  if ([operation isEqual:@"sqrt"]) {
    if (self.operand < 0) {
      self.errorMessage = @"Negative square root";
      [self reset];
      return self.operand;
    } else {
      self.operand = sqrt(self.operand);
    }
  } else if ([@"sin" isEqual:operation]) {
    self.operand = sin(self.operand);  
  } else if ([@"cos" isEqual:operation]) {
    self.operand = cos(self.operand);
  } else if ([@"1/x" isEqual:operation]) {
    if (self.operand == 0) {
      self.errorMessage = @"Divide by zero";
      [self reset];
      return self.operand;
    } else {
      self.operand = 1 / self.operand;
    }
  } else if ([@"+/-" isEqual:operation]) {
    self.operand = -self.operand;
  } else if ([@"store" isEqual:operation]) {
    memory = self.operand;
  } else if ([@"recall" isEqual:operation]) {
    self.operand = memory;
  } else if ([@"mem+" isEqual:operation]) {
    memory = memory + self.operand;
  } else if ([@"C" isEqual:operation]) {
    [self reset];
    self.errorMessage = @"";
  } else {
    [self performWaitingOperation];
    waitingOperation = operation;
    waitingOperand = operand;
    if ([self isError]) return self.operand;
  }
  self.errorMessage = @"";
  return self.operand;
}

@end