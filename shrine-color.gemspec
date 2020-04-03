lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'shrine-color'
  spec.version = '1.0.0'
  spec.authors = ['Joakim Nylen']
  spec.email = %w[rubygems@joakim.nylen.nu]
  spec.summary = 'Return the dominant color of an image in Shrine.'
  spec.description = 'Return the dominant color of an image in Shrine.'
  spec.homepage = 'https://github.com/jnylen/shrine-color'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.require_paths = %w[lib]

  spec.add_dependency 'shrine', '>= 2.0', '<= 4.0'
  spec.add_dependency 'miro', '~> 0.4.0'
  spec.add_dependency 'color'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
