//
//  JingGeDataManager.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/17.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
extern NSString * const file_type_mp4;
extern NSString * const file_type_word;
extern NSString * const file_type_excel;
extern NSString * const file_type_ppt;
extern NSString * const file_type_pic;
extern NSString * const file_type_txt;
extern NSString * const file_type_pdf;
extern NSString * const file_type_unknow;

extern NSString * const file_format_type_mp4;
extern NSString * const file_format_type_doc;
extern NSString * const file_format_type_docx;
extern NSString * const file_format_type_ppt;
extern NSString * const file_format_type_pptx;
extern NSString * const file_format_type_jpg;
extern NSString * const file_format_type_jpeg;
extern NSString * const file_format_type_png;
extern NSString * const file_format_type_txt;
extern NSString * const file_format_type_pdf;
extern NSString * const file_format_type_xls;
extern NSString * const file_format_type_xlsx;
extern NSString * const file_format_type_unknow;

typedef NS_ENUM(NSInteger, FILE_FORMAT_TYPE){
    FILE_FORMAT_TYPE_MP4 = 0,
    FILE_FORMAT_TYPE_DOC ,
    FILE_FORMAT_TYPE_XLS ,
    FILE_FORMAT_TYPE_PPT ,
    FILE_FORMAT_TYPE_JPG ,
    FILE_FORMAT_TYPE_TXT ,
    FILE_FORMAT_TYPE_PDF ,
    FILE_FORMAT_TYPE_DOCX = FILE_FORMAT_TYPE_DOC,
    FILE_FORMAT_TYPE_XLSX = FILE_FORMAT_TYPE_XLS,
    FILE_FORMAT_TYPE_PPTX = FILE_FORMAT_TYPE_PPT,
    FILE_FORMAT_TYPE_JPEG = FILE_FORMAT_TYPE_JPG,
    FILE_FORMAT_TYPE_PNG = FILE_FORMAT_TYPE_JPG,
    FILE_FORMAT_TYPE_UNKNOW = -1
    
};

@interface JingGeDataManager : NSObject
+ (BOOL)simpleToBOOL:(id)simple;//简单的0，1转bool
+ (id)jsonStringWithData:(NSData *)data;//转换json串

//字典转为Json字符串
+(NSString *)dictionaryToJson:(NSDictionary *)dic;
//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *) stringByReplaceSpecialCharacters:(NSString *)string;//去换行
+ (NSString *)stringSeparated:(NSString *)str;//字符串的分割
+ (BOOL) isBlankString:(NSString *)string;//
+ (NSString *)stringWithReplaceStr:(NSString *)string;
+ (NSString *)chineseChangeChar:(NSString *)changeStr;//汉字转换成拼音
+ (NSString *)stringWithBase64EncodedString:(NSString *)string;//64位加密
+ (NSString *)judgeVideoPlayTypeWithString:(NSString *)string;//判断播放类型
+ (FILE_FORMAT_TYPE)fileFormateTypeWithString:(NSString *)String;
+ (NSString *)deviceType;
+ (NSString *)systemVersion;
+ (NSString *)asciiToNSString:(int)asciiCode;//ASCII to NSString
+ (int)stringToASCII:(NSString *)string;//NSString to ASCII
+ (UIViewController *)topViewController;
+ (NSString*)fileFindFullPathWithFileName:(NSString*)fileName InDirectory:(NSString*)inDirectory;//根据名称返回绝对路径
+ (BOOL)isFileExist:(NSString *)path;//文件是否存在
+ (BOOL)createFilePath:(NSString*)strFolderPath;//创建文件夹
+ (BOOL)deleteFileAtPath:(NSString*)path;//删除路径下文件
+ (NSString*)trimWhiteSpace:(NSString*)strContent;//去除空格
+ (NSString*)trimWhiteSpaceAndNewLine:(NSString*)strContent;//去除空格和换行
+ (NSString*)getFileMD5WithPath:(NSString*)path; //对路径进行MD5加密
+ (BOOL)imageSaveFile:(NSString*)strSaveFile withImage:(UIImage*)img;//保存img到路径
+ (NSMutableDictionary*)getDictionaryFromString:(NSString*)str1 WithSeparatedString:(NSString*)sep;//字符串含"="转字典
+ (NSString*)getStringFromDictionary:(NSDictionary*)dict1 WithSeparatedString:(NSString*)sep;//字典转字符串含"="
+ (NSString*)parentFolderWithFilePath:(NSString*)fileFullPath;// 当前文件 或 文件夹的 父文件夹

+ (NSMutableArray*)fontLists;//获取fontlist
+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size;//获取自定义Font
+ (NSString*)toStrByUIColor:(UIColor*)color; //颜色转字符串
+ (NSString *)md5To32bit:(NSString *)str; //MD5加密
+ (NSInteger)md5ToInteger:(NSString *)str;
@end
