#! /bin/bash --login

echo "Checking for Homebrew..."
hash brew ||
{
  echo "Downloading Homebrew";
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

brew update
brew install python
brew install ruby

rvm use 2.0 2>/dev/null

echo 'Install bundler for ruby gem management'
gem install bundler
echo 'Install the gems'
bundle install
echo 'Install [xUnique](https://github.com/truebit/xUnique)'
pip install --user xunique

echo 'Install source dependencies';
pod install

echo "Now opening BetTip.xcworkspace in Xcode"
open BetTip.xcworkspace/
