//
//  JingGeDataManager.m
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/17.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeDataManager.h"
#import "Base64.h"
#import "JingGeMacro.h"
#import <CommonCrypto/CommonDigest.h>   //算法 md5
#import <CoreText/CoreText.h>
NSString * const file_type_mp4    = @"mp4";
NSString * const file_type_word   = @"word";
NSString * const file_type_excel  = @"excel";
NSString * const file_type_ppt    = @"ppt";
NSString * const file_type_pic    = @"pic";
NSString * const file_type_txt    = @"txt";
NSString * const file_type_pdf    = @"pdf";
NSString * const file_type_unknow = @"unknow";

NSString * const file_format_type_mp4    = @"mp4";
NSString * const file_format_type_doc    = @"doc";
NSString * const file_format_type_docx   = @"docx";
NSString * const file_format_type_ppt    = @"ppt";
NSString * const file_format_type_pptx   = @"pptx";
NSString * const file_format_type_jpg    = @"jpg";
NSString * const file_format_type_jpeg   = @"jpeg";
NSString * const file_format_type_png    = @"png";
NSString * const file_format_type_txt    = @"txt";
NSString * const file_format_type_pdf    = @"pdf";
NSString * const file_format_type_xls    = @"xls";
NSString * const file_format_type_xlsx   = @"xls";
NSString * const file_format_type_unknow = @"unknow";

@implementation JingGeDataManager


+ (BOOL)simpleToBOOL:(id)simple
{
    if ([simple integerValue]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark 字符串处理
+ (id)jsonStringWithData:(NSData *)data
{
    
    @try{
        NSError *error=nil;
        id str = nil;
        if (!data)
            return nil;
        str = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        return str;
    }
    @catch(NSException *exception) {
        Log(@"exception:%@", exception);
        
    }
    @finally {
        
    }
    
}

//字典转为Json字符串
+(NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}

+(id)analysisJsonWithString:(NSString*)string
{
    NSString *jsonString = [JingGeDataManager stringByReplaceSpecialCharacters:string];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonArray =[JingGeDataManager jsonStringWithData:data];
    
    return jsonArray;
    
}

+ (NSString*) stringByReplaceSpecialCharacters:(NSString *)string
{
    NSString *jsonString = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\v" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\f" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\b" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\a" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\e" withString:@""];
    return jsonString;
}
+ (BOOL) isBlankString:(NSString *)string {
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ([string isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([string isEqualToString:@"<null>"]) {
        return NO;
    }
    if (string == nil || string == NULL) {
        return NO;
    }
    
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return NO;
    }
    return YES;
}
+(NSString *)stringWithReplaceStr:(NSString *)string
{
    string = [NSString stringWithFormat:@"%@",string];
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if ([string isEqualToString:@"(null)"]) {
        return @"";
    }
    if ([string isEqualToString:@"<null>"]) {
        return @"";
    }
    if ([string isEqualToString:@"(\n)"]) {
        return @"";
    }
    if (string == nil || string == NULL) {
        return @"";
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    return string;
}

+(NSString *)stringSeparated:(NSString *)str
{
    NSArray *array = [str componentsSeparatedByString:@"."];
    if (array.count <= 1) {
        return [array objectAtIndex:0];
    }
    return [array objectAtIndex:1];
    
}

+(NSString *)chineseChangeChar:(NSString *)changeStr
{
    unichar c = [changeStr characterAtIndex:0];
    NSString *charStr ;
    //    判断搜素内容的类型
    if (c >=0x4E00 && c <=0x9FFF)
    {
        charStr = changeStr;
    }
    else
    {
        return changeStr;
    }
    
    for (int i=0; i<charStr.length; ++i)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [charStr substringWithRange:range];
        const char    *cString = [subString UTF8String];
        if (strlen(cString) == 3)
        {
            NSMutableString *ms = [[NSMutableString alloc] initWithString:charStr];
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            }
            if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
                return ms;
            }
        }
    }
    return nil;
}
//64位加密
+ (NSString *)stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

#pragma 判断格式
+ (NSString *)judgeVideoPlayType:(FILE_FORMAT_TYPE)playType
{
    
    switch (playType) {
        case FILE_FORMAT_TYPE_MP4:
            return file_type_mp4;
            break;
        case FILE_FORMAT_TYPE_DOC:
            return file_type_word;
            break;
        case FILE_FORMAT_TYPE_XLS:
            return file_type_excel;
            break;
        case FILE_FORMAT_TYPE_PPT:
            return file_type_ppt;
            break;
        case FILE_FORMAT_TYPE_JPG:
            return file_type_pic;
            break;
        case FILE_FORMAT_TYPE_TXT:
            return file_type_txt;
            break;
        case FILE_FORMAT_TYPE_PDF:
            return file_type_pdf;
            break;
        case FILE_FORMAT_TYPE_UNKNOW:
            return file_type_unknow;
            break;
            
        default:
            break;
    }
}

+ (FILE_FORMAT_TYPE)fileFormateTypeWithString:(NSString *)String
{
    NSString *typeStr = [JingGeDataManager stringSeparated:String];
    if ([typeStr isEqualToString:file_format_type_mp4]) {
        return FILE_FORMAT_TYPE_MP4;
    }else if ([typeStr isEqualToString:file_format_type_doc]){
        return FILE_FORMAT_TYPE_DOC;
    }else if ([typeStr isEqualToString:file_format_type_docx]){
        return FILE_FORMAT_TYPE_DOCX;
    }else if ([typeStr isEqualToString:file_format_type_xls]){
        return FILE_FORMAT_TYPE_XLS;
    }else if ([typeStr isEqualToString:file_format_type_xlsx]){
        return FILE_FORMAT_TYPE_XLSX;
    }else if ([typeStr isEqualToString:file_format_type_ppt]){
        return FILE_FORMAT_TYPE_PPT;
    }else if ([typeStr isEqualToString:file_format_type_pptx]){
        return FILE_FORMAT_TYPE_PPTX;
    }else if ([typeStr isEqualToString:file_format_type_png]){
        return FILE_FORMAT_TYPE_PNG;
    }else if ([typeStr isEqualToString:file_format_type_jpg]){
        return FILE_FORMAT_TYPE_JPG;
    }else if ([typeStr isEqualToString:file_format_type_jpeg]){
        return FILE_FORMAT_TYPE_JPEG;
    }else if ([typeStr isEqualToString:file_format_type_txt]){
        return FILE_FORMAT_TYPE_TXT;
    }else if ([typeStr isEqualToString:file_format_type_pdf]){
        return FILE_FORMAT_TYPE_PDF;
    }else{
        return FILE_FORMAT_TYPE_UNKNOW;
    }
}

+ (NSString *)judgeVideoPlayTypeWithString:(NSString *)string
{
    return [JingGeDataManager judgeVideoPlayType:[JingGeDataManager fileFormateTypeWithString:string]];
}


//ASCII to NSString
+ (NSString *)asciiToNSString:(int)asciiCode {
    NSString *string;
    if (asciiCode > 90) {
        string = [NSString stringWithFormat:@"%d", asciiCode - 64];
    }else {
        string = [NSString stringWithFormat:@"%c", asciiCode];
    }
    
    return string;
}
//NSString to ASCII
+ (int)stringToASCII:(NSString *)string {
    int asciiCode = [string characterAtIndex:0];
    return asciiCode;
}
#pragma mark  手机邮箱合法验证
+(BOOL)isValidatephone:(NSString *)phone
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[0-9])[0-9]|349)\\d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:phone];
    BOOL res2 = [regextestcm evaluateWithObject:phone];
    BOOL res3 = [regextestcu evaluateWithObject:phone];
    BOOL res4 = [regextestct evaluateWithObject:phone];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/*邮箱验证 MODIFIED BY HELENSONG*/
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString *)deviceType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}


