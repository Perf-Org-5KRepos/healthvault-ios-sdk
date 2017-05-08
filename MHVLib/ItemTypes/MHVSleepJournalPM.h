//
//  MHVSleepJournalPM.h
//  MHVLib
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

#import <Foundation/Foundation.h>
#import "MHVTypes.h"

enum MHVSleepiness
{
    MHVSleepiness_Unknown,
    MHVSleepiness_VerySleepy,
    MHVSleepiness_Tired,
    MHVSleepiness_Alert,
    MHVSleepiness_WideAwake
};

NSString* stringFromSleepiness(enum MHVSleepiness sleepiness);

@interface MHVSleepJournalPM : MHVItemDataTyped
{
@private
    MHVDateTime* m_when;
    MHVTimeCollection* m_caffeine;
    MHVTimeCollection* m_alcohol;
    MHVOccurenceCollection* m_naps;
    MHVOccurenceCollection* m_exercise;
    MHVPositiveInt* m_sleepiness;
}

//-------------------------
//
// Data
//
//-------------------------
///
// Required
//
@property (readwrite, nonatomic, strong) MHVDateTime* when;
@property (readwrite, nonatomic) enum MHVSleepiness sleepiness;
//
// Optional
//
@property (readwrite, nonatomic, strong) MHVTimeCollection* caffeineIntakeTimes;
@property (readwrite, nonatomic, strong) MHVTimeCollection* alcoholIntakeTimes;
@property (readwrite, nonatomic, strong) MHVOccurenceCollection* naps;
@property (readwrite, nonatomic, strong) MHVOccurenceCollection* exercise;

@property (readonly, nonatomic) BOOL hasCaffeineIntakeTimes;
@property (readonly, nonatomic) BOOL hasAlcoholIntakeTimes;
@property (readonly, nonatomic) BOOL hasNaps;
@property (readonly, nonatomic) BOOL hasExercise;

//-------------------------
//
// Initializers
//
//-------------------------
+(MHVItem *) newItem;

-(NSString *) sleepinessAsString;

//-------------------------
//
// Type info
//
//-------------------------
+(NSString *) typeID;
+(NSString *) XRootElement;


@end