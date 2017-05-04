//
//  MHVBool.m
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
#import "MHVBool.h"

@implementation MHVBool

@synthesize value = m_value;

-(id) initWith:(BOOL)value
{
    self = [super init];
    MHVCHECK_SELF;
    
    m_value = value;
    
    return self;
    
LError:
    MHVALLOC_FAIL;
}

-(NSString *) description
{
    return (m_value) ? @"Yes" : @"No";
}

-(void) serialize:(XWriter *)writer
{
    [writer writeBool:m_value];
}

-(void) deserialize:(XReader *)reader
{
    m_value = [reader readBool];
}

@end
