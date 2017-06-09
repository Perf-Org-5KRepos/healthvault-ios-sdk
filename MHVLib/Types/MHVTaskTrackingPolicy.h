//
//  MHVTaskTrackingPolicy.h
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

#import "MHVType.h"
#import "MHVBool.h"
#import "MHVTaskOccurrenceMetrics.h"
#import "MHVTaskCompletionMetrics.h"
#import "MHVTaskTargetEvents.h"

@interface MHVTaskTrackingPolicy : MHVType

@property (readwrite, nonatomic, strong) MHVBool *isAutoTrackable;
@property (readwrite, nonatomic, strong) MHVStringCollection *sourceTypes;
@property (readwrite, nonatomic, strong) MHVStringCollection *triggerTypes;
@property (readwrite, nonatomic, strong) MHVTaskOccurrenceMetrics *occurrenceMetrics;
@property (readwrite, nonatomic, strong) MHVTaskCompletionMetrics *completionMetrics;
@property (readwrite, nonatomic, strong) MHVTaskTargetEventsCollection *targetEvents;

@end
