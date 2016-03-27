Pod::Spec.new do |s|
  s.name             = "EasyPeasy"
  s.version          = "0.1"
  s.summary          = "A short description of EasyPeasy."
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/nakiostudio/EasyPeasy"
  s.license          = 'MIT'
  s.author           = { "Carlos Vidal" => "nakioparkour@gmail.com" }
  s.source           = { :git => "https://github.com/nakiostudio/EasyPeasy.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/carlostify'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.frameworks = 'UIKit'
end
