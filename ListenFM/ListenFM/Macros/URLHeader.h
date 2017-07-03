//
//  URLHeader.h
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.




// 下载界面（id）(首页是item_value或者id   五位数)
#define URL_Download(A) [NSString stringWithFormat:@"http://api.duotin.com/album?album_id=%ld&page_size=100&device_key=99000566491827&platform=android&source=danxinben&page=1&device_token=AvQX6QBlZNMuXXvDoMIyI8hfDFbUdYDAQy9uOnpK6cu3&user_key=&sort_type=0&package=com.duotin.fm&version=2.7.12", A]

// 播放界面(item_value或者album_id)
#define URL_Play(A) [NSString stringWithFormat:@"http://api.duotin.com/content?device_key=cc%3Abb%3Aaa%3A29%3Afb%3A13&platform=android&content_id=%@&source=danxinben&device_token=ArJL3AnnMwulnEogN2K74q1lJMiKzW-1i8TUwL_3-2hJ&user_key=&package=com.duotin.fm&channel=duotin&version=2.7.12", A]

#define URL_TempPlay(A) [NSString stringWithFormat:@"http://api.duotin.com/album/page?album_id=0&page_size=100&device_key=868795020115594&platform=android&content_id=%@&source=danxinben&device_token=AiMYrTYgRPeJs_OdvQpluLieSlgHuTtZTnn0uW8F_MqB&user_key=&sort_type=0&package=com.duotin.fm&channel=wandoujia&version=2.7.12", A]


// 首页
#define URL_Home @"http://api.duotin.com/homepage/index?device_key=cc%3Abb%3Aa3A29%3Afb%3A13&platform=android&source=danxinben&device_token=ArJL3AnnMwulnEogN2K74q1lJMiKzW-1i8TUwL_3-2hJ&user_key=&package=com.duotin.fm&channel=duotin&version=2.7.12"

// 首页->专题、热门（more）（id）
#define URL_Home_ZTmore(A) [NSString stringWithFormat:@"http://api.duotin.com/recommend/more?page_size=20&device_key=cc%3Abb%3Aaa%3A29%3Afb%3A13&platform=android&source=danxinben&page=1&device_token=ArJL3AnnMwulnEogN2K74q1lJMiKzW-1i8TUwL_3-2hJ&user_key=&package=com.duotin.fm&type=&recommend_category_id=%ld&channel=duotin&version=2.7.12", A]


// 首页->热门播客、音乐调频（more）
#define URL_Home_RMBKmore @"http://api.duotin.com/radio/index?device_key=99000566491827&platform=android&source=danxinben&device_token=AvQX6QBlZNMuXXvDoMIyI8hfDFbUdYDAQy9uOnpK6cu3&user_key=&package=com.duotin.fm&version=2.7.12"

// 首页->相声剧场、热门小说、亲子教育、段子来了、历史人文、心情电台、财经调频（more）（redirect_value）
#define URL_Home_XSJCmore(A) [NSString stringWithFormat:@"http://api.duotin.com/category/content?page_size=20&device_key=cc%3Abb%3Aaa%3A29%3Afb%3A13&platform=android&source=danxinben&page=1&device_token=ArJL3AnnMwulnEogN2K74q1lJMiKzW-1i8TUwL_3-2hJ&user_key=&sub_category_id=0&sort_type=2&package=com.duotin.fm&category_id=%@&channel=duotin&version=2.7.12", A]

// 频道->热门话题
#define URL_ChannelHot @"http://api.duotin.com/topic/list?page_size=20&device_key=99000566491827&platform=android&source=danxinben&page=1&device_token=AvQX6QBlZNMuXXvDoMIyI8hfDFbUdYDAQy9uOnpK6cu3&user_key=&package=com.duotin.fm&version=2.7.12"
// 频道->热门话题->二级界面（id）
#define URL_ChannelHot_Second(A) [NSString stringWithFormat:@"http://api.duotin.com/topic/albums?page_size=20&device_key=99000566491827&platform=android&source=danxinben&page=1&device_token=AvQX6QBlZNMuXXvDoMIyI8hfDFbUdYDAQy9uOnpK6cu3&user_key=&package=com.duotin.fm&topic_id=%ld&version=2.7.12", A]

// 频道->排行榜
#define URL_ChannelRank @"http://api.duotin.com/rank/listen?page_size=20&device_key=99000566491827&platform=android&source=danxinben&page=1&device_token=AvQX6QBlZNMuXXvDoMIyI8hfDFbUdYDAQy9uOnpK6cu3&user_key=&package=com.duotin.fm&period_type=day&version=2.7.12"

#define URL_Rank_Music(A) [NSString stringWithFormat:@"http://218.200.160.29/rdp2/v5.5/rankinfo.do?groupcode=365905/365918/469202/469231&pageno=%ld&ua=Iphone_Sst&version=4.243", A]
#define URL_Rank_Net(A) [NSString stringWithFormat:@"http://218.200.160.29/rdp2/v5.5/rankinfo.do?groupcode=365905/365918/469202/614523&pageno=%ld&ua=Iphone_Sst&version=4.243", A]
#define URL_Rank_Oiginal(A) [NSString stringWithFormat:@"http://218.200.160.29/rdp2/v5.5/rankinfo.do?groupcode=365905/365918/469202/2784353&pageno=%ld&ua=Iphone_Sst&version=4.243", A]


// 频道->新增
#define URL_ChannelNewAdd @"http://api.duotin.com/album/latest?page_size=20&device_key=99000566491827&platform=android&source=danxinben&page=1&device_token=AvQX6QBlZNMuXXvDoMIyI8hfDFbUdYDAQy9uOnpK6cu3&user_key=&package=com.duotin.fm&version=2.7.12"

// 频道->大家在听
#define URL_ChannelListen @"http://api.duotin.com/userListening?page_size=20&device_key=99000566491827&platform=android&source=danxinben&page=1&device_token=AvQX6QBlZNMuXXvDoMIyI8hfDFbUdYDAQy9uOnpK6cu3&user_key=&package=com.duotin.fm&version=2.7.12"




