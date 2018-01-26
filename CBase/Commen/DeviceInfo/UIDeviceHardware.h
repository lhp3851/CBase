//

//  UIDeviceHardware.h

//

//  Used to determine EXACT version of device software is running on.

#import <Foundation/Foundation.h>

@interface UIDeviceHardware : NSObject

+ (NSString *) platform;

+ (NSString *) platformString;

/**
 @return 设备类型
 */
@property(nonatomic,strong)NSString *devieceType;

/**
 与目标设备比较，某些功能只在特定的设备（或者更新的设备）上支持，比如3Dtouch
 
 @param destinationDevice 目标设备的platform值
 @param suorceDeviece  要比较的设备
 @return  a:与目标设备相同或者比目标设备新，返回真
          b:比目标设备旧返回假
 */
+(NSComparisonResult)compareWith:(NSString *)destinationDevice sourceDeviece:(NSString *)sourceDeviece;

/**
 与目标设备比较，某些功能只在特定的设备（或者更新的设备）上支持，比如3Dtouch

 @param destinationDevice 目标设备的platform值
 @return  a:与目标设备相同或者比目标设备新，返回1
          b:比目标设备旧返回0
          c:模拟器返回-1
 */
+(NSInteger)NewerThan:(NSString *)destinationDevice;

//加亮屏幕，value值在0~1之间
+(void)highlightScreenBrightness:(CGFloat)value;

//恢复屏幕亮度
+(void)restoreScreenBrightness:(CGFloat)value;

@end
