#!/usr/bin/env ruby

raise 'Swiftlint failed' unless system('swiftlint autocorrect')
