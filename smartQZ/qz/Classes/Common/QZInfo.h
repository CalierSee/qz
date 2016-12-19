//
//  QZInfo.h
//  qztourist
//
//  Created by 景彦铭 on 2016/11/27.
//  Copyright © 2016年 景彦铭. All rights reserved.
//

#ifndef QZInfo_h
#define QZInfo_h
typedef enum {
    THIRDLOGINWECHAT = 1,
    THIRDLOGINDQQ,
    THIRDLOGINSINA
}THIRDLOGIN;
#define ChangeRootViewController @"ChangeRootViewController"
#define LoginSuccess @"LoginSuccess"
//user
#define UserInfoPathKey @"UserInfoPathKey"
#define UserPathKey @"UserPathKey"
//sina
#define SinaAppKey @"2566652957"
#define SinaAppSecret @"1496156c021a3400934ce3003baaa48a"
#define SinaBaseURL @"https://api.weibo.com/"
#define SinaOauthURL @"oauth2/authorize"
#define SinaOauthOKURL @"www.baidu.com"
#define SinaOauthFaildURL @"www.qq.com"
#define SinaTokenURL @"oauth2/access_token"
#define SinaCancelOauthURL @"OAuth2/revokeoauth2"
#define SinaUserAccountURL @"2/users/show.json"
//qq
#define QQAppKey @"1105774493"
#define QQAppID @"awitXiTfiIIxO9SP"
#define QQBaseURL @"https://graph.qq.com/"
#define QQOauthURL @"oauth2.0/authorize"
#define QQOauthOKURL @"www.baidu.com"
#define QQOauthFaildURL @"www.qq.com"
#define QQTokenURL @"oauth2.0/token"
#define QQOpenIDURL @"oauth2.0/me"
#define QQCancelOauthURL 
#define QQUserAccountURL @"user/get_user_info"
//weixin

#endif /* QZInfo_h */
