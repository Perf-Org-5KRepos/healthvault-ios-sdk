//
// MHVRemoteMonitoringClient.m
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

#import <Foundation/Foundation.h>
#import "MHVCommon.h"
#import "MHVRemoteMonitoringClient.h"
#import "MHVClient.h"
#import "MHVJsonSerializer.h"
#import "MHVConnectionProtocol.h"
#import "MHVRestRequest.h"
#import "MHVServiceResponse.h"
#import "MHVConnectionFactory.h"
#import "MHVConnection.h"

@interface MHVRemoteMonitoringClient ()

@property (nonatomic, weak) id<MHVConnectionProtocol>     connection;

@end

@implementation MHVRemoteMonitoringClient

- (instancetype)initWithConnection:(id<MHVConnectionProtocol>)connection
{
    MHVASSERT_PARAMETER(connection);
    
    self = [super init];
    if (self)
    {
        _connection = connection;
    }
    
    return self;
}

//PENDING: Swagger generated code needs to update to be injected with RemoteMonitoringClient & remove this method
+ (NSURLSessionTask *)requestWithPath:(NSString *_Nonnull)path
                               method:(NSString *_Nonnull)method
                           pathParams:(NSDictionary<NSString *, NSString *> *_Nullable)pathParams
                          queryParams:(NSDictionary<NSString *, NSString *> *_Nullable)queryParams
                           formParams:(NSDictionary<NSString *, NSString *> *_Nullable)formParams
                                 body:(NSData *_Nullable)body
                              toClass:(Class)toClass
                           completion:(void(^_Nullable)(id _Nullable output, NSError *_Nullable error))completion
{
    //    [[MHVRemoteMonitoringClient current] requestWithPath:path
    //                                              method:method
    //                                           pathParams:pathParams
    //                                         queryParams:queryParams
    //                                          formParams:formParams
    //                                                body:body
    //                                             toClass:toClass
    //                                          completion:completion];
    
    return nil;
}

- (void)requestWithPath:(NSString *_Nonnull)path
             httpMethod:(NSString *_Nonnull)httpMethod
             pathParams:(NSDictionary<NSString *, NSString *> *_Nullable)pathParams
            queryParams:(NSDictionary<NSString *, NSString *> *_Nullable)queryParams
             formParams:(NSDictionary<NSString *, NSString *> *_Nullable)formParams
                   body:(NSData *_Nullable)body
                toClass:(Class)toClass
             completion:(void(^_Nullable)(id _Nullable output, NSError *_Nullable error))completion
{
    MHVASSERT_PARAMETER(path);
    MHVASSERT_PARAMETER(httpMethod);
    
    if (pathParams != nil)
    {
        NSMutableString *queryPath = [path mutableCopy];
        
        [pathParams enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL *_Nonnull stop)
         {
             [queryPath replaceCharactersInRange:[queryPath rangeOfString:[NSString stringWithFormat:@"{%@}", key]] withString:obj];
         }];
        
        path = queryPath;
    }
    
    MHVRestRequest *restRequest = [[MHVRestRequest alloc] initWithPath:path
                                                            httpMethod:httpMethod
                                                            pathParams:pathParams
                                                           queryParams:queryParams
                                                            formParams:formParams
                                                                  body:body
                                                           isAnonymous:NO];
    
    [self.connection executeHttpServiceOperation:restRequest
                                      completion:^(MHVServiceResponse *_Nullable response, NSError *_Nullable error)
     {
         if (error)
         {
             if (completion)
             {
                 completion(nil, error);
             }
         }
         else
         {
             if (completion)
             {
                 id result = [MHVJsonSerializer deserialize:response.responseAsString
                                                    toClass:[toClass class]
                                                shouldCache:YES];
                 
                 completion(result, nil);
             }
         }
     }];
}

@end;