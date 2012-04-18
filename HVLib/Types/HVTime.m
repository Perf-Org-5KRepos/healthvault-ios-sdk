//
//  HVTime.m
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
#import "HVTime.h"

static NSString* const c_element_hour = @"h";
static NSString* const c_element_minute = @"m";
static NSString* const c_element_second = @"s";
static NSString* const c_element_millis = @"f";

@implementation HVTime

-(int) hour
{
    return (m_hours ? m_hours.value : -1);
}

-(void) setHour:(int) hours
{
    if (hours >= 0)
    {
        HVENSURE(m_hours, HVHour);
        m_hours.value = hours;
    }
    else
    {
        HVCLEAR(m_hours);
    }
}

-(int) minute
{
    return (m_minutes ? m_minutes.value : -1);
}

-(void) setMinute:(int)minutes
{
    if (minutes >= 0)
    {
        HVENSURE(m_minutes, HVMinute);
        m_minutes.value = minutes;        
    }
    else
    {
        HVCLEAR(m_minutes);
    }
}

-(BOOL)hasSecond
{
    return (m_seconds != nil);
}

-(int) second
{
    return (m_seconds ? m_seconds.value : -1);
}

-(void) setSecond:(int)seconds
{
    if (seconds >= 0)
    {
        HVENSURE(m_seconds, HVSecond);
        m_seconds.value = seconds;       
    }
    else
    {
        HVCLEAR(m_seconds);
    }
}

-(BOOL)hasMillisecond
{
    return (m_seconds != nil);
}

-(int) millisecond
{
    return (m_milliseconds ? m_milliseconds.value : -1);
}

-(void) setMillisecond:(int)milliseconds
{
    if (milliseconds >= 0)
    {
        HVENSURE(m_milliseconds, HVMillisecond);
        m_milliseconds.value = milliseconds;
        
    }
    else
    {
        HVCLEAR(m_milliseconds);
    }
}

-(id) initWithHour:(int)hour minute:(int)minute second:(int)second
{
    self = [super init];
    HVCHECK_SELF;
    
    m_hours = [[HVHour alloc] initWith:hour];
    m_minutes = [[HVMinute alloc] initWith:minute];
    m_seconds = [[HVSecond alloc] initWith:second];
    
    HVCHECK_TRUE(m_hours && m_minutes && m_seconds);
    
    return self;

LError:
    HVALLOC_FAIL;
}

-(id) initwithComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
    
    return [self initWithHour:[components hour] minute:[components minute] second:[components second]];
     
LError:
    HVALLOC_FAIL;    
}

-(id) initWithDate:(NSDate *)date
{
    HVCHECK_NOTNULL(date);
    
    return [self initwithComponents:[NSCalendar componentsFromDate:date]]; 
      
LError:
    HVALLOC_FAIL;
}

-(void) dealloc
{
    [m_hours release];
    [m_minutes release];
    [m_seconds release];
    [m_milliseconds release];
    [super dealloc];
}

-(NSDateComponents *) toComponents
{
    NSDateComponents *components = [[NSCalendar newComponents] autorelease];
    HVCHECK_NOTNULL(components);
 
    HVCHECK_SUCCESS([self getComponents:components]);     
    
    return components;
    
LError:
    [components release];
    return nil;
}

-(BOOL) getComponents:(NSDateComponents *)components
{
    HVCHECK_NOTNULL(components);
  
    if (m_hours)
    {
        [components setHour:self.hour];
    }
    if (m_minutes)
    {
        [components setMinute:self.minute];        
    }
    if (m_seconds)
    {
        [components setSecond:self.second];
    }
    
    return TRUE;
    
LError:
    return FALSE;
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE(m_hours, HVClientError_InvalidTime);
    HVVALIDATE(m_minutes, HVClientError_InvalidTime);
    HVVALIDATE_OPTIONAL(m_seconds);
    HVVALIDATE_OPTIONAL(m_milliseconds);
    
    HVVALIDATE_SUCCESS;
    
LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE(m_hours, c_element_hour);
    HVSERIALIZE(m_minutes, c_element_minute);
    HVSERIALIZE(m_seconds, c_element_second);
    HVSERIALIZE(m_milliseconds, c_element_millis);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE(m_hours, c_element_hour, HVHour);
    HVDESERIALIZE(m_minutes, c_element_minute, HVMinute);
    HVDESERIALIZE(m_seconds, c_element_second, HVSecond);
    HVDESERIALIZE(m_milliseconds, c_element_millis, HVMillisecond);
}

@end

@implementation HVTimeCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVTime class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

@end