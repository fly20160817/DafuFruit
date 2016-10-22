//
//  TimeUtility.h
//  MyFirstApp
//
//  Created by admin on 16/9/9.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

+ (NSNumber *) timestamp;

//那时的时间
+ (NSMutableDictionary *)dateThen:(NSNumber *)timestamp;

//屏幕宽高
+ (CGFloat) screenWidth;
+ (CGFloat) screenHeiht;

@end
