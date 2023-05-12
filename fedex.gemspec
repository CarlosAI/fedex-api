# frozen_string_literal: true

require_relative "lib/fedex/version"

Gem::Specification.new do |spec|
  spec.name = "fedex"
  spec.version = Fedex::VERSION
  spec.authors = ["CarlosAI"]
  spec.email = ["carloswesker@outlook.es"]

  spec.summary = "A Ruby interface to the FedEx API."
  spec.description = "A Ruby gem that provides a simple and flexible way to access the FedEx API."
  spec.homepage = "https://github.com/CarlosAI/fedex-api" # or put the URL of your gem's homepage here
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  #spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  #spec.metadata["homepage_uri"] = spec.homepage
  #spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.files = Dir['lib/**/*', 'templates/**/*']
  spec.extra_rdoc_files = ['README.md', 'LICENSE.txt']

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nori", "~> 2.6"
  spec.add_dependency "rspec", "~> 3.10"

end
