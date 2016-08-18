/*
 Copyright 2009-2016 Urban Airship Inc. All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE URBAN AIRSHIP INC ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL URBAN AIRSHIP INC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <XCTest/XCTest.h>
#import "UAScheduleTrigger+Internal.h"
#import "UAJSONPredicate.h"

@interface UAScheduleTriggerTests : XCTestCase

@end

@implementation UAScheduleTriggerTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testWithJSON {

    NSDictionary *predicateJSON = @{ @"and": @[ @{ @"value": @{ @"equals": @"bar" }, @"key": @"foo" },
                                       @{ @"value": @{ @"equals": @"story" }, @"key": @"cool" } ]};

    NSDictionary *triggerTypeMap = @{ UAScheduleTriggerAppForegroundName: @(UAScheduleTriggerAppForeground),
                                      UAScheduleTriggerAppBackgroundName: @(UAScheduleTriggerAppBackground),
                                      UAScheduleTriggerRegionEnterName: @(UAScheduleTriggerRegionEnter),
                                      UAScheduleTriggerRegionExitName: @(UAScheduleTriggerRegionExit),
                                      UAScheduleTriggerCustomEventCountName: @(UAScheduleTriggerCustomEventCount),
                                      UAScheduleTriggerCustomEventValueName: @(UAScheduleTriggerCustomEventValue),
                                      UAScheduleTriggerScreenName: @(UAScheduleTriggerScreen) };


    for (NSString *typeName in triggerTypeMap) {
        NSDictionary *triggerJSON = @{ UAScheduleTriggerGoalKey: @(1),
                                       UAScheduleTriggerPredicateKey: predicateJSON,
                                       UAScheduleTriggerTypeKey: typeName };

        UAScheduleTrigger *trigger = [UAScheduleTrigger triggerWithJSON:triggerJSON];
        XCTAssertEqual(trigger.type, [triggerTypeMap[typeName] unsignedIntegerValue]);
        XCTAssertEqualObjects(trigger.goal, @(1));
        XCTAssertEqualObjects(trigger.predicate.payload, predicateJSON);
    }
}

- (void)testInvalidJSON {
    // Missing type
    XCTAssertNil([UAScheduleTrigger triggerWithJSON:@{UAScheduleTriggerGoalKey: @(1)}]);

    // Missing goal
    NSDictionary *payload = @{UAScheduleTriggerTypeKey: UAScheduleTriggerAppBackgroundName};
    XCTAssertNil([UAScheduleTrigger triggerWithJSON:payload]);

    // Invalid goal
    payload = @{UAScheduleTriggerTypeKey: UAScheduleTriggerAppBackgroundName, UAScheduleTriggerGoalKey: @"what"};
    XCTAssertNil([UAScheduleTrigger triggerWithJSON:payload]);

    // Invalid type
    payload = @{UAScheduleTriggerTypeKey: @"what", UAScheduleTriggerGoalKey: @(1)};
    XCTAssertNil([UAScheduleTrigger triggerWithJSON:payload]);

    // Invalid predicate
    payload = @{UAScheduleTriggerTypeKey: UAScheduleTriggerAppBackgroundName, UAScheduleTriggerGoalKey: @(1), UAScheduleTriggerPredicateKey: @"what"};
    XCTAssertNil([UAScheduleTrigger triggerWithJSON:payload]);
}

@end
