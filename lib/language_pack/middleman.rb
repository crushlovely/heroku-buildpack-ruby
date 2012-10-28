require "language_pack"
require "language_pack/rack"

# Middleman Language Pack.
class LanguagePack::Middleman < LanguagePack::Rack

  # detects if this is a valid Middleman site by seeing if
  # "source" directory and "config.rb" file both exist
  # @return [Boolean] true if it's a Middleman app
  def self.use?
    super && Dir.exist?("source") && File.exist?("config.rb")
  end

  def name
    "Middleman"
  end

  def compile
    super
    allow_git do
      build_middleman_site
    end
  end

  private

  def build_middleman_site
    topic("Building Middleman Site")
    pipe("env PATH=$PATH bundle exec middleman build --clean 2>&1")
  end
end
