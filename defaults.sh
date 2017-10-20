#!/bin/sh
# Defaults - Written for OS X High Sierra 10.13
# Yekta Leblebici <yekta@iamyekta.com>

# Finder, Dock and UI Preferences
defaults write com.apple.Finder AppleShowAllFiles true
defaults write com.apple.dock expose-animation-duration -float 0.12
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.2
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock orientation bottom
defaults write com.apple.dock show-process-indicators -bool true

# Keyboard settings
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write -g ApplePressAndHoldEnabled -bool false

# Screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 300
# Safari
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write -g WebKitDeveloperExtras -bool true

# Force restart Dock.
killall Dock
