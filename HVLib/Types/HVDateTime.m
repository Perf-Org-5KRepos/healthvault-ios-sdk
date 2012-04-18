//
//  DateTime.m
//  HVLib
//
//  Copyright (c) 2012 Microsoft Corporation. All rights reserved.
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

#import "HVCommon.h"
#import "HVDateTime.h"

static NSString* const c_element_date = @"date";
static NSString* const c_element_time = @"time";
static NSString* const c_element_timeZone = @"tz";

@implementation HVDateTime

@synthesize date = m_date;
@synthesize time = m_time;
@synthesize timeZone = m_timeZone;

-(BOOL) hasTime
{
    return (m_time != nil);
}

-(BOOL) hasTimeZone
{
    return (m_timeZone != nil);
}

-(id) initNow
{
    return [self initWithDate:[NSDate date]];
}

-(id) initWithDate:(NSDate *) dateValue
{
    HVCHECK_NOTNULL(dateValue);
    
    NSDateComponents *components = [NSCalendar componentsFromDate:dateValue];
    HVCHECK_NOTNULL(components);
    
    return [self initwithComponents:components];
    
LError:
    HVALLOC_FAIL;
}

-(id) initwithComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    
    self = [super init];
    HVCHECK_SELF;
    
    m_date = [[HVDate alloc] initWithComponents:components];
    m_time = [[HVTime alloc] initwithComponents:components];
    
    HVCHECK_TRUE(m_date && m_time);
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(void) dealloc
{
    [m_date release];
    [m_time release];
    [m_timeZone release];
    [super dealloc];
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *) toString
{
    return [self toStringWithFormat:@"MM/dd/YY hh:mm aaa"];
}

-(NSString *)toStringWithFormat:(NSString *)format
{
    NSDate *date = [self toDate];
    return [date toStringWithFormat:format];
}

-(NSDateComponents *) toComponents
{
    NSDateComponents *components = [NSCalendar newComponents];
    HVCHECK_SUCCESS([self getComponents:components]);
    
    return [components autorelease];
    
LError:
    [components release];
    return nil;
}

-(BOOL) getComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    HVCHECK_NOTNULL(m_date);
    
    [m_date getComponents:components];
    if (m_time)
    {
        [m_time getComponents:components];
    }
    
    return TRUE;
    
LError:
    return FALSE;
}

-(NSDate *) toDate
{
    NSDateComponents *components = [NSCalendar newComponents];
    HVCHECK_NOTNULL(components);
    
    HVCHECK_SUCCESS([self getComponents:components]);
    
    NSDate* newDate = [components date];
    [components release];
    return newDate;

LError:
    [components release];
    return nil;
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_date, HVClientError_InvalidDateTime);
    HVVALIDATE_OPTIONAL(m_time);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE(m_date, c_element_date);
    HVSERIALIZE(m_time, c_element_time);
    HVSERIALIZE(m_timeZone, c_element_timeZone);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_date, c_element_date, HVDate);
    HVDESERIALIZE(m_time, c_element_time, HVTime);
    HVDESERIALIZE(m_timeZone, c_element_timeZone, HVCodableValue);
}

@end