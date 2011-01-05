require 'fileutils'

class StylisticGenerator < ::Rails::Generators::Base
  
  source_root File.expand_path('../templates', __FILE__)
  
  @@styles_dest = 'public/stylesheets/stylistic/'
  @@framework_dest = 'public/stylesheets/framework/'
  @@js_dest = 'public/javascripts/jquery/'
  
  desc "This generator will make your Rails project so stylistic by installing (better) default scaffold styles, popular CSS grid frameworks and jQuery."

  class_option :scaffoldstyles, :type => :boolean, :default => true, :desc => "Get rid of standard scaffold CSS and install Stylistic's scaffold CSS"
  class_option :html5reset, :type => :boolean, :default => true, :desc => "Include html5 CSS resets from http://html5boilerplate.com/"
  class_option :jquery, :type => :boolean, :default => false, :desc => "Get rid of Prototype and install jQuery and jQuery-ujs"
  class_option :jqueryui, :type => :boolean, :default => false, :desc => "Install jQueryUI"
  class_option :gs, :type => :boolean, :default => true, :desc => "Install 960 Grid System CSS framework (http://960.gs/)"
  class_option :squaregrid, :type => :boolean, :default => false, :desc => "Install Squaregrid CSS framework (http://thesquaregrid.com/) instead of 960.gs"
  class_option :blueprint, :type => :boolean, :default => false, :desc => "Install Blueprint CSS framework (http://www.blueprintcss.org/) instead of 960.gs"
  class_option :less, :type => :boolean, :default => false, :desc => "Install Less CSS framework (http://lessframework.com/) instead of 960.gs"
    
  def install_files

    if options.jquery
      clobber_prototype
      include_jquery
    end
    
    include_jqueryui if options.jqueryui 
    
    if options.squaregrid
      include_squaregrid
    elsif options.less
      include_less
    elsif options.blueprint
      include_blueprint
    elsif options.gs
      include_960
    end
    
    include_scaffold if options.scaffoldstyles
    include_html5reset if options.html5reset

  end

  private
    
    def clobber_prototype
      ['controls.js', 'dragdrop.js', 'effects.js', 'prototype.js', 'rails.js'].each do |file|
        remove_file "public/javascripts/#{file}" if File.exist?("public/javascripts/#{file}")
      end
    end
    
    def clobber_cssframework
      if File.directory?(@@framework_dest)
        Dir.foreach(@@framework_dest) do |file|
          remove_file File.join(@@framework_dest, file.to_s) if /.css/.match(file.to_s)
        end
      end
    end
    
    def include_scaffold
      copy_file('stylistic-scaffold.css', File.join(@@styles_dest, 'stylistic-scaffold.css')) unless File.exist?(File.join(@@styles_dest, 'stylistic-scaffold.css'))
    end
    
    def include_html5reset
      copy_file('html5-reset.css', File.join(@@styles_dest, 'html5-reset.css')) unless File.exist?(File.join(@@styles_dest, 'html5-reset.css'))
    end
    
    def include_960
      clobber_cssframework
      copy_file('960.css', File.join(@@framework_dest, '960.css')) unless File.exist?(File.join(@@framework_dest, '960.css'))
    end
    
    def include_squaregrid
      clobber_cssframework
      copy_file('squaregrid.css', File.join(@@framework_dest, 'squaregrid.css')) unless File.exist?(File.join(@@framework_dest, 'squaregrid.css'))
    end
    
    def include_blueprint
      clobber_cssframework
      ['ie.css', 'print.css', 'screen.css'].each do |file|
       copy_file(File.join('blueprint/', file.to_s), File.join(@@framework_dest, file.to_s)) unless File.exist?(File.join(@@framework_dest, file.to_s))
      end
    end
    
    def include_less
      clobber_cssframework
      copy_file('less.css', File.join(@@framework_dest, 'less.css')) unless File.exist?(File.join(@@framework_dest, 'less.css'))
    end
    
    def include_jquery
      copy_file('jquery.min.js', File.join(@@js_dest, 'jquery.min.js')) unless File.exist?(File.join(@@js_dest, 'jquery.min.js'))
      copy_file('rails.js', File.join(@@js_dest, 'rails.js')) unless File.exist?(File.join(@@framework_dest, 'rails.js'))
    end
    
    def include_jqueryui
      copy_file('jquery.ui.min.js', File.join(@@js_dest, 'jquery.ui.min.js')) unless File.exist?(File.join(@@js_dest, 'jquery.ui.min.js'))
    end

end
