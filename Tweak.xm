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
  if ([dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle] == nil && [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist] == nil) {
    %orig;
  } else if ([dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle] != nil && [dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist] != nil) {
    //  NSString *nowPlaying = [[[%c(SBMediaController) sharedInstance] nowPlayingApplication] bundleIdentifier];
      NSString *songTitle = [[NSString alloc] initWithString:[dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoTitle]];
      NSString *artistTitle = [[NSString alloc] initWithString:[dict objectForKey:(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtist]];
      //NSString *title = [NSString stringWithFormat:@"%@\nBy: %@", songTitle, artistTitle];

  %orig;
  UILabel *NoNotifs = MSHookIvar<UILabel *>(self, "_noNotificationsLabel");
  NoNotifs.text = [NSString stringWithFormat:@"%@ By: %@", songTitle, artistTitle];
}
});
}
%end
