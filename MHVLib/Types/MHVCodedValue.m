//
//  MHVCodedValue.m
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
#import "MHVCodedValue.h"


static const xmlChar* x_element_value = XMLSTRINGCONST("value");
static const xmlChar* x_element_family = XMLSTRINGCONST("family");
static const xmlChar* x_element_type = XMLSTRINGCONST("type");
static const xmlChar* x_element_version = XMLSTRINGCONST("version");

@implementation MHVCodedValue

@synthesize code = m_code;
@synthesize vocabularyName = m_vocab;
@synthesize vocabularyFamily = m_family;
@synthesize vocabularyVersion = m_version;

-(id) initWithCode:(NSString *)code andVocab:(NSString *)vocab
{
    return [self initWithCode:code vocab:vocab vocabFamily:nil vocabVersion:nil];
}

-(id)initWithCode:(NSString *)code vocab:(NSString *)vocab vocabFamily:(NSString *)family vocabVersion:(NSString *)version
{    
    MHVCHECK_STRING(code);
    MHVCHECK_STRING(vocab);
    
    self = [super init];
    MHVCHECK_SELF;
    
    self.code = code;
    self.vocabularyName = vocab;
    if (family)
    {
        self.vocabularyFamily = family;
    }
    if (version)
    {
        self.vocabularyVersion = version;
    }
    return self;
    
LError:
    MHVALLOC_FAIL;
}


+(MHVCodedValue *)fromCode:(NSString *)code andVocab:(NSString *)vocab
{
    return [[MHVCodedValue alloc] initWithCode:code andVocab:vocab];
}

+(MHVCodedValue *)fromCode:(NSString *)code vocab:(NSString *)vocab vocabFamily:(NSString *)family vocabVersion:(NSString *)version
{
    return [[MHVCodedValue alloc] initWithCode:code vocab:vocab vocabFamily:family vocabVersion:version];
}

-(BOOL)isEqualToCodedValue:(MHVCodedValue *)value
{
    if (value == nil)
    {
        return FALSE;
    }
    
    return (
                ((m_vocab == nil && value.vocabularyName == nil) || [m_vocab isEqualToString:value.vocabularyName])
            &&  ((m_code == nil && value.code == nil) || [m_code isEqualToString:value.code])
            &&  ((m_family == nil && value.vocabularyFamily == nil) || [m_family isEqualToString:value.vocabularyFamily])
            &&  ((m_version == nil && value.vocabularyVersion == nil) || [m_version isEqualToString:value.vocabularyVersion])
            );
}

-(BOOL)isEqualToCode:(NSString *)code fromVocab:(NSString *)vocabName
{
    return ([m_code isEqualToString:code] && [m_vocab isEqualToString:vocabName]);
}

-(BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[MHVCodedValue class]])
    {
        return FALSE;
    }
    
    return [self isEqualToCodedValue:(MHVCodedValue *) object];
}

-(MHVCodedValue *)clone
{
    MHVCodedValue* cloned = [[MHVCodedValue alloc] init];
    MHVCHECK_NOTNULL(cloned);
    
    cloned.code = m_code;
    cloned.vocabularyName = m_vocab;
    cloned.vocabularyFamily = m_family;
    cloned.vocabularyVersion = m_version;
    
    return cloned;
    
LError:
    return nil;
}

-(MHVClientResult *) validate
{
    MHVVALIDATE_BEGIN; 
    
    MHVVALIDATE_STRING(m_code, MHVClientError_InvalidCodedValue);
    MHVVALIDATE_STRING(m_vocab, MHVClientError_InvalidCodedValue);
    MHVVALIDATE_STRINGOPTIONAL(m_family, MHVClientError_InvalidCodedValue);
    MHVVALIDATE_STRINGOPTIONAL(m_version, MHVClientError_InvalidCodedValue);
    
    MHVVALIDATE_SUCCESS;
}

-(void) serialize:(XWriter *)writer
{
    [writer writeElementXmlName:x_element_value value:m_code];
    [writer writeElementXmlName:x_element_family value:m_family];
    [writer writeElementXmlName:x_element_type value:m_vocab];
    [writer writeElementXmlName:x_element_version value:m_version];
}

-(void) deserialize:(XReader *)reader
{
    m_code = [reader readStringElementWithXmlName:x_element_value];
    m_family = [reader readStringElementWithXmlName:x_element_family];
    m_vocab = [reader readStringElementWithXmlName:x_element_type];
    m_version = [reader readStringElementWithXmlName:x_element_version];
}

@end

@implementation MHVCodedValueCollection

-(id) init
{
    self = [super init];
    MHVCHECK_SELF;
    
    self.type = [MHVCodedValue class];
    
    return self;
    
LError:
    MHVALLOC_FAIL;
}

-(MHVCodedValue *)firstCode
{
    return [self itemAtIndex:0];
}

-(MHVCodedValue *)itemAtIndex:(NSUInteger)index
{
    return (MHVCodedValue *) [self objectAtIndex:index];
}

-(NSUInteger)indexOfCode:(MHVCodedValue *)code
{
    for (NSUInteger i = 0, count = self.count; i < count; ++i)
    {
        if ([[self itemAtIndex:i] isEqualToCodedValue:code])
        {
            return i;
        }
    }
    
    return NSNotFound;
}

-(BOOL)containsCode:(MHVCodedValue *)code
{
    return ([self indexOfCode:code] != NSNotFound);
}

@end
