//
//  MSGlobal.h
//  Meshi365
//
//  Created by Akifumi on 2012/10/31.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

/* keys : { "name" , "uiid" , "profile_image_url" } */
#define URL_OF_SIGN_UP                      @"http://aqueous-brushlands-6933.herokuapp.com/api/signup"
#define URL_OF_GET_FRIENDS(uiid)            [NSString stringWithFormat:@"http://aqueous-brushlands-6933.herokuapp.com/api/%@/friends", uiid]
#define URL_OF_GET_REQUESTING_USERS(uiid)   [NSString stringWithFormat:@"http://aqueous-brushlands-6933.herokuapp.com/api/%@/requesting_users", uiid]
/* keys : { "from_user_uiid" , "to_user_uiid" } */
#define URL_OF_SEND_FRIEND_REQUEST          @"http://aqueous-brushlands-6933.herokuapp.com/api/send_friend_request"

#define URL_OF_POST_FOOD_PICTURE            @"http://aqueous-brushlands-6933.herokuapp.com/api/post/food_picture"
#define URL_OF_FOOD_LINE_PICTURES           @"http://aqueous-brushlands-6933.herokuapp.com/food_pictures"