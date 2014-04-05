//
//  NSString+Encryption.m
//  Encryption
//
//  Created by Francisco Javier Álvarez García on 26/01/14.
//  Copyright (c) 2014 Francisco Javier Álvarez García. All rights reserved.
//

#import "NSString+Encryption.h"

#define kEncryptionLength 5

@implementation NSString (Encryption)

-(NSString*)decrypt {
    if (!self || [self length]<kEncryptionLength ) return @"";
    NSMutableString *str;
    NSUInteger selfLength = [self length];
    NSUInteger division = selfLength / kEncryptionLength;
    NSUInteger module = selfLength % kEncryptionLength;
    
    str = [NSMutableString stringWithString:@""];
    
    
    // Start Obtaining Characters
    
    if (module != 0) {
        int i;
        for (i=1;i<=division+1;i++) {
            int j;
            NSRange range;
            range.length = 1;
            range.location = i-1;
            
            for (j=1; j<=module;j++) {
                NSString *newCharachter = [self substringWithRange:range];
                [str appendString:newCharachter];
                
                range.location = range.location + (division+1);
            }
            if (i != division+1) {
                for (j= (int)module+1;j<=kEncryptionLength;j++) {
                    NSString *newCharachter = [self substringWithRange:range];
                    [str appendString:newCharachter];
                    
                    range.location = range.location + division;
                }
            }
        }
    }
    else {
        int i;
        for (i=1;i<=division;i++) {
            int j;
            NSRange range;
            range.length = 1;
            range.location = i-1;
            for (j=1; j<=kEncryptionLength;j++) {
                NSString *newCharachter = [self substringWithRange:range];
                [str appendString:newCharachter];
                
                range.location = range.location + division;
            }
        }
    }
    return [str copy];
}

-(NSString*)encrypt {
    if ( !self || [self length]<kEncryptionLength ) return @"";
    NSMutableString *str;
    NSUInteger selfLength = [self length];
    NSUInteger division = selfLength / kEncryptionLength;
    NSUInteger module = selfLength % kEncryptionLength;
    
    str = [NSMutableString stringWithString:@""];
    
    if (module != 0) {
        int i;
        for (i=1;i<=module;i++) {
            NSRange range;
            range.length = 1;
            range.location = i-1;
            
            int j;
            for (j=1;j<=division+1;j++) {
                NSString *newCharachter = [self substringWithRange:range];
                [str appendString:newCharachter];
                
                range.location = range.location + kEncryptionLength;
            }
        }
        
        NSUInteger restoDeDivisiones = (selfLength - module * (division+1))/division;
        
        for (i=(int)module+1;i<=(int)restoDeDivisiones+module;i++) {
            NSRange range;
            range.length = 1;
            range.location = i-1;
            
            int j;
            for (j=1;j<=division;j++) {
                NSString *newCharachter = [self substringWithRange:range];
                [str appendString:newCharachter];
                
                range.location = range.location + kEncryptionLength;
            }
        }
    }
    else {
        int i;
        for (i=1;i<=selfLength/division;i++) {
            NSRange range;
            range.length = 1;
            range.location = i-1;
            
            int j;
            for (j=1;j<=division;j++) {
                NSString *newCharachter = [self substringWithRange:range];
                [str appendString:newCharachter];
                
                range.location = range.location + kEncryptionLength;
            }
        }
    }
    
    return str;
}

@end
