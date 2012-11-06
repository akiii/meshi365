//
//  MSGlobal.h
//  Meshi365
//
//  Created by Akifumi on 2012/10/31.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#define LOCAL       0
#define STAGING     1
#define PRODUCTION  2

#define DEFAULT_BGCOLOR [UIColor colorWithRed:1.0 green:0.93 blue:0.8 alpha:1.0]

#define FOOD_LINE_IMAGE_INDICATOR_TRANSFORM CGAffineTransformMakeScale(3.0f,3.0f)


#define FOOD_LINE_PROFILE_INDICATOR_TRANSFORM CGAffineTransformMakeScale(1.5f, 1.5f)

#define DEFAULT_INDICATOR_COLOR  [UIColor colorWithRed:0.4 green:0.0 blue:0.1 alpha:1.0]

#define ENVIRONMENT STAGING

#if ENVIRONMENT == LOCAL

#define SERVER_BASE_URL @"http://localhost:3000"

#elif ENVIRONMENT == STAGING

#define SERVER_BASE_URL @"http://morning-depths-1177.herokuapp.com"

#elif ENVIRONMENT == PRODUCTION

#define SERVER_BASE_URL @"http://morning-depths-1177.herokuapp.com"

#endif

/* params keys : { "name" , "uiid" , "profile_image_file_name" } */
#define URL_OF_SIGN_UP                      [NSString stringWithFormat:@"%@/api/signup", SERVER_BASE_URL]
/* params keys : { "uiid" } */
#define URL_OF_ME                           [NSString stringWithFormat:@"%@/api/me", SERVER_BASE_URL]
#define URL_OF_GET_FRIENDS(uiid)            [NSString stringWithFormat:@"%@/api/%@/friends", SERVER_BASE_URL, uiid]
#define URL_OF_GET_REQUESTING_USERS(uiid)   [NSString stringWithFormat:@"%@/api/%@/requesting_users", SERVER_BASE_URL, uiid]
/* params keys : { "from_user_uiid" , "to_user_uiid" } */
#define URL_OF_SEND_FRIEND_REQUEST          [NSString stringWithFormat:@"%@/api/send_friend_request", SERVER_BASE_URL]

#define URL_OF_POST_FOOD_PICTURE            [NSString stringWithFormat:@"%@/api/post/food_picture", SERVER_BASE_URL]
/* params keys : { "uiid" , "file_name" , "store_name" , "menu_name", "menity" , "comment" , "star_num" } */
#define URL_OF_FOOD_LINE(uiid)              [NSString stringWithFormat:@"%@/api/%@/food_line", SERVER_BASE_URL, uiid]
/* params keys : { "my_uiid" , "since_date" , "to_date" } */
#define URL_OF_CALENDER(uiid)               [NSString stringWithFormat:@"%@/api/%@/calender", SERVER_BASE_URL, uiid]

/* params keys : { "word" } */
#define URL_OF_SEARCH_USERS(uiid)           [NSString stringWithFormat:@"%@/api/%@/friends/search", SERVER_BASE_URL, uiid]

#define URL_OF_RECOMMEND_STORES(uiid)       [NSString stringWithFormat:@"%@/api/%@/recommend/group/stores", SERVER_BASE_URL, uiid]