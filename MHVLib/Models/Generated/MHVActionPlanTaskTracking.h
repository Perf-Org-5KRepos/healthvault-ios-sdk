//
// MHVActionPlanTaskTracking.h
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


#import <Foundation/Foundation.h>

#import "MHVActionPlanTaskTrackingEvidence.h"
#import "MHVModelBase.h"


@protocol MHVActionPlanTaskTracking
@end

NS_ASSUME_NONNULL_BEGIN

@interface MHVActionPlanTaskTracking : MHVModelBase

/* Gets or sets the Id of the task tracking [optional]
 */
@property(strong,nonatomic,nullable) NSString* _id;
/* Gets or sets the task tracking type [optional]
 */
@property(strong,nonatomic,nullable) NSString* trackingType;
/* Gets or sets the timezone offset of the task tracking,               if a task is local time based, it should be set as null [optional]
 */
@property(strong,nonatomic,nullable) NSNumber* timeZoneOffset;
/* Gets or sets the task tracking time [optional]
 */
@property(strong,nonatomic,nullable) NSDate* trackingDateTime;
/* Gets or sets the creation time of the task tracking [optional]
 */
@property(strong,nonatomic,nullable) NSDate* creationDateTime;
/* Gets or sets the task tracking status [optional]
 */
@property(strong,nonatomic,nullable) NSString* trackingStatus;
/* Gets or sets the start time of the occurrence window,              it is null for Completion and OutOfWindow tracking [optional]
 */
@property(strong,nonatomic,nullable) NSDate* occurrenceStart;
/* Gets or sets the end time of the occurrence window,              it is null for Completion and OutOfWindow tracking [optional]
 */
@property(strong,nonatomic,nullable) NSDate* occurrenceEnd;
/* Gets or sets the start time of the completion window [optional]
 */
@property(strong,nonatomic,nullable) NSDate* completionStart;
/* Gets or sets the end time of the completion window [optional]
 */
@property(strong,nonatomic,nullable) NSDate* completionEnd;
/* Gets or sets task Id [optional]
 */
@property(strong,nonatomic,nullable) NSString* taskId;
/* Gets or sets the tracking feedback [optional]
 */
@property(strong,nonatomic,nullable) NSString* feedback;
/* Gets or sets the evidence of the task tracking [optional]
 */
@property(strong,nonatomic,nullable) MHVActionPlanTaskTrackingEvidence* evidence;

@end

NS_ASSUME_NONNULL_END