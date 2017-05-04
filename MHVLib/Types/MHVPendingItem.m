//
//  MHVPendingItem.m
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
#import "MHVPendingItem.h"

static const xmlChar* x_element_id = XMLSTRINGCONST("thing-id");
static const xmlChar* x_element_type = XMLSTRINGCONST("type-id");
static const xmlChar* x_element_edate = XMLSTRINGCONST("eff-date");

@implementation MHVPendingItem

@synthesize key = m_id;
@synthesize type = m_type;
@synthesize effectiveDate = m_effectiveDate;


-(MHVClientResult *) validate
{
    MHVVALIDATE_BEGIN;
    
    MHVVALIDATE(m_id, MHVClientError_InvalidPendingItem);
    MHVVALIDATE_OPTIONAL(m_type);
    
    MHVVALIDATE_SUCCESS;
}

-(void) serialize:(XWriter *)writer
{
    [writer writeElementXmlName:x_element_id content:m_id];
    [writer writeElementXmlName:x_element_type content:m_type];
    [writer writeElementXmlName:x_element_edate dateValue:m_effectiveDate];
}

-(void) deserialize:(XReader *)reader
{
    m_id = [reader readElementWithXmlName:x_element_id asClass:[MHVItemKey class]];
    m_type = [reader readElementWithXmlName:x_element_type asClass:[MHVItemType class]];
    m_effectiveDate = [reader readDateElementXmlName:x_element_edate];
}

@end

@implementation MHVPendingItemCollection

-(id) init
{
    self = [super init];
    MHVCHECK_SELF;
    
    self.type = [MHVPendingItem class];
    
    return self;
    
LError:
    MHVALLOC_FAIL;
}

@end

