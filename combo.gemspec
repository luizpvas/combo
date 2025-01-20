require_relative "lib/combo/version"

Gem::Specification.new do |spec|
  spec.name        = "combo"
  spec.version     = Combo::VERSION
  spec.authors     = [ "Luiz Vasconcellos" ]
  spec.email       = [ "luizpvasc@gmail.com" ]
  spec.homepage    = "https://github.com/luizpvas/combo"
  spec.summary     = "Full stack components for Rails"
  spec.description = "Full stack components for Rails"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 8.0.1"
end
