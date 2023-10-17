Gem::Specification.new do |s|
  s.name        = 'barocert'
  s.version     = '1.1.0'
  s.date        = '2023-10-16'
  s.summary     = 'barocert API SDK'
  s.description = 'barocert API SDK'
  s.authors     = ["Linkhub Dev"]
  s.email       = 'code@linkhub.co.kr'
  s.files       = [
    "lib/barocert.rb",
    "lib/barocert/kakaocert.rb",
    "lib/barocert/passcert.rb"
  ]
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/barocert/barocert.ruby'
  s.required_ruby_version = '>= 2.0.0'
  s.add_runtime_dependency 'linkhub', '1.5.0'
end
