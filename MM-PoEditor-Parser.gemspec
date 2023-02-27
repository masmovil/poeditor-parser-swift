# coding: utf-8
# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "MM-PoEditor-Parser"
  spec.version       = "1.5.3"
  spec.authors       = ["MásMóvil"]
  spec.email         = ["info@grupomasmovil.com"]

  spec.summary       = "MM ToolKit"
  spec.homepage      = "https://github.com/masmovil/fastlane-plugin-mm_toolkit"
  spec.license       = "Apache-2.0"

  spec.files         = Dir["bin/poe"] + ["README.md", "LICENSE"]
  spec.executables   = ["poe"]
  spec.bindir        = 'bin'

  spec.require_paths = ["bin"]
end