module SprocketsApplication
  mattr_accessor :use_page_caching
  self.use_page_caching = false

  class << self
    def routes(map)
      map.resource(:sprockets)
    end

    def source(group = nil)
      @group = group || "default"
      concatenation.to_s
    end

    def install_script
      concatenation.save_to(asset_path)
    end

    def install_assets
      secretary.install_assets
    end

    protected
    
      def secretaries
        @secretaries ||= {}
      end
      
      def secretary
        secretaries[@group] ||= Sprockets::Secretary.new(configuration[@group].symbolize_keys.merge(:root => ::Rails.root.to_s))
      end

      def configuration
        YAML.load(IO.read(File.join(::Rails.root.to_s, "config", "sprockets.yml"))) || {}
      end

      def concatenation
        secretary.reset! unless source_is_unchanged?
        secretary.concatenation
      end

      def asset_path
        File.join(Rails.public_path, "sprockets.js")
      end

      def source_is_unchanged?
        previous_source_last_modified, @source_last_modified =
          @source_last_modified, secretary.source_last_modified

        previous_source_last_modified == @source_last_modified
      end
  end
end