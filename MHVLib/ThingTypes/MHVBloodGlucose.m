//
//  MHVBloodGlucose.m
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
#import "MHVBloodGlucose.h"

static NSString* const c_typeid = @"879e7c04-4e8a-4707-9ad3-b054df467ce4";
static NSString* const c_typename = @"blood-glucose";

static const xmlChar* x_element_when = XMLSTRINGCONST("when");
static const xmlChar* x_element_value = XMLSTRINGCONST("value");
static const xmlChar* x_element_type = XMLSTRINGCONST("glucose-measurement-type");
static const xmlChar* x_element_operatingTemp = XMLSTRINGCONST("outside-operating-temp");
static const xmlChar* x_element_controlTest = XMLSTRINGCONST("is-control-test");
static const xmlChar* x_element_normalcy = XMLSTRINGCONST("normalcy");
static const xmlChar* x_element_context = XMLSTRINGCONST("measurement-context");

static NSString* const c_vocab_measurement = @"glucose-measurement-type";

@interface MHVBloodGlucose (MHVPrivate)

+(MHVCodableValue *) newMeasurementText:(NSString *) text andCode:(NSString *) code;
+(MHVCodedValue *) newMeasurementCode:(NSString *) code;

@end

@implementation MHVBloodGlucose

@synthesize when = m_when;
@synthesize value = m_value;
@synthesize measurementType = m_measurementType;
@synthesize isOutsideOperatingTemp = m_outsideOperatingTemp;
@synthesize isControlTest = m_controlTest;
@synthesize context = m_context;

-(NSDate *)getDate
{
    return [m_when toDate];
}

-(NSDate *)getDateForCalendar:(NSCalendar *)calendar
{
    return [m_when toDateForCalendar:calendar];
}

-(double)inMgPerDL
{
    return (m_value) ? m_value.mgPerDL : NAN;
}

-(void)setInMgPerDL:(double)inMgPerDL
{
    MHVENSURE(m_value, MHVBloodGlucoseMeasurement);
    m_value.mgPerDL = inMgPerDL;
}

-(double)inMmolPerLiter
{
    return (m_value) ? m_value.mmolPerLiter : NAN;
}

-(void)setInMmolPerLiter:(double)inMmolPerLiter
{
    MHVENSURE(m_value, MHVBloodGlucoseMeasurement);
    m_value.mmolPerLiter = inMmolPerLiter;
}

-(MHVRelativeRating)normalcy
{
    return (m_normalcy) ? (MHVRelativeRating) m_normalcy.value : MHVRelativeRating_None;
}

-(void)setNormalcy:(MHVRelativeRating)normalcy
{
    if (normalcy == MHVRelativeRating_None)
    {
        m_normalcy = nil;
    }
    else 
    {
        MHVENSURE(m_normalcy, MHVOneToFive);
        m_normalcy.value = normalcy;
    }
}

-(id)initWithMmolPerLiter:(double)value andDate:(NSDate *)date
{
    MHVCHECK_NOTNULL(date);
    
    self = [super init];
    MHVCHECK_SELF;
    
    self.inMmolPerLiter = value;
    MHVCHECK_NOTNULL(m_value);
    
    m_when = [[MHVDateTime alloc] initWithDate:date];
    MHVCHECK_NOTNULL(m_when);
    
    return self;
    
LError:
    MHVALLOC_FAIL;
}


-(NSString *)stringInMgPerDL:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inMgPerDL];
}

-(NSString *)stringInMmolPerLiter:(NSString *)format
{
    return [NSString localizedStringWithFormat:format, self.inMmolPerLiter];
}

-(NSString *)toString
{
    return [self stringInMmolPerLiter:@"%.3f mmol/L"];
}

-(NSString *)normalcyText
{
    return stringFromRating(self.normalcy);
}

+(MHVCodableValue *)createPlasmaMeasurementType
{
    return [MHVBloodGlucose newMeasurementText:@"Plasma" andCode:@"p"];
}

+(MHVCodableValue *)createWholeBloodMeasurementType
{
    return [MHVBloodGlucose newMeasurementText:@"Whole blood" andCode:@"wb"];
}

+(MHVVocabIdentifier *)vocabForContext
{
    return [[MHVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"glucose-measurement-context"];    
}

+(MHVVocabIdentifier *)vocabForMeasurementType
{
    return [[MHVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"glucose-measurement-type"];    
}

+(MHVVocabIdentifier *)vocabForNormalcy
{
    return [[MHVVocabIdentifier alloc] initWithFamily:c_hvFamily andName:@"normalcy-one-to-five"];    
}

-(MHVClientResult *)validate
{
    MHVVALIDATE_BEGIN
    
    MHVVALIDATE(m_when, MHVClientError_InvalidBloodGlucose);
    MHVVALIDATE(m_value, MHVClientError_InvalidBloodGlucose);
    MHVVALIDATE(m_measurementType, MHVClientError_InvalidBloodGlucose);
    MHVVALIDATE_OPTIONAL(m_outsideOperatingTemp);
    MHVVALIDATE_OPTIONAL(m_controlTest);
    MHVVALIDATE_OPTIONAL(m_normalcy);
    MHVVALIDATE_OPTIONAL(m_context);

    MHVVALIDATE_SUCCESS
}

-(void)serialize:(XWriter *)writer
{
    [writer writeElementXmlName:x_element_when content:m_when];
    [writer writeElementXmlName:x_element_value content:m_value];
    [writer writeElementXmlName:x_element_type content:m_measurementType];
    [writer writeElementXmlName:x_element_operatingTemp content:m_outsideOperatingTemp];
    [writer writeElementXmlName:x_element_controlTest content:m_controlTest];
    [writer writeElementXmlName:x_element_normalcy content:m_normalcy];
    [writer writeElementXmlName:x_element_context content:m_context];
}

-(void)deserialize:(XReader *)reader
{
    m_when = [reader readElementWithXmlName:x_element_when asClass:[MHVDateTime class]];
    m_value = [reader readElementWithXmlName:x_element_value asClass:[MHVBloodGlucoseMeasurement class]];
    m_measurementType = [reader readElementWithXmlName:x_element_type asClass:[MHVCodableValue class]];
    m_outsideOperatingTemp = [reader readElementWithXmlName:x_element_operatingTemp asClass:[MHVBool class]];
    m_controlTest = [reader readElementWithXmlName:x_element_controlTest asClass:[MHVBool class]];
    m_normalcy = [reader readElementWithXmlName:x_element_normalcy asClass:[MHVOneToFive class]];
    m_context = [reader readElementWithXmlName:x_element_context asClass:[MHVCodableValue class]];
}

+(NSString *)typeID
{
    return c_typeid;
}

+(NSString *) XRootElement
{
    return c_typename;
}

+(MHVItem *) newItem
{
    return [[MHVItem alloc] initWithType:[MHVBloodGlucose typeID]];
}

-(NSString *)typeName
{
    return NSLocalizedString(@"Blood Glucose", @"Blood Glucose Type Name");
}

@end

@implementation MHVBloodGlucose (MHVPrivate)
    
+(MHVCodableValue *)newMeasurementText:(NSString *)text andCode:(NSString *)code
{
    MHVCodedValue* codedValue = [MHVBloodGlucose newMeasurementCode:code];
    MHVCodableValue* codableValue = [[MHVCodableValue alloc] initWithText:text andCode:codedValue];
    return codableValue;
}

+(MHVCodedValue *) newMeasurementCode:(NSString *)code
{
    return [[MHVCodedValue alloc] initWithCode:code andVocab:c_vocab_measurement];
}

@end
