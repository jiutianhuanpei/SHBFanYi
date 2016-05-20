//
//  TranslateNotification.h
//  MSTranslateVendorDemo
//
//  Created by SHIM MIN SEOK on 13. 7. 14..
//  Copyright (c) 2013 SHIM MIN SEOK. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kRequestTranslate;
extern NSString * const kRequestTranslateArray;
extern NSString * const kRequestDetectLanguage;
extern NSString * const kRequestBreakSentences;

@interface TranslateNotification : NSObject

@property (nonatomic, strong) id translateNotification;
@property (nonatomic, strong) id translateArrayNotification;
@property (nonatomic, strong) id detectNotification;
@property (nonatomic, strong) id breakSentencesNotification;
+ (TranslateNotification*)sharedObject;
@end
