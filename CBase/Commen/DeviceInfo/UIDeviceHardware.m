//

//  UIDeviceHardware.m

//

//  Used to determine EXACT version of device software is running on.

#import "UIDeviceHardware.h"

#include <sys/types.h>

#include <sys/sysctl.h>

@implementation UIDeviceHardware

+ (NSString *) platform{
	
	size_t size;
	
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	
	char *machine = malloc(size);
	
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	
	NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
	
	free(machine);
	
	return platform;
	
}

+ (NSString *) platformString{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch (Cellular)";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch (Cellular)";
    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    return platform;
}

+ (NSString *) devieceType{
    NSString *deviceTyp=nil;
    NSString *currentDevice=[self platformString];
    if ([currentDevice hasPrefix:@"iPhone"]) {
        deviceTyp=@"iPhone";
    }
    else if ([currentDevice hasPrefix:@"iPad"]){
        deviceTyp=@"iPad";
    }
    else if ([currentDevice hasPrefix:@"iPod Touch"]){
        deviceTyp=@"iPod Touch";
    }
    else{
        deviceTyp=@"Simulator";
    }
    return deviceTyp;
}

+(void)highlightScreenBrightness:(CGFloat)value{
    [[UIScreen mainScreen] setBrightness:value];
}

+(void)restoreScreenBrightness:(CGFloat)value{
    [[UIScreen mainScreen] setBrightness:value];
}

+(NSInteger)NewerThan:(NSString *)destinationDevice{
    NSInteger newer=0;
    NSString *currentDevice=[self platform];
    NSString *currentDeviceString=[self platformString];
    if (![currentDeviceString hasPrefix:@"iPhone"]&&![currentDeviceString hasPrefix:@"iPad"]&&![currentDeviceString hasPrefix:@"iPod Touch"]) {//模拟器
        newer=-1;
    }
    else{
        if ([self isSameDeviceType:currentDevice sourceDeviece:destinationDevice]) {
            NSComparisonResult result=[currentDevice compare:destinationDevice options:NSNumericSearch];
            switch (result) {//这个比较的值与我们定义的规则是相反的，所以要转换一下
                case NSOrderedSame:
                    newer=0;
                    break;
                case NSOrderedAscending:
                    newer=1;
                    break;
                case NSOrderedDescending:
                    newer=-1;
                    break;
                default:
                    break;
            }
        }
        else{//不要将不同类型的设备进行比较，比如iPad和iPhone进行比较
            newer=-1;
        }
    }
    return newer;
}

//比较的时候，一般不考虑模拟器
+(NSComparisonResult)compareWith:(NSString *)destinationDevice sourceDeviece:(NSString *)sourceDeviece{
    if (([destinationDevice hasPrefix:@"iPhone"]&&[sourceDeviece hasPrefix:@"iPhone"])||([destinationDevice hasPrefix:@"iPad"]&&[sourceDeviece hasPrefix:@"iPad"])||([destinationDevice hasPrefix:@"iPod Touch"]&&[sourceDeviece hasPrefix:@"iPod Touch"])) {
        return [destinationDevice compare:sourceDeviece options:NSNumericSearch];
    }
    else{//交叉设备进行比较，最好不要这样进行比较，默认返回NSOrderedAscending（-1L）
        return NSOrderedAscending;
    }
}

//比较的时候，一般不考虑模拟器
+(BOOL)isSameDeviceType:(NSString *)destinationDevice sourceDeviece:(NSString *)sourceDeviece{
    if (([destinationDevice hasPrefix:@"iPhone"]&&[sourceDeviece hasPrefix:@"iPhone"])||([destinationDevice hasPrefix:@"iPad"]&&[sourceDeviece hasPrefix:@"iPad"])||([destinationDevice hasPrefix:@"iPod Touch"]&&[sourceDeviece hasPrefix:@"iPod Touch"])){
        return YES;
    }
    return NO;
}

@end
