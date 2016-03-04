//
//  JailBreaking.m
//  CYSBreakOutTestDemo
//
//  Created by YS_Chan on 16/1/14.
//  Copyright © 2016年 YS_Chan. All rights reserved.
//

#import "JailBreaking.h"

@implementation JailBreaking
+ (BOOL)hasJailBroken{
    JailBreaking *jail = [[JailBreaking alloc]init];
    if ([jail isJailBreakAmethod] ||
        [jail isJailBreakBmethod] ||
        [jail isJailBreakCmethod] ||
        [jail isJailBreakDmethod]) {
        NSLog(@"该机已经越狱！");
        return YES;
    }else{
        NSLog(@"没有越狱");
        return NO;
    }
    
}

#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])
const char* jailbreak_tool_pathes[] = {
    "/Applications/Cydia.app",
    "/Library/MobileSubstrate/MobileSubstrate.dylib",
    "/bin/bash",
    "/usr/sbin/sshd",
    "/etc/apt"
};

- (BOOL)isJailBreakAmethod
{
    for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

//
- (BOOL)isJailBreakBmethod
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        NSLog(@"The device is jail broken!");
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

//
#define USER_APP_PATH     @"/User/Applications/"
- (BOOL)isJailBreakCmethod
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH]) {
        NSLog(@"The device is jail broken!");
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:USER_APP_PATH error:nil];
        NSLog(@"applist = %@", applist);
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

//
char* printEnv(void)
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"%s", env);
    return env;
}

- (BOOL)isJailBreakDmethod
{
    if (printEnv()) {
        NSLog(@"The device is jail broken!");
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}
@end
