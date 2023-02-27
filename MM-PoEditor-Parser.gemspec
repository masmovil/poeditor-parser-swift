# coding: utf-8
# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "MM-PoEditor-Parser"
  spec.version       = Fastlane::MmToolkit::VERSION
  spec.authors       = ["MásMóvil"]
  spec.email         = ["info@grupomasmovil.com"]

  spec.summary       = "MM ToolKit"
  spec.homepage      = "https://github.com/masmovil/fastlane-plugin-mm_toolkit"
  spec.license       = "Apache-2.0"

  spec.files         = Dir["bin/*"] + ["README.md", "LICENSE"]
  spec.require_paths = ["bin"]
end