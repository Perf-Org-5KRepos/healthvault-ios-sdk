//
//  MHVTaskThingTests.m
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

#import <XCTest/XCTest.h>
#import "Kiwi.h"
#import "MHVTaskThing.h"

SPEC_BEGIN(MHVTaskThingTests)

describe(@"MHVTaskThing", ^
         {
             NSString *objectDefinition = @"<task><date-started><date><y>2017</y><m>6</m><d>7</d></date><time><h>15</h><m>34</m><s>47</s><f>119</f></time></date-started><name>Time to wake up</name><short-description>Set a consistent wake time to help regulate your body's internal clock.</short-description><long-description>Studies show that waking up at a consistent time every day, even on weekends, is one of the best ways to ensure a good night’s sleep.</long-description><is-reminder-enabled>true</is-reminder-enabled><status>InProgress</status><type>12340000-0000-0000-0000-000000000000</type><schedules><schedule><start-date-time><date><y>2017</y><m>6</m><d>12</d></date><time><h>8</h><m>30</m><s>0</s></time></start-date-time><schedule-type>Local</schedule-type><recurrence-type>Weekly</recurrence-type><group-id>17b303ab-dd8d-4ba6-839f-da24487949aa</group-id><multiple>1</multiple><adherence-window-in-minutes>30</adherence-window-in-minutes></schedule><schedule><start-date-time><date><y>2017</y><m>6</m><d>13</d></date><time><h>8</h><m>30</m><s>0</s></time></start-date-time><schedule-type>Local</schedule-type><recurrence-type>Weekly</recurrence-type><group-id>17b303ab-dd8d-4ba6-839f-da24487949aa</group-id><multiple>1</multiple><adherence-window-in-minutes>30</adherence-window-in-minutes></schedule><schedule><start-date-time><date><y>2017</y><m>6</m><d>7</d></date><time><h>8</h><m>30</m><s>0</s></time></start-date-time><schedule-type>Local</schedule-type><recurrence-type>Weekly</recurrence-type><group-id>17b303ab-dd8d-4ba6-839f-da24487949aa</group-id><multiple>1</multiple><adherence-window-in-minutes>30</adherence-window-in-minutes></schedule><schedule><start-date-time><date><y>2017</y><m>6</m><d>8</d></date><time><h>8</h><m>30</m><s>0</s></time></start-date-time><schedule-type>Local</schedule-type><recurrence-type>Weekly</recurrence-type><group-id>17b303ab-dd8d-4ba6-839f-da24487949aa</group-id><multiple>1</multiple><adherence-window-in-minutes>30</adherence-window-in-minutes></schedule><schedule><start-date-time><date><y>2017</y><m>6</m><d>9</d></date><time><h>8</h><m>30</m><s>0</s></time></start-date-time><schedule-type>Local</schedule-type><recurrence-type>Weekly</recurrence-type><group-id>17b303ab-dd8d-4ba6-839f-da24487949aa</group-id><multiple>1</multiple><adherence-window-in-minutes>30</adherence-window-in-minutes></schedule><schedule><start-date-time><date><y>2017</y><m>6</m><d>12</d></date><time><h>8</h><m>45</m><s>0</s></time></start-date-time><schedule-type>Local</schedule-type><recurrence-type>Weekly</recurrence-type><group-id>bf806518-b526-4b15-98a2-900d7a68873e</group-id><multiple>1</multiple><minutes-to-remind-before>0</minutes-to-remind-before><adherence-window-in-minutes>30</adherence-window-in-minutes></schedule><schedule><start-date-time><date><y>2017</y><m>6</m><d>13</d></date><time><h>8</h><m>45</m><s>0</s></time></start-date-time><schedule-type>Local</schedule-type><recurrence-type>Weekly</recurrence-type><group-id>bf806518-b526-4b15-98a2-900d7a68873e</group-id><multiple>1</multiple><minutes-to-remind-before>0</minutes-to-remind-before><adherence-window-in-minutes>30</adherence-window-in-minutes></schedule><schedule><start-date-time><date><y>2017</y><m>6</m><d>7</d></date><time><h>8</h><m>45</m><s>0</s></time></start-date-time><schedule-type>Local</schedule-type><recurrence-type>Weekly</recurrence-type><group-id>bf806518-b526-4b15-98a2-900d7a68873e</group-id><multiple>1</multiple><minutes-to-remind-before>0</minutes-to-remind-before><adherence-window-in-minutes>30</adherence-window-in-minutes></schedule><schedule><start-date-time><date><y>2017</y><m>6</m><d>8</d></date><time><h>8</h><m>45</m><s>0</s></time></start-date-time><schedule-type>Local</schedule-type><recurrence-type>Weekly</recurrence-type><group-id>bf806518-b526-4b15-98a2-900d7a68873e</group-id><multiple>1</multiple><minutes-to-remind-before>0</minutes-to-remind-before><adherence-window-in-minutes>30</adherence-window-in-minutes></schedule><schedule><start-date-time><date><y>2017</y><m>6</m><d>9</d></date><time><h>8</h><m>45</m><s>0</s></time></start-date-time><schedule-type>Local</schedule-type><recurrence-type>Weekly</recurrence-type><group-id>bf806518-b526-4b15-98a2-900d7a68873e</group-id><multiple>1</multiple><minutes-to-remind-before>0</minutes-to-remind-before><adherence-window-in-minutes>30</adherence-window-in-minutes></schedule></schedules><tracking-policy><is-auto-trackable>false</is-auto-trackable><source-types><source-type>Manual</source-type></source-types><trigger-types><trigger-type>Manual</trigger-type></trigger-types><completion-metrics><recurrence-type>Daily</recurrence-type><completion-type>Scheduled</completion-type><occurrence-count>1</occurrence-count></completion-metrics></tracking-policy><associated-objective-ids><id>1c71ced0-3f55-4a66-a8c9-189836304bb2</id></associated-objective-ids></task>";
             
             context(@"Deserialize", ^
                     {
                         it(@"should deserialize correctly", ^
                            {
                                MHVTaskThing *task = (MHVTaskThing*)[XReader newFromString:objectDefinition withRoot:[MHVTaskThing XRootElement] asClass:[MHVTaskThing class]];
                                
                                [[task.dateStarted.description should] equal:@"06/07/17 03:34 PM"];
                                [[task.name.description should] equal:@"Time to wake up"];
                                [[task.shortDescription.description should] equal:@"Set a consistent wake time to help regulate your body's internal clock."];
                                [[task.longDescription.description should] equal:@"Studies show that waking up at a consistent time every day, even on weekends, is one of the best ways to ensure a good night’s sleep."];
                                [[theValue(task.isReminderEnabled.value) should] equal:theValue(YES)];
                                [[task.status.description should] equal:@"InProgress"];
                                [[task.taskType.description should] equal:@"12340000-0000-0000-0000-000000000000"];
                                [[theValue(task.schedules.count) should] equal:theValue(1)];
                                // Tracking policy is nil for most properties
                                // AssociatedObjectids is nil
                                
                            });
                     });
             
             context(@"Serialize", ^
                     {
                         it(@"should serialize correctly", ^
                            {
                                MHVTaskThing *task = (MHVTaskThing*)[XReader newFromString:objectDefinition withRoot:[MHVTaskThing XRootElement] asClass:[MHVTaskThing class]];
                                
                                XWriter *writer = [[XWriter alloc] initWithBufferSize:2048];
                                [writer writeStartElement:[MHVTaskThing XRootElement]];
                                [task serialize:writer];
                                [writer writeEndElement];
                                
                                NSString *result = [writer newXmlString];
                                
                                [[result should] equal:objectDefinition];
                            });
                     });
         });

SPEC_END