+ (NSString *)systemVersion {
    return [NSString stringWithFormat:@"%@-%@", kDeviceSystenName, kDevicesystemVersion];
}


+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


+ (NSString*)fileFindFullPathWithFileName:(NSString*)fileName InDirectory:(NSString*)inDirectory
{
    //根据名称，返回绝对路径
    NSString *ret=nil;
    NSRange r1=[fileName rangeOfString:@"."];
    if (r1.location != NSNotFound )
    {
        NSString *name=[fileName substringToIndex:r1.location];
        NSString *fileExt=[fileName pathExtension];
        ret = [[NSBundle mainBundle] pathForResource:name ofType:fileExt inDirectory:inDirectory];
    }
    return ret;
}

+ (BOOL)isFileExist:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

+ (BOOL)createFilePath:(NSString*)strFolderPath
{
    //创建文件夹
    BOOL bDo1=YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:strFolderPath] == NO) {
        bDo1=[fileManager createDirectoryAtPath:strFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return bDo1;
}

+ (BOOL)deleteFileAtPath:(NSString*)path
{
    BOOL bDo1=NO;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        bDo1=[fileManager removeItemAtPath:path error:nil];
    }
    
    return bDo1;
}
+ (NSString*)trimWhiteSpace:(NSString*)strContent
{
    //去除空格
    return [strContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
+ (NSString*)trimWhiteSpaceAndNewLine:(NSString*)strContent
{
    //去除空格和换行
    return [strContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)md5To32bit:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr),digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

+ (NSInteger)md5ToInteger:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr),digest );
    NSInteger result = 0;
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
       // [result appendFormat:@"%02x", digest[i]];
        result += digest[i];
    }
    
    return result;
}



