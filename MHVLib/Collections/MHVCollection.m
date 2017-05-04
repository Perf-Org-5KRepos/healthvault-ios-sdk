//
//  MHVCollection.m
//  MHVLib
//
//  Copyright (c) 2017 Microsoft Corporation. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MHVCommon.h"
#import "MHVCollection.h"

@implementation MHVCollection

@synthesize type = m_type;

-(id) init
{
    self = [super init];
    MHVCHECK_SELF;
    
    m_inner = [[NSMutableArray alloc] init];
    MHVCHECK_NOTNULL(m_inner);
    
    return self;

LError:
    MHVALLOC_FAIL;
}

-(id)initWithCapacity:(NSUInteger)numItems
{
    self = [super init];
    MHVCHECK_SELF;

    m_inner = [[NSMutableArray alloc] initWithCapacity:numItems];
    MHVCHECK_NOTNULL(m_inner);
    
    return self;
    
LError:
    MHVALLOC_FAIL;
}


-(NSUInteger) count
{
    return [m_inner count];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [m_inner objectAtIndex:index];
}

-(void) addObject:(id)anObject
{
    [self validateNewObject:anObject];
    [m_inner addObject:anObject];
}

-(void) insertObject:(id)anObject atIndex:(NSUInteger)index
{
    [self validateNewObject:anObject];
    [m_inner insertObject:anObject atIndex:index];
}

-(void) replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    [self validateNewObject:anObject];
    [m_inner replaceObjectAtIndex:index withObject:anObject];
}

-(void) removeObjectAtIndex:(NSUInteger)index
{
    [m_inner removeObjectAtIndex:index];
}

-(void) removeLastObject
{
    [m_inner removeLastObject];
}

-(void) validateNewObject:(id)obj
{
    if (obj == nil)
    {
        [NSException throwInvalidArg];
    }
    if (m_type)
    {
        if (!IsNsNull(obj) && ![obj isKindOfClass:m_type])
        {
            [NSException throwInvalidArgWithReason:[NSString stringWithFormat:@"%@ expected", [m_type description]]];
        }
    }
}

-(NSString *)toString
{
    if (self.count == 0)
    {
        return c_emptyString;
    }
    
    NSMutableString* text = [[NSMutableString alloc] init];
    
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        id obj = [self objectAtIndex:i];
        NSString* descr = [obj description];
        if ([NSString isNilOrEmpty:descr])
        {
            continue;
        }
        if (i > 0)
        {
            [text appendNewLine];
        }
        [text appendString:descr];
    }
    
    return text;
}


-(NSString *)description
{
    return [self toString];
}

-(id)mutableCopy
{
    MHVCollection* copy = [[[self class] alloc] init];
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        [copy addObject:[self objectAtIndex:i]];
    }
    return copy;
}

@end

@implementation MHVStringCollection

-(id) init
{
    self = [super init];
    MHVCHECK_SELF;
    
    self.type = [NSString class];
    return self;
    
LError:
    MHVALLOC_FAIL;
}

-(BOOL) containsString:(NSString *)value
{
    return ([self indexOfString:value] != NSNotFound);
}

-(NSUInteger) indexOfString:(NSString *)value
{
    return [self indexOfString:value startingAt:0];
}

-(NSUInteger) indexOfString:(NSString *)value startingAt:(NSUInteger)index
{
    if (!value)
    {
        return NSNotFound;
    }
    
    for (NSUInteger i = index, count = m_inner.count; i < count; ++i)
    {
        if ([[m_inner objectAtIndex:i] isEqualToString:value])
        {
            return i;
        }
    }

    return NSNotFound;
}

-(BOOL) removeString:(NSString *)value
{
    MHVCHECK_NOTNULL(value);
    
    NSUInteger index = [self indexOfString:value];
    if (index == NSNotFound)
    {
        return NO;
    }
    
    [self removeObjectAtIndex:index];
    return TRUE;
    
LError:
    return FALSE;
}

-(MHVStringCollection *)selectStringsFoundInSet:(NSArray *)testSet
{
    MHVStringCollection* matches = nil;
    for (int i = 0, count = (int)testSet.count; i < count; ++i)
    {
        NSString* testString = [testSet objectAtIndex:i];
        if ([self containsString:testString]) 
        {
            if (!matches)
            {
                matches = [[MHVStringCollection alloc] init];
            }
            [matches addObject:testString];
        }
    }
    
    return matches;
}

-(MHVStringCollection *)selectStringsNotFoundInSet:(NSArray *)testSet
{
    MHVStringCollection* matches = nil;
    for (int i = 0, count = (int)testSet.count; i < count; ++i)
    {
        NSString* testString = [testSet objectAtIndex:i];
        if (![self containsString:testString]) 
        {
            if (!matches)
            {
                matches = [[MHVStringCollection alloc] init];
            }
            [matches addObject:testString];
        }
    }
    
    return matches;    
}

@end
