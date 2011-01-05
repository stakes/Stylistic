require 'rails'

class Stylistic < ::Rails::Railtie
  
  generators do
    require 'generators/stylistic/stylistic_generator.rb'
  end
  
  config.before_configuration do
        
    javascripts = []
    Dir.foreach(::Rails.root.join("public/javascripts/jquery/")) { |file| javascripts << 'jquery/'+file.to_s if /.js/.match(file.to_s) } if File.directory?(::Rails.root.join("public/javascripts/jquery/"))
    
    stylesheets = []
    Dir.foreach(::Rails.root.join("public/stylesheets/stylistic/")) { |file| stylesheets << 'stylistic/'+file.to_s if /.css/.match(file.to_s) } if File.directory?(::Rails.root.join("public/stylesheets/stylistic/"))
    
    framework = []
    Dir.foreach(::Rails.root.join("public/stylesheets/framework/")) { |file| framework << 'framework/'+file.to_s if /.css/.match(file.to_s) } if File.directory?(::Rails.root.join("public/stylesheets/framework/"))

    ActionView::Helpers::AssetTagHelper.register_javascript_expansion :stylistic => javascripts
    ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :stylistic => framework | stylesheets
    
  end
  
end

