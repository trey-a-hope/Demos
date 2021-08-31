#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AppTrackingTransparencyPlugin.h"

FOUNDATION_EXPORT double app_tracking_transparencyVersionNumber;
FOUNDATION_EXPORT const unsigned char app_tracking_transparencyVersionString[];

