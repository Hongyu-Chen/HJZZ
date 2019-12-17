//
//  NSString+Authentication.m
//  YiLinMuYan
//
//  Created by apple on 2017/12/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSString+Authentication.h"
//#import "TipsView.h"

typedef enum{
    AutenticationErrorPhoneNull = 1,//手机号为空
    AutenticationErrorPhoneError = 2,//手机号格式错误
    AutenticationErrorPhoneNonExistent = 3,//手机号不存在
    AutenticationErrorPasswordNull = 4,//密码为空
    AutenticationErrorPasswordDefect = 5,//密码至少6位
    AutenticationErrorPassWordWrongful = 6,//密码强度过低，建议修改
    AutenticationErrorMessageCodeNull = 7,//验证码为空
    AutenticationErrorMessageCodeDefect = 8,//验证码格式错误
    AutenticationErrorMessageWrongFul = 9,//验证码格式错误
    AutenticationErrorAgreePasswordNull = 10,//确认密码为空
    AutenticationErrorIDCareNull = 11,//身份证为空
    AutenticationErrorIDCareError = 12,//身份证格式错误
}AutenticationErrorType;

@implementation NSString (Authentication)

/**
 验证手机号码
 
 @return BOOL
 */
- (BOOL)authenicationIsPhone{
    if (!self || self.length == 0) {
        [self showErrorWithTYpe:AutenticationErrorPhoneNull];
        return NO;
    }
    else if (self.length != 11)
    {
        [self showErrorWithTYpe:AutenticationErrorPhoneError];
        return NO;
    }
    else{
        
        /**
         * 手机号码:
         * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
         * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
         * 联通号段: 130,131,132,155,156,185,186,145,176,1709
         * 电信号段: 133,153,180,181,189,177,1700
         */
        NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0-9])\\d{8}$";
        /**
         * 中国移动：China Mobile
         * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
         */
        NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
        /**
         * 中国联通：China Unicom
         * 130,131,132,155,156,185,186,145,176,1709
         */
        NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        /**
         * 中国电信：China Telecom
         * 133,153,180,181,189,177,1700
         */
        NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        
        /**
         25         * 大陆地区固话及小灵通
         26         * 区号：010,020,021,022,023,024,025,027,028,029
         27         * 号码：七位或八位
         28         */
        //   NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
        
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        
        if (([regextestmobile evaluateWithObject:self] == YES)
            || ([regextestcm evaluateWithObject:self] == YES)
            || ([regextestct evaluateWithObject:self] == YES)
            || ([regextestcu evaluateWithObject:self] == YES))
        {
            return YES;
        }
        else
        {
            [self showErrorWithTYpe:AutenticationErrorPhoneNonExistent];
            return NO;
        }
        
        
    }
}

/**
 验证密码
 
 @return BOOL
 */
- (BOOL)authenicationPassword{
    if (!self || self.length == 0) {
        [self showErrorWithTYpe:AutenticationErrorPasswordNull];
        return NO;
    }
    else if (self.length < 6){
        [self showErrorWithTYpe:AutenticationErrorPasswordDefect];
        return NO;
    }
    else{
#pragma mark - <验证密码强度，可取消>
//        if ([[NSString judgePasswordStrength:self] integerValue] < 2) {
//            [self showErrorWithTYpe:AutenticationErrorPassWordWrongful];
//            return NO;
//        }
//        else{
//            return YES;
//        }
        return YES;
    }
}

/**
 短息验证码
 
 @return BOOL
 */
- (BOOL)authenicationMessageCode{
    if (!self || self.length == 0) {
        [self showErrorWithTYpe:AutenticationErrorMessageCodeNull];
        return NO;
    }
    else if (self.length < 5){
        [self showErrorWithTYpe:AutenticationErrorMessageCodeDefect];
        return NO;
    }
    else{
        return YES;
    }
}


/**
 再次输入密码验证
 
 @return BOOL
 */
- (BOOL)authenicationAgreenPassword{
    if (!self || self.length == 0) {
        [self showErrorWithTYpe:AutenticationErrorAgreePasswordNull];
        return NO;
    }
    else if (self.length < 6){
        [self showErrorWithTYpe:AutenticationErrorPasswordDefect];
        return NO;
    }
    else{
#pragma mark - <验证密码强度，可取消>
        return YES;
//        if ([[NSString judgePasswordStrength:self] integerValue] < 2) {
//            [self showErrorWithTYpe:AutenticationErrorPassWordWrongful];
//            return NO;
//        }
//        else{
//            return YES;
//        }
    }
}

