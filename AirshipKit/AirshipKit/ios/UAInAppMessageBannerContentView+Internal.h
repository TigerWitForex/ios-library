/* Copyright 2017 Urban Airship and Contributors */

#import <UIKit/UIKit.h>
#import "UAInAppMessageMediaView+Internal.h"
#import "UAInAppMessageTextView+Internal.h"
#import "UAInAppMessageBannerDisplayContent+Internal.h"

NS_ASSUME_NONNULL_BEGIN

@interface UAInAppMessageBannerContentView : UIView

/**
 * Factory method for the banner content view. The banner content view holds banner text
 * and an optional image.
 *
 * @param contentLayout The banner content layout.
 * @param textView The subview that holds the text.
 * @param image The optional banner image.
 *
 * @return a configured UAInAppMessageBannerContentView instance.
 */
+ (instancetype)contentViewWithLayout:(UAInAppMessageBannerContentLayoutType)contentLayout
                             textView:(UAInAppMessageTextView *)textView
                                image:(UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END
