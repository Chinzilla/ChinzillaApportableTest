//
//  main.m
//  ApportableTestCases
//
//  Created by Jordan Ferber on 7/18/14.
//  Copyright Jordan Ferber 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
#ifdef ANDROID
    [UIScreen mainScreen].currentMode = [UIScreenMode emulatedMode:UIScreenBestEmulatedMode];
#endif
    
    int retVal = UIApplicationMain(argc, argv, nil, @"AppController");
    [pool release];
    return retVal;
}
