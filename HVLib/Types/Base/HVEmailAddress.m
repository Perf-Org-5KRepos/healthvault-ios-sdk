//
//  HVEmailAddress.m
//  HVLib
//
//  Copyright (c) 2012 Microsoft Corporation. All rights reserved.
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
#import "HVEmailAddress.h"

@implementation HVEmailAddress

-(NSUInteger) minLength
{
    return 6;
}

-(NSUInteger) maxLength
{
    return 128;
}

-(HVClientResult *)validate
{
    HVVALIDATE_BEGIN
    
    HVCHECK_RESULT([super validate]);
    
    HVVALIDATE_TRUE(([self.value indexOfFirstChar:'@'] != NSNotFound), HVClientError_InvalidEmailAddress);
    
    HVVALIDATE_SUCCESS
    
LError:
    HVVALIDATE_FAIL
}

@end