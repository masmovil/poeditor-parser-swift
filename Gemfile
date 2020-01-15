# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "fastlane"
gem "trainer"
gem "overcommit"
gem "xcpretty-json-formatter"
gem "danger"
gem "danger-xcodebuild"
gem "danger-swiftlint"
gem "danger-xcov"
gem "danger-junit"
gem "danger-xcode_summary"
gem "cocoapods"
gem "xcov"
gem "xcode-install"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
