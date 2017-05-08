//
//  MHVBlobPayload.m
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
//
#import "MHVCommon.h"
#import "MHVBlobPayload.h"

static NSString* const c_element_blob = @"blob";

@implementation MHVBlobPayload

-(MHVBlobPayloadItemCollection *) items
{
    MHVENSURE(m_blobItems, MHVBlobPayloadItemCollection);
    return m_blobItems;
}

-(BOOL)hasItems
{
    return ![MHVCollection isNilOrEmpty:m_blobItems];
}


-(MHVBlobPayloadItem *)getDefaultBlob
{
    return [self getBlobNamed:c_emptyString];
}

-(MHVBlobPayloadItem *)getBlobNamed:(NSString *)name
{
    if (!self.hasItems)
    {
        return nil;
    }
    
    return [m_blobItems getBlobNamed:name];
}

-(NSURL *)getUrlForBlobNamed:(NSString *)name
{
    MHVBlobPayloadItem* blob = [self getBlobNamed:name];
    if (!blob)
    {
        return nil;
    }
    
    return [NSURL URLWithString:blob.blobUrl];
}

-(BOOL)addOrUpdateBlob:(MHVBlobPayloadItem *)blob
{
    MHVCHECK_NOTNULL(blob);
    
    if (m_blobItems)
    {
        NSUInteger existingIndex = [m_blobItems indexOfBlobNamed:blob.name];
        if (existingIndex != NSNotFound)
        {
            [m_blobItems removeObjectAtIndex:existingIndex];
        }
    }
    
    MHVENSURE(m_blobItems, MHVBlobPayloadItemCollection);
    MHVCHECK_NOTNULL(m_blobItems);
    
    [m_blobItems addObject:blob];
    
    return TRUE;
    
LError:
    return FALSE;
}

-(MHVClientResult *)validate
{
    MHVVALIDATE_BEGIN
    
    MHVVALIDATE_ARRAY(m_blobItems, MHVClientError_InvalidBlobInfo);
    
    MHVVALIDATE_SUCCESS
}

-(void)serialize:(XWriter *)writer
{
    [writer writeElementArray:c_element_blob elements:m_blobItems.toArray];
}

-(void)deserialize:(XReader *)reader
{
    m_blobItems = (MHVBlobPayloadItemCollection *)[reader readElementArray:c_element_blob asClass:[MHVBlobPayloadItem class] andArrayClass:[MHVBlobPayloadItemCollection class]];
}

@end