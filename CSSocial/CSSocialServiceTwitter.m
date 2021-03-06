//
//  CSSocialServiceTwitter.m
//  CSCocialManager2.0
//
//  Created by Luka Fajl on 21.6.2012..
/*
 The MIT License (MIT)
 
 Copyright (c) 2013 Clover Studio. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "CSSocialServiceTwitter.h"
#import "CSConstants.h"
#import "CSSocial.h"
#import "CSSocialConstants.h"
#import "CSRequests.h"
#import "CSTwitterPlugin.h"
#import "CSSocialRequestTwitter.h"

#pragma mark - CSSocialServiceTwitter

@interface CSSocialServiceTwitter()

@end

@implementation CSSocialServiceTwitter
{
    CSTwitterPlugin *_plugin;

}

-(void) dealloc
{
    CS_SUPER_DEALLOC;
}

-(id) init {
    if ((self=[super init])) 
    {
        _plugin = [CSTwitterPlugin plugin];
    }
    return self;
}

-(NSOperationQueue*) operationQueue
{
    return CS_AUTORELEASE([[NSOperationQueue alloc] init]);
}

-(void) login:(CSVoidBlock) success error:(CSErrorBlock) error
{
    self.loginSuccessBlock = success;
    self.loginFailedBlock = error;
    
    [_plugin login:success error:error];
    
}

-(BOOL) handleOpenURL:(NSURL *)url
{
    return NO;
}

-(void) logout
{
    [_plugin logout];
}

-(BOOL) isAuthenticated
{
    return [_plugin isAuthenticated];
}

-(CSSocialRequest*) constructRequestWithParameter:(id<CSSocialParameter>)parameter
{
    CSSocialRequest *request = nil;
    
    switch (parameter.requestName)
    {
        case CSRequestLogin:
            break;
        case CSRequestLogout:
            break;
        case CSRequestUser:
            //request = [CSSocialRequestTwitterUser requestWithService:nil parameters:[parameter parameters]];
            break;
        case CSRequestFriends:
            request = [CSSocialRequestTwitterFriends requestWithService:_plugin.oAuth parameters:[parameter parameters]];
            break;
        case CSRequestPostMessage:
            request = [CSSocialRequestTwitterMessage requestWithService:_plugin.oAuth parameters:[parameter parameters]];
            break;
        case CSRequestGetUserImage:
            request = [CSSocialRequestTwitterGetUserImage requestWithService:_plugin.oAuth parameters:[parameter parameters]];
            break;
        default:
            break;
    }
    return request;
}


-(NSArray*) permissions {
    return nil;
}

- (id)showDialogWithMessage:(NSString *)message
                        url:(NSURL*) url
                      photo:(UIImage *)photo
                    handler:(CSErrorBlock)handlerBlock {
    return [_plugin showDialogWithMessage:message photo:photo handler:handlerBlock];
}

@end
