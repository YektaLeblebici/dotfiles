#!/bin/sh
# Defaults - Written for macOS 26 Tahoe
# Yekta Leblebici <yekta@iamyekta.com>


# Dock & UI preferences
defaults write com.apple.dock expose-animation-duration -float 0.12
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.2
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock orientation bottom
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 44
defaults write com.apple.dock "static-only" -bool "true" # Only show running apps

# Finder
defaults write com.apple.Finder AppleShowAllFiles true
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "CreateDesktop" -bool "false" # Hide desktop icons

# Keyboard settings
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g ApplePressAndHoldEnabled -bool false

# Screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 300

# Google Chrome

## Disable two-finger back-forward gesture.
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE

## Manifest v2
defaults write com.google.Chrome.plist ExtensionManifestV2Availability -int 2

# Shortcuts
APP_ID="com.google.Chrome"
ellipsis="$(printf '\342\200\246')"     # …
defaults write "$APP_ID" NSUserKeyEquivalents -dict-add "Select Previous Tab" '~^$h'
defaults write "$APP_ID" NSUserKeyEquivalents -dict-add "Select Next Tab" '~^$l'
defaults write "$APP_ID" NSUserKeyEquivalents -dict-add "Search Tabs${ellipsis}" '~^$y'

# Force restart cfprefsd (for shortcuts)
killall cfprefsd 2>/dev/null || true

# Force restart components to apply changes
killall Dock
killall Finder
killall SystemUIServer
