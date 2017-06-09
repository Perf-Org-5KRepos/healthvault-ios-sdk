//
//  MHVDelivery.h
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
#import "MHVOrganization.h"
#import "MHVApproxDateTime.h"
#import "MHVBaby.h"

@interface MHVDelivery : MHVType

@property (readwrite, nonatomic, strong) MHVOrganization *location;
@property (readwrite, nonatomic, strong) MHVApproxDateTime *timeOfDelivery;
@property (readwrite, nonatomic, strong) MHVPositiveDouble *laborDuration;
@property (readwrite, nonatomic, strong) MHVCodableValueCollection *complications;
@property (readwrite, nonatomic, strong) MHVCodableValueCollection *anesthesia;
@property (readwrite, nonatomic, strong) MHVCodableValue *deliveryMethod;
@property (readwrite, nonatomic, strong) MHVCodableValue *outcome;
@property (readwrite, nonatomic, strong) MHVBaby *baby;
@property (readwrite, nonatomic, strong) NSString *note;

@end

@interface MHVDeliveryCollection : MHVCollection<MHVDelivery *>

@end
