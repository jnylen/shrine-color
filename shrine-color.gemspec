lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "shrine-color"
  spec.version       = "0.3.1"
  spec.authors       = ["Joakim Nylen"]
  spec.email         = ["rubygems@joakim.nylen.nu"]
  spec.summary       = "Return the dominant color of an image in Shrine."
  spec.description   = "Return the dominant color of an image in Shrine."
  spec.homepage      = "https://github.com/jnylen/shrine-color"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_dependency "shrine", ">= 2.0", "<= 4.0"
  spec.add_dependency "jnylen-colorscore", "~> 0.1", ">= 0.1.3"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 11.1"
  spec.add_development_dependency "rspec", "~> 3.0"
end
