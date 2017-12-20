/* Copyright 2017 Urban Airship and Contributors */

#import <Foundation/Foundation.h>
#import "UAInAppMessageDisplayContent.h"

@class UAInAppMessageAudience;

NS_ASSUME_NONNULL_BEGIN

/**
 * Represents the possible error conditions when deserializing an in-app message from JSON.
 */
typedef NS_ENUM(NSInteger, UAInAppMessageErrorCode) {
    /**
     * Indicates an error with the in-app message JSON definition.
     */
    UAInAppMessageErrorCodeInvalidJSON,
};

/**
 * Display types.
 */
typedef NS_ENUM(NSInteger, UAInAppMessageDisplayType) {
    /**
     * Banner display
     */
    UAInAppMessageDisplayTypeBanner,
    
    /**
     * Full screen display
     */
    UAInAppMessageDisplayTypeFullScreen,
    
    /**
     * Modal display
     */
    UAInAppMessageDisplayTypeModal,
    
    /**
     * HTML display
     */
    UAInAppMessageDisplayTypeHTML,
    
    /**
     * Custom display
     */
    UAInAppMessageDisplayTypeCustom
    
};

/**
 * Builder class for a UAInAppMessage.
 */
@interface UAInAppMessageBuilder : NSObject

///---------------------------------------------------------------------------------------
/// @name In App Message Builder Properties
///---------------------------------------------------------------------------------------

/**
* The unique identifier for the message.
*/
@property(nonatomic, copy, nullable) NSString *identifier;

/**
 * The display type.
 */
@property(nonatomic, assign) UAInAppMessageDisplayType displayType;

/**
 * The display content for the message.
 */
@property(nonatomic, strong, nullable) UAInAppMessageDisplayContent *displayContent;

/**
 * The extras for the messages.
 */
@property(nonatomic, copy, nullable) NSDictionary *extras;

/**
 * The audience conditions for the messages.
 */
@property(nonatomic, strong, nullable) UAInAppMessageAudience *audience;

@end

/**
 * Model object representing in-app message data.
 */
@interface UAInAppMessage : NSObject

///---------------------------------------------------------------------------------------
/// @name In App Message Properties
///---------------------------------------------------------------------------------------

/**
* The unique identifier for the message.
*/
@property(nonatomic, copy, nullable) NSString *identifier;

/**
 * The display type.
 */
@property(nonatomic, assign) UAInAppMessageDisplayType displayType;

/**
 * The display content for the message.
 */
@property(nonatomic, strong, nullable) UAInAppMessageDisplayContent *displayContent;

/**
 * The extras for the messages.
 */
@property(nonatomic, copy, nullable) NSDictionary *extras;

/**
 * The audience conditions for the messages.
 */
@property(nonatomic, strong, nullable) UAInAppMessageAudience *audience;

/**
 * Class factory method for constructing an unconfigured
 * in-app message model.
 *
 * @return An unconfigured instance of UAInAppMessage.
 */
+ (instancetype)message;

/**
 * Class factory method for constructing an in-app message from JSON.
 *
 * @param json JSON object that defines the message.
 * @param error An NSError pointer for storing errors, if applicable.
 * @return A fully configured instance of UAInAppMessage or nil if JSON parsing fails.
 */
+ (nullable instancetype)messageWithJSON:(NSDictionary *)json error:(NSError * _Nullable *)error;

/**
 * Class factory method for constructing an in-app message
 * model with an in-app message builder block.
 *
 * @param builderBlock the builder block.
 * @return A fully configured instance of UAInAppMessage.
 */
+ (instancetype)messageWithBuilderBlock:(void(^)(UAInAppMessageBuilder *builder))builderBlock;

/**
 * Method to return the message as its JSON representation.
 *
 * @returns JSON representation of message (as NSDictionary)
 */
- (NSDictionary *)toJsonValue;

@end

NS_ASSUME_NONNULL_END
