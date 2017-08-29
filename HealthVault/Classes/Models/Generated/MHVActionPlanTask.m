//
// MHVActionPlanTask.m
// MHVLib
//
// Copyright (c) 2017 Microsoft Corporation. All rights reserved.
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

/**
* NOTE: This class is auto generated by the swagger code generator program.
* https://github.com/swagger-api/swagger-codegen.git
* Do not edit the class manually.
*/


#import "MHVActionPlanTask.h"

@implementation MHVActionPlanTask

+ (BOOL)shouldValidateProperties
{
    return YES;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    // initialize property's default value, if any
    
  }
  return self;
}



+ (NSDictionary *)propertyNameMap
{
    static dispatch_once_t once;
    static NSMutableDictionary *names = nil;
    dispatch_once(&once, ^{
        names = [[super propertyNameMap] mutableCopy];
        [names addEntriesFromDictionary:@{
            @"taskKey": @"taskKey",
            @"name": @"name",
            @"shortDescription": @"shortDescription",
            @"longDescription": @"longDescription",
            @"imageUrl": @"imageUrl",
            @"thumbnailImageUrl": @"thumbnailImageUrl",
            @"taskType": @"taskType",
            @"trackingPolicy": @"trackingPolicy",
            @"signupName": @"signupName",
            @"associatedPlanId": @"associatedPlanId",
            @"associatedObjectiveIds": @"associatedObjectiveIds",
            @"completionType": @"completionType",
            @"frequencyTaskCompletionMetrics": @"frequencyTaskCompletionMetrics",
            @"schedules": @"schedules"
        }];
    });
    return names;
}

+ (NSDictionary *)objectParametersMap
{
    static dispatch_once_t once;
    static NSMutableDictionary *types = nil;
    dispatch_once(&once, ^{
        types = [[super objectParametersMap] mutableCopy];
        [types addEntriesFromDictionary:@{
            @"taskType": [MHVActionPlanTaskTaskTypeEnum class],
            @"trackingPolicy": [MHVActionPlanTrackingPolicy class],
            @"completionType": [MHVActionPlanTaskCompletionTypeEnum class],
            @"frequencyTaskCompletionMetrics": [MHVActionPlanFrequencyTaskCompletionMetrics class],
            @"schedules": [MHVSchedule class]

        }];
    });
    return types;
}
@end
@implementation MHVActionPlanTaskTaskTypeEnum

-(NSDictionary *)enumMap
{
    return @{
        @"Unknown": @"Unknown",
        @"BloodPressure": @"BloodPressure",
        @"Other": @"Other",
    };
}

+(MHVActionPlanTaskTaskTypeEnum *)MHVUnknown
{
    return [[MHVActionPlanTaskTaskTypeEnum alloc] initWithString:@"Unknown"];
}
+(MHVActionPlanTaskTaskTypeEnum *)MHVBloodPressure
{
    return [[MHVActionPlanTaskTaskTypeEnum alloc] initWithString:@"BloodPressure"];
}
+(MHVActionPlanTaskTaskTypeEnum *)MHVOther
{
    return [[MHVActionPlanTaskTaskTypeEnum alloc] initWithString:@"Other"];
}
@end
@implementation MHVActionPlanTaskCompletionTypeEnum

-(NSDictionary *)enumMap
{
    return @{
        @"Unknown": @"Unknown",
        @"Frequency": @"Frequency",
        @"Scheduled": @"Scheduled",
    };
}

+(MHVActionPlanTaskCompletionTypeEnum *)MHVUnknown
{
    return [[MHVActionPlanTaskCompletionTypeEnum alloc] initWithString:@"Unknown"];
}
+(MHVActionPlanTaskCompletionTypeEnum *)MHVFrequency
{
    return [[MHVActionPlanTaskCompletionTypeEnum alloc] initWithString:@"Frequency"];
}
+(MHVActionPlanTaskCompletionTypeEnum *)MHVScheduled
{
    return [[MHVActionPlanTaskCompletionTypeEnum alloc] initWithString:@"Scheduled"];
}
@end
