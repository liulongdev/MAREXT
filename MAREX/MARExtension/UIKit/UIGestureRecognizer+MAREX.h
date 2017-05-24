//
//  UIGestureRecognizer+MAREX.h
//  MARExtensionDemo
//
//  Created by Martin.liu on 17/5/17.
//  Copyright © 2017年 MAR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (MAREX)

/**
 Initializes an allocated gesture-recognizer object with a action block.
 
 @param block  An action block that to handle the gesture recognized by the
 receiver. nil is invalid. It is retained by the gesture.
 
 @return An initialized instance of a concrete UIGestureRecognizer subclass or
 nil if an error occurred in the attempt to initialize the object.
 */
- (instancetype)initWithMarActionBlock:(void (^)(id sender))block;

/**
 Adds an action block to a gesture-recognizer object. It is retained by the
 gesture.
 
 @param block A block invoked by the action message. nil is not a valid value.
 */
- (void)mar_addActionBlock:(void (^)(id sender))block;

/**
 Remove all action blocks.
 */
- (void)mar_removeAllActionBlocks;

@end

/**
 Includes code by the following:
 
 - [Kevin O'Neill](https://github.com/kevinoneill)
 - [Zach Waldowski](https://github.com/zwaldowski)

 */

@interface UIGestureRecognizer (MAREX_Block)

/** Allows the block that will be fired by the gesture recognizer
 to be modified after the fact.
 */
@property (nonatomic, copy, nullable) void (^mar_handler)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location);

/** Allows the length of the delay after which the gesture
 recognizer will be fired to modify. */
@property (nonatomic) NSTimeInterval mar_handlerDelay;

/** An autoreleased gesture recognizer that will, on firing, call
 the given block asynchronously after a number of seconds.
 
 @return An autoreleased instance of a concrete UIGestureRecognizer subclass, or `nil`.
 @param block The block which handles an executed gesture.
 @param delay A number of seconds after which the block will fire.
 */
+ (instancetype)mar_recognizerWithDelay:(NSTimeInterval)delay handler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

/** Initializes an allocated gesture recognizer that will call the given block
 after a given delay.
 
 An alternative to the designated initializer.
 
 @return An initialized instance of a concrete UIGestureRecognizer subclass or `nil`.
 @param block The block which handles an executed gesture.
 @param delay A number of seconds after which the block will fire.
 */
- (instancetype)initWithMarDelay:(NSTimeInterval)delay Handler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

/** An autoreleased gesture recognizer that will call the given block.
 
 For convenience and compatibility reasons, this method is indentical
 to using recognizerWithHandler:delay: with a delay of 0.0.
 
 @return An initialized and autoreleased instance of a concrete UIGestureRecognizer
 subclass, or `nil`.
 @param block The block which handles an executed gesture.
 */
+ (instancetype)mar_recognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

/** Initializes an allocated gesture recognizer that will call the given block.
 
 This method is indentical to calling initWithHandler:delay: with a delay of 0.0.
 
 @return An initialized instance of a concrete UIGestureRecognizer subclass or `nil`.
 @param block The block which handles an executed gesture.
 */
- (instancetype)initWithMarHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

/** If the recognizer happens to be fired, calling this method
 will stop it from firing, but only if a delay is set.
 
 @warning This method is not for arbitrarily canceling the
 firing of a recognizer, but will only function for a block
 handler *after the recognizer has already been fired*.  Be
 sure to make your delay times accomodate this likelihood.
 */
- (void)mar_cancel;


@end

NS_ASSUME_NONNULL_END
