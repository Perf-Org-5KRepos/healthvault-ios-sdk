//
//  HVMessageAttachment.h
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

#import <Foundation/Foundation.h>
#import "HVType.h"

@interface HVMessageAttachment : HVType
{
@private
    NSString* m_name;
    NSString* m_blobName;
    BOOL m_isInline;
    NSString* m_contentID;
}

@property (readwrite, nonatomic, strong) NSString* name;
@property (readwrite, nonatomic, strong) NSString* blobName;
@property (readwrite, nonatomic) BOOL isInline;
@property (readwrite, nonatomic, strong) NSString* contentID;

-(id) initWithName:(NSString *) name andBlobName:(NSString *) blobName;

@end

@interface HVMessageAttachmentCollection : HVCollection

-(HVMessageAttachment *) itemAtIndex:(NSUInteger) index;

@end
