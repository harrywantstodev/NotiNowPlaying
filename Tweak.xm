#import <UIKit/UIKit.h>
#import "MediaRemote.h"

@interface SBMediaController : NSObject
+ (id)sharedInstance;
- (id)nowPlayingApplication;
@end

%hook NCNotificationNoContentView
- (void)layoutSubviews {

  MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {

  NSDictionary *dict = (__bridge NSDictionary *)(information);

        NSString *songTitle = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle];

        NSString *artistTitle = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist];

  // if ([dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle] == nil && [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist] == nil) {
  if ((songTitle == nil) && (artistTitle == nil)) {

    %orig;

  } else if ((songTitle != nil) && (artistTitle != nil)) {
      //
      // NSString *songTitle = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle];
      //
      // NSString *artistTitle = [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist];

  %orig;

  UILabel *NoNotifs = MSHookIvar<UILabel *>(self, "_noNotificationsLabel");

  NoNotifs.text = [NSString stringWithFormat:@"%@ By: %@", songTitle, artistTitle];
}
});
}
%end
