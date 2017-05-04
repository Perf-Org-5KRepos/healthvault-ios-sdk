//
//  MHVFeatureActions.m
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
//

#import "MHVCommon.h"
#import "MHVFeatureActions.h"

@implementation MHVFeatureActions

-(id)init
{
    return [self initWithTitle:nil];
}

-(id)initWithTitle:(NSString *)title
{
    self = [super init];
    MHVCHECK_SELF;
    
    if (!title)
    {
        title = @"Try MORE Features";
    }
    m_actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                        delegate:self
                                        cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                        otherButtonTitles:nil];
    MHVCHECK_NOTNULL(m_actionSheet);
    m_actionSheet.delegate = self;
    
    m_actions = [[NSMutableArray alloc] init];
    MHVCHECK_NOTNULL(m_actions);
    
    return self;
    
LError:
    MHVALLOC_FAIL;
}

-(void)dealloc
{
    m_actionSheet.delegate = nil;
    
}

-(BOOL) addFeature:(NSString *)title andAction:(MHVAction)action
{
    MHVCHECK_NOTNULL(action);
    
    [m_actionSheet addButtonWithTitle:title];
    [m_actions addObject:action]; 
    
    return TRUE;
    
LError:
    return FALSE;
}

-(void)showFrom:(UIBarButtonItem *)button
{
    [m_actionSheet showFromBarButtonItem:button animated:true];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        return;  // Cancel
    }
    @try
    {
        MHVAction action = (MHVAction) [m_actions objectAtIndex:buttonIndex - 1];
        action();
    }
    @catch (NSException *exception)
    {
        [MHVUIAlert showInformationalMessage:exception.description];
    }
}

@end
