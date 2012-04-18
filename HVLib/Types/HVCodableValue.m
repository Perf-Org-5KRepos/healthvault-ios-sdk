//
//  HVCodableValue.m
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
#import "HVCodableValue.h"

static NSString* const c_element_text = @"text";
static NSString* const c_element_code = @"code";

@implementation HVCodableValue

@synthesize text = m_text;

-(BOOL) hasCodes
{
    return ![NSArray isNilOrEmpty:m_codes];
}

-(NSMutableArray *) codes
{
    HVENSURE(m_codes, HVCodedValueCollection);
    return m_codes;
}

-(void)setCodes:(HVCodedValueCollection *)codes
{
    HVRETAIN(m_codes, codes);
}

-(HVCodedValue *)firstCode
{
    return (self.hasCodes) ? [m_codes itemAtIndex:0] : nil;
}

-(id) initWithText:(NSString *)textValue
{
    return [self initWithText:textValue andCode:nil];
}

-(id) initWithText:(NSString *)textValue andCode:(HVCodedValue *)code
{
    HVCHECK_STRING(textValue);
    
    self = [super init];
    HVCHECK_SELF;
    
    self.text = textValue;
    if (code)
    {
        NSMutableArray *codes = self.codes;
        HVCHECK_NOTNULL(codes);
        [codes addObject:code];
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;    
}

-(id) initWithText:(NSString *)textValue code:(NSString *)code andVocab:(NSString *)vocab
{
    HVCodedValue* codedValue = [[HVCodedValue alloc] initWithCode:code andVocab:vocab];
    HVCHECK_NOTNULL(codedValue);
    
    self = [self initWithText:textValue andCode:codedValue];
    [codedValue release];
    
    return self;

LError:
    HVALLOC_FAIL; 
}

-(void) dealloc
{
    [m_text release];
    [m_codes release];
    [super dealloc];
}

-(NSString *) description
{
    return [self toString];
}

-(NSString *)toString
{
    return m_text;
}

-(HVClientResult *) validate
{
    HVVALIDATE_BEGIN;
    
    HVVALIDATE_STRING(self.text, HVClientError_InvalidCodableValue);
    if (self.hasCodes)
    {
        for (HVCodedValue* code in self.codes)
        {
            HVVALIDATE(code, HVClientError_InvalidCodableValue);
        }
    }
    
    HVVALIDATE_SUCCESS;

LError:
    HVVALIDATE_FAIL;
}

-(void) serialize:(XWriter *)writer
{
    HVSERIALIZE_STRING(m_text, c_element_text);
    HVSERIALIZE_ARRAY(m_codes, c_element_code);
}

-(void) deserialize:(XReader *)reader
{
    HVDESERIALIZE_STRING(m_text, c_element_text);
    HVDESERIALIZE_TYPEDARRAY(m_codes, c_element_code, HVCodedValue, HVCodedValueCollection);
}

@end

@implementation HVCodableValueCollection

-(id)init
{
    self = [super init];
    HVCHECK_SELF;
    
    self.type = [HVCodableValue class];
    
    return self;
    
LError:
    HVALLOC_FAIL;
}

-(HVCodableValue *)itemAtIndex:(NSUInteger)index
{
    return [self objectAtIndex:index];
}

@end