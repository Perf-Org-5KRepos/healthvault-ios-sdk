//
//  MHVExerciseFactory.m
//  SDKFeatures
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

#import "MHVExerciseFactory.h"

@implementation MHVExercise (MHVFactoryMethods)

+(MHVItemCollection *) createRandomForDay:(NSDate *) date
{
    return [MHVExercise createRandomForDay:date metric:FALSE];
}

+(MHVItemCollection *)createRandomMetricForDay:(NSDate *)date
{
    return [MHVExercise createRandomForDay:date metric:TRUE];
}

+(MHVItemCollection *)createRandomForDay:(NSDate *)date metric:(BOOL)metric
{
    MHVItemCollection* items = [[MHVItemCollection alloc] init];
    //
    // Create 2 entries per day - MOST days. This person really likes to exercise!
    // 
    MHVApproxDateTime* approxDateTime = [MHVApproxDateTime fromDate:date];
    approxDateTime.dateTime.time.hour = [MHVRandom randomIntInRangeMin:7 max:9];
    
    [items addObject:[MHVExercise createRandomForDate:approxDateTime metric:metric]];
    
    approxDateTime = [MHVApproxDateTime fromDate:date];
    approxDateTime.dateTime.time.hour = [MHVRandom randomIntInRangeMin:16 max:19];
    
    [items addObject:[MHVExercise createRandomForDate:approxDateTime metric:metric]];
    
    return items;    
}

@end

@implementation MHVExercise (MHVDisplay)

-(NSString *)detailsString
{
    if (self.durationMinutes)
    {
        return [NSString stringWithFormat:@"%@ [%.0f minutes]", self.activity.description, self.durationMinutesValue];        
    }
    
    return self.activity.description;
}

-(NSString *)detailsStringMetric
{
    return [self detailsString];
}

@end
