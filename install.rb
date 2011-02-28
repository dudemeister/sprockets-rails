require "fileutils"
include FileUtils::Verbose

Rails.root = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..")) unless defined?(Rails.root)

mkdir_p File.join(Rails.root, "vendor", "sprockets")
mkdir_p File.join(Rails.root, "app", "javascripts")
touch   File.join(Rails.root, "app", "javascripts", "application.js")

unless File.exists?(File.join(Rails.root, "config", "sprockets.yml"))
cp      File.join(File.dirname(__FILE__), "config", "sprockets.yml"), 
        File.join(Rails.root, "config")
end
