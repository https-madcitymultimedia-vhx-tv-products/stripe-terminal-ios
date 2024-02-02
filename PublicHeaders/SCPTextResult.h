//
//  SCPTextResult.h
//  StripeTerminal
//
//  Created by Stephen Lee on 11/06/23.
//  Copyright © 2023 Stripe. All rights reserved.
//
//  Use of this SDK is subject to the Stripe Terminal Terms:
//  https://stripe.com/terminal/legal
//
#import <Foundation/Foundation.h>

#import <StripeTerminal/SCPCollectInputsResult.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Contains data collected from a Text form

 @see https://stripe.com/docs/terminal/features/collect-inputs
 */
NS_SWIFT_NAME(TextResult)
@interface SCPTextResult : SCPCollectInputsResult

/**
 Represents the collected text. This value is nil if the form was skipped.
 */
@property (nonatomic, nullable, readonly) NSString *text;

/**
 You cannot directly instantiate this class.
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 You cannot directly instantiate this class.
 */
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
