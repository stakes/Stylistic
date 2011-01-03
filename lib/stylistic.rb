require 'rails'

class Stylistic < ::Rails::Railtie
  
  generators do
    require 'generators/stylistic/stylistic_generator.rb'
  end
  
  config.before_configuration do
        
    javascripts = []
    Dir.foreach(::Rails.root.join("public/javascripts/jquery")) { |file| javascripts << file.to_s if /.js/.match(file.to_s) }
    
    stylesheets = []
    Dir.foreach(::Rails.root.join("public/stylesheets/")) { |file| stylesheets << file.to_s if /stylistic-scaffold.css/.match(file.to_s) }
    
    framework = []
    Dir.foreach(::Rails.root.join("public/stylesheets/framework/")) { |file| framework << 'framework/'+file.to_s if /.css/.match(file.to_s) }

    ActionView::Helpers::AssetTagHelper.register_javascript_expansion :stylistic => javascripts
    ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :stylistic => framework | stylesheets
    
  end
  
end

