//
//  MHVItemChange.m
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
//
//
#import "MHVCommon.h"
#import "MHVItemChange.h"

static const xmlChar* x_element_changeID = XMLSTRINGCONST("changeID");
static const xmlChar* x_element_timestamp = XMLSTRINGCONST("timestamp");
static const xmlChar* x_element_type = XMLSTRINGCONST("type");
static const xmlChar* x_element_typeID = XMLSTRINGCONST("typeID");
static const xmlChar* x_element_key = XMLSTRINGCONST("key");
static const xmlChar* x_element_attempt = XMLSTRINGCONST("attempt");

@interface MHVItemChange (MHVPrivate)

-(void) updateWithKey:(MHVItemKey *) key andChangeType:(enum MHVItemChangeType) type;

@end

@implementation MHVItemChange

@synthesize changeType = m_changeType;
@synthesize changeID = m_changeID;
@synthesize timestamp = m_timestamp;
@synthesize typeID = m_typeID;
-(NSString *)itemID
{
    return m_key.itemID;
}

@synthesize itemKey = m_key;
@synthesize updatedKey = m_updatedKey;
@synthesize localItem = m_localItem;
@synthesize updatedItem = m_updatedItem;
@synthesize attemptCount = m_attempt;

// We need a default vanilla constructor for Xml serialization
-(id)init
{
    return [super init];
}

-(id)initWithTypeID:(NSString *)typeID key:(MHVItemKey *)key changeType:(enum MHVItemChangeType)changeType
{
    MHVCHECK_STRING(typeID);
    MHVCHECK_NOTNULL(key);
    
    self = [super init];
    MHVCHECK_SELF;
    
    m_typeID = typeID;
    [self updateWithKey:key andChangeType:changeType];
    
    return self;
    
LError:
    MHVALLOC_FAIL;
}


-(void)assignNewChangeID
{
    NSString* uniqueId = [@"iOS_" stringByAppendingString:[[NSUUID UUID] UUIDString]];
    m_changeID = uniqueId;
}

-(void)assignNewTimestamp
{
    // Doesn't need to be more than 1 second accuracy. Timestamp is used to give us an approximate sort order for the upload queue
    m_timestamp = [[NSDate date] timeIntervalSinceReferenceDate];
}

-(BOOL)isChangeForType:(NSString *)typeID
{
    return [m_typeID isEqualToString:typeID];
}

-(void)serialize:(XWriter *)writer
{
    [writer writeElementXmlName:x_element_changeID value:m_changeID];
    [writer writeElementXmlName:x_element_timestamp doubleValue:m_timestamp];
    [writer writeElementXmlName:x_element_type intValue:m_changeType];
    [writer writeElementXmlName:x_element_typeID value:m_typeID];
    [writer writeElementXmlName:x_element_key content:m_key];
    [writer writeElementXmlName:x_element_attempt intValue:m_attempt];
}

-(void)deserialize:(XReader *)reader
{
    m_changeID = [reader readStringElementWithXmlName:x_element_changeID];
    m_timestamp = [reader readDoubleElementXmlName:x_element_timestamp];
    
    int changeType;
    changeType = [reader readIntElementXmlName:x_element_type];
    m_changeType = (enum MHVItemChangeType) changeType;
    
    m_typeID = [reader readStringElementWithXmlName:x_element_typeID];
    m_key = [reader readElementWithXmlName:x_element_key asClass:[MHVItemKey class]];
    m_attempt = [reader readIntElementXmlName:x_element_attempt];
}

+(BOOL)updateChange:(MHVItemChange *)change withTypeID:(NSString *)typeID key:(MHVItemKey *)key changeType:(enum MHVItemChangeType)changeType
{
    MHVCHECK_NOTNULL(change);
    
    MHVCHECK_FALSE((change.changeType == MHVItemChangeTypeRemove && changeType == MHVItemChangeTypePut));
    MHVCHECK_TRUE([change isChangeForType:typeID]);
    
    [change updateWithKey:key andChangeType:changeType];
    return TRUE;
 
LError:
    return FALSE;
}

+(NSComparisonResult)compareChange:(MHVItemChange *)x to:(MHVItemChange *)y
{
    NSComparisonResult result = [x.typeID compare:y.typeID];
    if (result == NSOrderedSame)
    {
        if (x.timestamp == y.timestamp)
        {
            result = [x.itemID compare:y.itemID];
        }
        else if (x.timestamp < y.timestamp)
        {
            result = NSOrderedAscending;
        }
        else
        {
            result = NSOrderedDescending;
        }
    }
    return result;
}

@end

@implementation MHVItemChange (MHVPrivate)

-(void)updateWithKey:(MHVItemKey *)key andChangeType:(enum MHVItemChangeType)type
{
    m_key = key;
    m_changeType = type;
    [self assignNewChangeID];
    [self assignNewTimestamp];
}

@end