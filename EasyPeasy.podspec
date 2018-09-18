Pod::Spec.new do |s|
  s.name             = "EasyPeasy"
  s.version          = "1.7.0"
  s.summary          = "EasyPeasy is a Swift framework that eases the creation of
                        Autolayout constraints programmatically"
  s.description      = <<-DESC
                        EasyPeasy is a Swift framework that lets you create Autolayout constraints
                        programmatically without headaches and never ending boilerplate code. Besides the
                        basics, **EasyPeasy** resolves most of the constraint conflicts for you and lets
                        you attach to a constraint conditional closures that are evaluated before applying
                        a constraint, this lets you apply (or not) a constraint depending on platform, size
                        classes, orientation... or the state of your controller, easy peasy!
                       DESC
  s.homepage         = "https://github.com/nakiostudio/EasyPeasy"
  s.license          = 'MIT'
  s.author           = { "Carlos Vidal" => "nakioparkour@gmail.com" }
  s.source           = { :git => "https://github.com/nakiostudio/EasyPeasy.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/carlostify'

  s.ios.deployment_target     = '8.0'
  s.tvos.deployment_target    = '9.0'
  s.osx.deployment_target     = '10.10'

  s.requires_arc = true
  s.source_files = 'EasyPeasy/**/*'
end

