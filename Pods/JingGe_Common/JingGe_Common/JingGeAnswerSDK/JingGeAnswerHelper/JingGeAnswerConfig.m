//
//  JingGeAnswerConfig.m
//  JingGe_Common
//
//  Created by 景格_徐薛波 on 2017/7/4.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

#import "JingGeAnswerConfig.h"
#import "JingGeMacro.h"
@implementation JingGeAnswerConfig

- (UIColor *)jingGeAnswerMainColor {
    if (!_jingGeAnswerMainColor) {
        _jingGeAnswerMainColor = UIColorFromHex(0xf2ba00);
    }
    return _jingGeAnswerMainColor;
}

- (UIColor *)jingGeQuestionTextColor {
    if (!_jingGeQuestionTextColor) {
        _jingGeQuestionTextColor = UIColorFromHex(0x333330);
    }
    return _jingGeQuestionTextColor;
}

- (UIColor *)jingGeOptionTextColor {
    if (!_jingGeOptionTextColor) {
        _jingGeOptionTextColor = UIColorFromHex(0x4c4c49);
    }
    return _jingGeOptionTextColor;
}

- (UIColor *)jingGeAnswerBtnTextColor {
    if (!_jingGeAnswerBtnTextColor) {
        _jingGeAnswerBtnTextColor = UIColorFromHex(0x333330);
    }
    return _jingGeAnswerBtnTextColor;
}

- (UIColor *)jingGeAnswerFaultColor {
    if (!_jingGeAnswerFaultColor) {
        _jingGeAnswerFaultColor = UIColorFromHex(0xe85f40);
    }
    return _jingGeAnswerFaultColor;
}

- (UIColor *)jingGeAnswerLineColor {
    if (!_jingGeAnswerLineColor) {
        _jingGeAnswerLineColor = UIColorFromHex(0xcccccc);
    }
    return _jingGeAnswerLineColor;
}

- (UIColor *)jingGeParsingOptionBtnColor {
    if (!_jingGeParsingOptionBtnColor) {
        _jingGeParsingOptionBtnColor = UIColorFromHex(0x999990);
    }
    return _jingGeParsingOptionBtnColor;
}

- (UIColor *)jingGeAnswerTruetColor {
    if (!_jingGeAnswerTruetColor) {
        _jingGeAnswerTruetColor = UIColorFromHex(0x10c55b);
    }
    return _jingGeAnswerTruetColor;
}

- (UIColor *)jingGeAnswerSheetTextColor {
    if (!_jingGeAnswerSheetTextColor) {
        _jingGeAnswerSheetTextColor = UIColorFromHex(0x73736d);
    }
    return _jingGeAnswerSheetTextColor;
}

- (UIImage *)jingGeAnswerPlaceHolderImage {
    if (!_jingGeAnswerPlaceHolderImage) {
        _jingGeAnswerPlaceHolderImage = [UIImage new];
    }
    return _jingGeAnswerPlaceHolderImage;
}

- (UIImage *)jingGeAnswerSubmitImage {
    if (!_jingGeAnswerSubmitImage) {
        _jingGeAnswerSubmitImage = kGetImage(@"img_sheet_card");
    }
    return _jingGeAnswerSubmitImage;
}

- (UIFont *)jingGeOptionTextFont {
    if (!_jingGeOptionTextFont) {
        _jingGeOptionTextFont = UISYSTEM_FONT(15);
    }
    return _jingGeOptionTextFont;
}

- (UIFont *)jingGeQuestionTextFont {
    if (!_jingGeQuestionTextFont) {
        _jingGeQuestionTextFont = UISYSTEM_FONT(15);
    }
    return _jingGeQuestionTextFont;
}

- (UIFont *)jingGeAnswerBtnTextFont {
    if (!_jingGeQuestionTextFont) {
        _jingGeQuestionTextFont = UISYSTEM_FONT(16);
    }
    return _jingGeQuestionTextFont;
}

- (UIFont *)jingGeParsingTitleFont {
    if (!_jingGeParsingTitleFont) {
        _jingGeParsingTitleFont = UISYSTEM_FONT(16);
    }
    return _jingGeParsingTitleFont;
}

- (UIFont *)jingGeParsingDetailFont {
    if (!_jingGeParsingDetailFont) {
        _jingGeParsingDetailFont = UISYSTEM_FONT(14);
    }
    return _jingGeParsingDetailFont;
}

- (UIFont *)jingGeAnswerNaviTitleFont {
    if (!_jingGeAnswerNaviTitleFont) {
        _jingGeAnswerNaviTitleFont = UIBOLD_SYSTEM_FONT(17);
    }
    return _jingGeAnswerNaviTitleFont;
}

- (UIColor *)jingGeAnswerNaviTitleColor {
    if (!_jingGeAnswerNaviTitleColor) {
        _jingGeAnswerNaviTitleColor = UIColorFromHex(0x333330);
    }
    return _jingGeAnswerNaviTitleColor;
}

@end
