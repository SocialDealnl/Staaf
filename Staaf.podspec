Pod::Spec.new do |s|
  s.name         = 'Staaf'
  s.version      = '0.0.1'
  s.summary      = ''
  s.homepage     = 'https://github.com/robhendriks/Staaf'
  s.license      = 'MIT'
  s.author       = { 'Rob Hendriks' => 'robhendriks@shareforce.eu' }
  s.platform     = :ios, '9.0'
  s.source       = { :git => 'https://github.com/robhendriks/Staaf.git', :commit => '2bdcaf31672097f60dd7dac6f06e3742ff079ff3' }
  s.source_files = 'Source/*.swift'
end
