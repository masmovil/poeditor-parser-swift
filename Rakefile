task default: %w[setup]

task(:setup) do
  raise '`brew` is required. Please install brew. https://brew.sh/' unless system('which brew')

  puts('➡️  Bundle')
  sh('brew bundle')
  sh('bundle install')

  puts('➡️  Overcommit')
  sh('bundle exec overcommit --install')
  sh('bundle exec overcommit --sign')
  sh('bundle exec overcommit --sign pre-commit')
  sh('bundle exec overcommit --sign pre-push')

  puts('➡️  SPM Resolve Dependencies')
  sh('xcodebuild -resolvePackageDependencies')
end

task :package do
  sh("xcrun swift build -c release --arch arm64 --arch x86_64")
  sh("cp ./.build/apple/Products/Release/poe ./bin/")
end