/**
 验证纯数字
 
 @return BOOL
 */
- (BOOL)authenicationOnlyNumber{
    if (!self || self.length == 0) {
        //输入为空
        return NO;
    }
    else{
        NSString *regex = @"[0-9]*";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        if ([pred evaluateWithObject:self]) {
            return YES;
        }
        return NO;
    }
}

- (BOOL)authenicationIdCare{
    if (!self || self.length == 0) {
        [self showErrorWithTYpe:AutenticationErrorIDCareNull];
        return NO;
    }
    else if (![self isHxIdentityCard]){
        [self showErrorWithTYpe:AutenticationErrorIDCareError];
        return NO;
    }
    
    return YES;
}


+ (NSString*) judgePasswordStrength:(NSString*) _password
{
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
    NSString* result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:_password]];
    NSString* result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:_password]];
    NSString* result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:_password]];
    NSString* result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:_password]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result1]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result2]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result3]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result4]];
    int intResult=0;
    for (int j=0; j<[resultArray count]; j++)
        
    {
        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"])
            
        {
            intResult++;
        }
    }
    //NSString *resultString = [[NSString alloc] init];
    //        if (intResult <2)
    //        {
    //            resultString = @"1";//@"密码强度低，建议修改";
    //        }
    //
    //        else if (intResult == 2&&[_password length]>=6)
    //        {
    //            resultString = @"2";//@"密码强度一般";
    //        }
    //
    //        if (intResult > 2&&[_password length]>=6)
    //        {
    //            resultString = @"3";//@"密码强度高";
    //        }
    
    return [NSString stringWithFormat:@"%i",intResult];
}

/*
 声明：包含大写/小写/数字/特殊字符
 两种以下密码强度低
 两种密码强度中
 大于两种密码强度高
 密码强度标准根据需要随时调整
 */
//判断是否包含
+ (BOOL) judgeRange:(NSArray*) _termArray Password:(NSString*) _password
{
    NSRange range;
    BOOL result =NO;
    for(int i=0; i<[_termArray count]; i++)
    {
        range = [_password rangeOfString:[_termArray objectAtIndex:i]];
        if(range.location != NSNotFound)
        {
            result =YES;
        }
    }
    return result;
}

- (void)showErrorWithTYpe:(AutenticationErrorType)type{
    switch (type) {
        case AutenticationErrorPhoneNull:
        {
            [QMUITips showError:@"请输入手机号" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
            break;
        case AutenticationErrorPhoneError:
        {
            [QMUITips showError:@"手机号格式错误" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
            break;
        case AutenticationErrorPhoneNonExistent:
        {
            [QMUITips showError:@"手机号不存在" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
            break;
        case AutenticationErrorPasswordNull:
        {
            [QMUITips showError:@"密码为空" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
            break;
        case AutenticationErrorPasswordDefect:
        {
            [QMUITips showError:@"密码至少6位" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
            break;
        case AutenticationErrorPassWordWrongful:
        {
            [QMUITips showError:@"密码强度过低，建议修改" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
            break;
        case AutenticationErrorMessageCodeNull:
        {
            [QMUITips showError:@"验证码为空" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
            break;
        case AutenticationErrorMessageCodeDefect:
        {
            [QMUITips showError:@"验证码格式错误" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
            break;
        case AutenticationErrorMessageWrongFul:
        {
            [QMUITips showError:@"验证码格式错误" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
            break;
        case AutenticationErrorAgreePasswordNull:
        {
            [QMUITips showError:@"确认密码为空" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
            break;
            case AutenticationErrorIDCareNull:
        {
            [QMUITips showError:@"请输入身份证号码" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
             break;
            case AutenticationErrorIDCareError:
        {
            [QMUITips showError:@"身份证格式错误" inView:KINGWIDWOWN hideAfterDelay:1.0];
        }
             break;
        default:
            break;
    }
}

//表情符号的判断
- (BOOL)stringContainsEmoji {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

-(BOOL)isHxIdentityCard
{
    // 判断位数
    if ([self length] != 15 && [self length] != 18)
    {
        return NO;
    }
    
    NSString *carid = self;
    long lSumQT  = 0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if ([self length] == 15)
    {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++)
        {
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince])
    {
        return NO;
    }
    // 判断年月日是否有效
    // 年份
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];
    // 月份
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];
    // 日
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil)
    {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if( 18 != strlen(PaperId)) return -1;
    // 校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    // 验证最末的校验码
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}

-(BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

@end
