//
//  NSString+Levenshtein Unit Test.m
//  AufflickCocoaAdditions
//
//  Created by Mark Aufflick on 12/11/09.
//

/*
 
 Copyright (c) 2009, Mark Aufflick
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
 * Neither the name of the Mark Aufflick nor the
   names of contributors may be used to endorse or promote products
   derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY MARK AUFFLICK ''AS IS'' AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL MARK AUFFLICK BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */ 


#import "NSString+Levenshtein Unit Test.h"
#import "NSString+Levenshtein.h"

@implementation NSString_Levenshtein_Unit_Test

-(void)testExactMatch
{
    STAssertEquals([@"foo" asciiLevenshteinDistanceWithString:@"foo"],
                   (float)0.0,
                   @"exact match => 0");
}

-(void)testNilStringB
{
    STAssertEquals([@"foo" asciiLevenshteinDistanceWithString:nil],
                   (float)LEV_INF_DISTANCE,
                   @"nil StringB => LEV_INF_DISTANCE");
}

- (void)testSmallDiff
{
    STAssertEquals([@"foo" asciiLevenshteinDistanceWithString:@"food"],
                    (float)1.0,
                    @"1 char added => 1");
}

// test skipping of charset
-(void)testSkippingCharset
{
    NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"123"];
    
    STAssertEquals([@"abc123def" asciiLevenshteinDistanceWithString:@"abcdef"
                                               skippingCharacterSet:charset],
                   (float)0.0,
                   @"tested skippingCharacterSet:");
}

// test that non-ascii is normalised
-(void)testAccents
{
    STAssertEquals([@"flubber" asciiLevenshteinDistanceWithString:@"flübbér"],
                   (float)0.0,
                   @"non-ascii characters are normalised");
}

// examples from Wikipedia Levenshtein page

- (void)testKittens
{
    STAssertEquals([@"kitten" asciiLevenshteinDistanceWithString:@"sitting"],
                   (float)3.0,
                   @"kitten -> sitting => 3");
}

- (void)testWeekend
{
    STAssertEquals([@"Saturday" asciiLevenshteinDistanceWithString:@"Sunday"],
                   (float)3.0,
                   @"Saturday -> Sunday => 3");
}

@end
