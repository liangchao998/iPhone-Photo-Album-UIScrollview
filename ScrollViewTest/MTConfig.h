//
//  config.h
//

#pragma mark - 屏幕相关
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

#define ScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kDeviceFrame [UIScreen mainScreen].bounds
#define BASEHEIGHT 480.0f

#define kDeviceStatusHeight 20.0
#define kDeviceTabHeight (kDeviceHeight == 812.0 ? 83.0 : 49.0)
#define kDeviceNaviHeight 44.0
#define kViewOrignY 64.0

// 适配iPhoneX
#define kDeviceNavHeight (kDeviceHeight == 812.0 ? 88 : 64)
