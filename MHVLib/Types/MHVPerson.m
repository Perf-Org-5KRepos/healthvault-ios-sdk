//
//  MHVPerson.m
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
#import "MHVPerson.h"

static NSString* const c_element_name = @"name";
static NSString* const c_element_organization = @"organization";
static NSString* const c_element_training = @"professional-training";
static NSString* const c_element_idNumber = @"id";
static NSString* const c_element_contact = @"contact";
static NSString* const c_element_type = @"type";

@implementation MHVPerson

@synthesize name = m_name;
@synthesize organization = m_organization;
@synthesize training = m_training;
@synthesize idNumber = m_id;
@synthesize contact = m_contact;
@synthesize type = m_type;

-(id)initWithName:(NSString *)name andEmail:(NSString *)email
{
    return [self initWithName:name phone:nil andEmail:email];
}

-(id)initWithName:(NSString *)name andPhone:(NSString *)number
{
    return [self initWithName:name phone:number andEmail:nil];
}

-(id)initWithName:(NSString *)name phone:(NSString *)number andEmail:(NSString *)email
{
    self = [super init];
    MHVCHECK_SELF;
    
    m_name = [[MHVName alloc] initWithFullName:name];
    MHVCHECK_NOTNULL(m_name);
    
    m_contact = [[MHVContact alloc] initWithPhone:number andEmail:email];
    MHVCHECK_NOTNULL(m_contact);
    
    return self;
    
LError:
    MHVALLOC_FAIL;
}

-(id)initWithFirstName:(NSString *)first lastName:(NSString *)last andEmail:(NSString *)email
{
    return [self initWithFirstName:first lastName:last phone:nil andEmail:email];
}

-(id)initWithFirstName:(NSString *)first lastName:(NSString *)last andPhone:(NSString *)number
{
    return [self initWithFirstName:first lastName:last phone:number andEmail:nil];
}

-(id)initWithFirstName:(NSString *)first lastName:(NSString *)last phone:(NSString *)phone andEmail:(NSString *)email
{
    self = [super init];
    MHVCHECK_SELF;
    
    m_name = [[MHVName alloc] initWithFirst:first andLastName:last];
    MHVCHECK_NOTNULL(m_name);
    
    m_contact = [[MHVContact alloc] initWithPhone:phone andEmail:email];
    MHVCHECK_NOTNULL(m_contact);
    
    return self;
    
LError:
    MHVALLOC_FAIL;
}


-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return (m_name) ? [m_name toString] : c_emptyString;
}

+(MHVVocabIdentifier *)vocabForPersonType
{
    return [[MHVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"person-types"];                
}

-(MHVClientResult *)validate
{
    MHVVALIDATE_BEGIN
    
    MHVVALIDATE(m_name, MHVClientError_InvalidPerson);
    MHVVALIDATE_OPTIONAL(m_contact);
    
    MHVVALIDATE_SUCCESS
}

-(void)serialize:(XWriter *)writer
{
    [writer writeElement:c_element_name content:m_name];
    [writer writeElement:c_element_organization value:m_organization];
    [writer writeElement:c_element_training value:m_training];
    [writer writeElement:c_element_idNumber value:m_id];
    [writer writeElement:c_element_contact content:m_contact];
    [writer writeElement:c_element_type content:m_type];
}

-(void)deserialize:(XReader *)reader
{
    m_name = [reader readElement:c_element_name asClass:[MHVName class]];
    m_organization = [reader readStringElement:c_element_organization];
    m_training = [reader readStringElement:c_element_training];
    m_id = [reader readStringElement:c_element_idNumber];
    m_contact = [reader readElement:c_element_contact asClass:[MHVContact class]];
    m_type = [reader readElement:c_element_type asClass:[MHVCodableValue class]];
}

@end