//
//  HVQuestionAnswer.m
//  HVLib
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

#import "HVCommon.h"
#import "HVQuestionAnswer.h"

static NSString* const c_typeid = @"55d33791-58de-4cae-8c78-819e12ba5059";
static NSString* const c_typename = @"question-answer";

static NSString* const c_element_when = @"when";
static NSString* const c_element_question = @"question";
static NSString* const c_element_choice = @"answer-choice";
static NSString* const c_element_answer = @"answer";

@implementation HVQuestionAnswer

@synthesize when = m_when;
@synthesize question = m_question;

-(HVCodableValueCollection *)answerChoices
{
    HVENSURE(m_answerChoices, HVCodableValueCollection);
    return m_answerChoices;
}

-(void)setAnswerChoices:(HVCodableValueCollection *)answerChoices
{
    m_answerChoices = answerChoices;
}

-(HVCodableValueCollection *)answers
{
    HVENSURE(m_answers, HVCodableValueCollection);
    return m_answers;
}

-(void)setAnswers:(HVCodableValueCollection *)answers
{
    m_answers = answers;
}

-(HVCodableValue *)firstAnswer
{
    return (self.hasAnswers) ? [m_answers itemAtIndex:0] : nil;
}

-(BOOL)hasAnswerChoices
{
    return ![NSArray isNilOrEmpty:m_answerChoices];
}

-(BOOL)hasAnswers
{
    return ![NSArray isNilOrEmpty:m_answers];
}


-(id)initWithQuestion:(NSString *)question andDate:(NSDate *)date
{
    return [self initWithQuestion:question answer:nil andDate:date];
}

-(id)initWithQuestion:(NSString *)question answer:(NSString *)answer andDate:(NSDate *)date
{
    HVCHECK_NOTNULL(question);
    HVCHECK_NOTNULL(date);
    
    self = [super init];
    HVCHECK_SELF;
    
    m_when = [[HVDateTime alloc] initWithDate:date];
    HVCHECK_NOTNULL(m_when);
    
    m_question = [[HVCodableValue alloc] initWithText:question];
    HVCHECK_NOTNULL(m_question);
    
    if (answer)
    {
        HVCodableValue* answerValue = [[HVCodableValue alloc] initWithText:answer];
        HVCHECK_NOTNULL(answerValue);
        
        [self.answers addObject:answerValue];
        HVCHECK_NOTNULL(m_answers);
    }
    
    return self;
    
LError:
    HVALLOC_FAIL;
}


-(NSDate *)getDate
{
    return [m_when toDate];
}

-(NSDate *)getDateForCalendar:(NSCalendar *)calendar
{
    return [m_when toDateForCalendar:calendar];
}

-(NSString *)description
{
    return [self toString];
}

-(NSString *)toString
{
    return [NSString stringWithFormat:@"%@ %@", 
            m_question ? [m_question toString] : c_emptyString,
            self.firstAnswer ? [self.firstAnswer toString] : c_emptyString
            ];
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVVALIDATE(m_when, HVClientError_InvalidQuestionAnswer);
    HVVALIDATE(m_question, HVClientError_InvalidQuestionAnswer);
    HVVALIDATE_ARRAYOPTIONAL(m_answerChoices, HVClientError_InvalidQuestionAnswer);
    HVVALIDATE_ARRAYOPTIONAL(m_answers, HVClientError_InvalidQuestionAnswer);
    
    HVVALIDATE_SUCCESS
}

-(void)serialize:(XWriter *)writer
{
    [writer writeElement:c_element_when content:m_when];
    [writer writeElement:c_element_question content:m_question];
    [writer writeElementArray:c_element_choice elements:m_answerChoices];
    [writer writeElementArray:c_element_answer elements:m_answers];
}

-(void)deserialize:(XReader *)reader
{
    m_when = [reader readElement:c_element_when asClass:[HVDateTime class]];
    m_question = [reader readElement:c_element_question asClass:[HVCodableValue class]];
    m_answerChoices = (HVCodableValueCollection *)[reader readElementArray:c_element_choice asClass:[HVCodableValue class] andArrayClass:[HVCodableValueCollection class]];
    m_answers = (HVCodableValueCollection *)[reader readElementArray:c_element_answer asClass:[HVCodableValue class] andArrayClass:[HVCodableValueCollection class]];
}

+(NSString *)typeID
{
    return c_typeid;
}

+(NSString *) XRootElement
{
    return c_typename;
}

+(HVItem *) newItem
{
    return [[HVItem alloc] initWithType:[HVQuestionAnswer typeID]];
}

@end