+ (NSString*)getFileMD5WithPath:(NSString*)path
{
    return [JingGeDataManager FileMD5HashCreateWithPath:path WithSize:(1024*8)];
}
+ (NSString*)FileMD5HashCreateWithPath:(NSString*)filePath WithSize:(size_t)chunkSizeForReadingData
{
    // Declare needed variables
    //CFStringRef result = NULL;
    NSMutableString *result=nil;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    
    CC_MD5_CTX hashObject;
    bool hasMoreData = true;
    bool didSucceed;
    
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = 1024*8;
    }
    
    // Feed the data to the hash object
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                  (UInt8 *)buffer,
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1)break;
        if (readBytesCount == 0) {
            hasMoreData =false;
            continue;
        }
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    
    // Compute the string result
    //    char hash[22 *sizeof(digest) + 1];
    //    for (size_t i =0; i < sizeof(digest); ++i) {
    //        snprintf(hash + (22 * i),3, "%02x", (int)(digest[i]));
    //    }
    //
    //    //这里 运行的result 返回不对
    //    result = CFStringCreateWithCString(kCFAllocatorDefault,
    //                                       (const char *)hash,
    //                                       kCFStringEncodingUTF8);
    
    result = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++){
        [result appendFormat:@"%02x",digest[i]];
    }
    
    
done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
    
}
+ (BOOL)imageSaveFile:(NSString*)strSaveFile withImage:(UIImage*)img {
    //图片保存文件
    BOOL bRet=NO;
    NSString *fileExt=[[strSaveFile pathExtension] lowercaseString];
    
    if (img && strSaveFile && ([fileExt compare:@"png"] == NSOrderedSame) )
    {
        //save png
        NSData *imgData =UIImagePNGRepresentation(img);
        bRet=[imgData writeToFile:strSaveFile atomically:YES];
    }
    else
    {
        //save jpg
        NSData *imgData=UIImageJPEGRepresentation(img, 0);
        bRet=[imgData writeToFile:strSaveFile atomically:YES];
    }
    
    return bRet;
}
+ (NSMutableDictionary*)getDictionaryFromString:(NSString*)str1 WithSeparatedString:(NSString*)sep
{
    //转换
    NSMutableDictionary *dictRet=nil;
    NSArray *params=[str1 componentsSeparatedByString:sep];
    if ([params count]>0)
    {
        dictRet=[NSMutableDictionary dictionaryWithCapacity:[params count]];
        for (NSString *one in params)
        {
            NSRange range = [one rangeOfString:@"="];
            
            if (range.location !=NSNotFound && range.length > 0)
            {
                NSString *key1=[one substringToIndex:range.location];
                NSString *value1=[one substringFromIndex:range.location+1];
                
                [dictRet setObject:[self trimWhiteSpace:value1] forKey:[self trimWhiteSpace:key1]];
            }
        }
    }
    
    return dictRet;
}
+ (NSString*)getStringFromDictionary:(NSDictionary*)dict1 WithSeparatedString:(NSString*)sep
{
    //转换
    NSString *strResult=nil;
    NSMutableArray *params=[NSMutableArray array];
    for (NSString *key1 in [dict1 allKeys])
    {
        NSString *value1=[dict1 objectForKey:key1];
        
        [params addObject:[NSString stringWithFormat:@"%@=%@",key1,value1]];
        
    }
    
    if ([params count]>0)
    {
        strResult=[params componentsJoinedByString:sep];
    }
    
    return strResult;
}

+ (int)openURLWithString:(NSString*)strURL
{
    //
    int iResult=0;
    
    UIApplication *app= [UIApplication sharedApplication];
    
    NSString *str1=[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str1];
    
    if ([app canOpenURL:url])
    {
        [app openURL:url];
        iResult=1;
    }
    
    return iResult;
}

+ (NSString*)parentFolderWithFilePath:(NSString*)fileFullPath
{
    //当前文件 或 文件夹的 父文件夹
    if ([fileFullPath length]<1) {
        return nil;
    }
    NSInteger lastSlash = [fileFullPath rangeOfString:@"/" options:NSBackwardsSearch].location;
    NSString *parentPath = [fileFullPath substringToIndex:(lastSlash +1)];
    return parentPath;
}

+ (NSMutableArray*)fontLists
{
    //字体列表 测试ok
    NSMutableArray *fontArray = [NSMutableArray arrayWithCapacity:246];
    for (NSString * familyName in [UIFont familyNames]) {
        NSMutableDictionary *familyDic = [NSMutableDictionary dictionary];
        NSMutableArray *familyAry = [NSMutableArray array];
        [familyDic setObject:familyAry forKey:familyName];
        //NSLog(@"Font FamilyName = %@",familyName); //*输出字体族科名字
        for (NSString * fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"%@",fontName);
            [familyAry addObject:fontName];
            
        }
        [fontArray addObject:familyDic];
    }
    return fontArray;
}

+ (BOOL)UnRegisterCustomFont:(NSString*)path
{
    BOOL bDO=YES;
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    bDO = CTFontManagerUnregisterGraphicsFont(fontRef, NULL);
    CGFontRelease(fontRef);
    return bDO;
    
}


+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size
{
    //测试ok
    /*
     方法对于TTF、OTF的字体都有效，但是对于TTC字体，只取出了一种字体。因为TTC字体是一个相似字体的集合体，一般是字体的组合。所以如果对字体要求比较高，所以可以用下面的方法把所有字体取出来
     */
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;
}

+ (NSString*)toStrByUIColor:(UIColor*)color{
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    return [NSString stringWithFormat:@"#%06x", rgb];
}



@end
