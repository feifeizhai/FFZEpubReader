//
//  JingGeNotificationMacro.h
//  JingGe_Commen
//
//  Created by 景格_徐薛波 on 17/4/17.
//  Copyright © 2017年 景格_徐薛波. All rights reserved.
//

/**
 这是一个通知相关的宏文件
 */

#define POST_NOTIFY(__NAME, __OBJ, __INFO) [[NSNotificationCenter defaultCenter] postNotificationName:__NAME object:__OBJ userInfo:__INFO];

#define LISTEN_NOTIFY(__NAME, __OBSERVER, __SELECTOR) [[NSNotificationCenter defaultCenter] addObserver:__OBSERVER selector:__SELECTOR name:__NAME object:nil];

#define REMOVE_NOTIFY(__OBSERVER) [[NSNotificationCenter defaultCenter] removeObserver:__OBSERVER];
