Pod::Spec.new do |s|
  s.name             = "DeckOfCards"
  s.version          = "0.1.0"
  s.summary          = "Deck of cards."

  s.description      = <<-DESC
                        Deck of cards.
                       DESC

  s.homepage         = "https://github.com/lkzhao/DeckOfCards"
  s.screenshots      = "https://github.com/lkzhao/DeckOfCards/blob/master/Resources/DeckOfCardsLogo@2x.png?raw=true"
  s.license          = 'MIT'
  s.author           = { "Luke" => "lzhaoyilun@gmail.com" }
  s.source           = { :git => "https://github.com/lkzhao/DeckOfCards.git", :tag => s.version.to_s }
  
  s.ios.deployment_target  = '8.0'
  s.ios.frameworks         = 'UIKit', 'Foundation'

  s.requires_arc = true

  s.source_files = 'Sources/*.swift'
end
