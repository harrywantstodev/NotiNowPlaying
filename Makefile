include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotiNowPlaying
NotiNowPlaying_FILES = Tweak.xm
NotiNowPlaying_PRIVATE_FRAMEWORKS = MediaRemote

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
