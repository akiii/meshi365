//
//  MSGlobal.h
//  Meshi365
//
//  Created by Akifumi on 2012/10/31.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

/* params keys : { "name" , "uiid" , "profile_image_url" } */
#define URL_OF_SIGN_UP                      @"http://morning-depths-1177.herokuapp.com/api/signup"
#define URL_OF_GET_FRIENDS(uiid)            [NSString stringWithFormat:@"http://morning-depths-1177.herokuapp.com/api/%@/friends", uiid]
#define URL_OF_GET_REQUESTING_USERS(uiid)   [NSString stringWithFormat:@"http://morning-depths-1177.herokuapp.com/api/%@/requesting_users", uiid]
/* params keys : { "from_user_uiid" , "to_user_uiid" } */
#define URL_OF_SEND_FRIEND_REQUEST          @"http://morning-depths-1177.herokuapp.com/api/send_friend_request"

/* params keys : { "uiid" , "url" , "store_name" , "menu_name", "menity" , "comment" , "star_num" } */
#define URL_OF_POST_FOOD_PICTURE            @"http://morning-depths-1177.herokuapp.com/api/post/food_picture"
#define URL_OF_FOOD_LINE_PICTURES           @"http://morning-depths-1177.herokuapp.com/food_pictures"