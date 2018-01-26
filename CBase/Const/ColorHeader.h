//
//  ColorHeader.h
//  CBase
//
//  Created by Jerry on 26/01/2018.
//  Copyright © 2018 Jerry. All rights reserved.
//

#ifndef ColorHeader_h
#define ColorHeader_h

//十六进制颜色宏 参数格式为：0xFFFFFF，建议少用，一般颜色在下面都有相应的宏代表
#define RGBHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define RGBAlphaHex(rgbValue,alha) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:alha]

//参数格式为：222,222,222
#define RGB(r, g, b)    [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:1.f]
#define RGBa(r, g, b,a) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:a]

#define kCLEAR_COLOR                [UIColor clearColor]//透明色
#define kBACKGROUND_COLOR           RGBHex(0xffffff)  //部分背景白色、字体泛白、icon反白
#define kBACKGROUND_DEEP_COLOR      RGBHex(0xfaf6ef) //统一背景色
#define kBACKGROUND_BLACK_COLOR     RGBAlphaHex(0x000000,0.5f)//透明背景色
#define kPLACEHOLDER_TEXT_COLOR     RGBHex(0xdcdcdc) //占位符的颜色
#define kNORMAL_TEXT_COLOR          RGBHex(0x333336) //普通文字的颜色

#define kNORMAL_BUTTON_COLOR        RGBHex(0xfd9938) //普通button的颜色、导航栏、主色
#define kNORMAL_BUTTON_TITLE_COLOR  RGBHex(0xffffff) //普通button标题的颜色
#define kHILIGHT_BUTTON_COLOR       RGBHex(0xe98c32) //高亮button的颜色
#define kHILIGHT_BUTTON_TITLE_COLOR RGBHex(0xffffff) //高亮button标题的颜色
#define kDISABLE_BUTTON_COLOR       RGBHex(0xdcdcdc) //禁止button的颜色、线、文字注释
#define kDISABLE_BUTTON_TITLE_COLOR RGBHex(0xffffff) //禁止button标题的颜色
#define kASSISTANT_COLOR            RGBHex(0x50aef6) //辅助色、点缀、部分模块底色
#define kFIRST_LEVEL_COLOR          RGBHex(0x3a3834) //一级文字、突出文字色
#define kSECOND_LEVEL_COLOR         RGBHex(0x6f6c68) //二级文字、正文文字色
#define kTHIRD_LEVEL_COLOR          RGBHex(0xa0a0a0) //三级文字、辅助文字色
#define kFOURTH_LEVEL_COLOR         RGBHex(0xc8c8c8) //四级文字、辅助注释
#define kTERMINAL_GRID_NAME_COLOR   RGBHex(0x6e6c68) //终端网点地址颜色
#define kSECURITY_COLOR             RGBHex(0x13ca17) //安全、降序色
#define kNORMAL_LINK_COLOR          RGBHex(0x3679f5) //一般连接文字颜色
#define kWARNING_COLOR              RGBHex(0xf64f4e) //提醒、警示文字、提示背景色
#define kBACK_TABLE_COLOR           RGBHex(0xf8e9db) //销售 TableView 背景色
#define kOPERATE_BACKGROUND_COLOR   RGBHex(0xfaf6ef) //终端操作按钮颜色
#define kOPERATE_BACKGROUND_HELIGHT_COLOR   RGBHex(0xf1ede5) //终端操作按钮高亮颜色


#endif /* ColorHeader_h */
