# -*- encoding: utf-8 -*-
# stub: mutant 0.8.2 ruby lib

Gem::Specification.new do |s|
  s.name = "mutant"
  s.version = "0.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Markus Schirp"]
  s.date = "2015-08-11"
  s.description = "Mutation testing for ruby"
  s.email = ["mbj@schirp-dso.com"]
  s.executables = ["mutant"]
  s.extra_rdoc_files = ["TODO", "LICENSE"]
  s.files = ["LICENSE", "TODO", "bin/mutant"]
  s.homepage = "https://github.com/mbj/mutant"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1")
  s.rubygems_version = "2.5.1"
  s.summary = "Mutation testing tool for ruby under MRI and Rubinius"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<parser>, ["~> 2.2.2"])
      s.add_runtime_dependency(%q<ast>, ["~> 2.0"])
      s.add_runtime_dependency(%q<diff-lcs>, ["~> 1.2"])
      s.add_runtime_dependency(%q<parallel>, ["~> 1.3"])
      s.add_runtime_dependency(%q<morpher>, ["~> 0.2.3"])
      s.add_runtime_dependency(%q<procto>, ["~> 0.0.2"])
      s.add_runtime_dependency(%q<abstract_type>, ["~> 0.0.7"])
      s.add_runtime_dependency(%q<unparser>, ["~> 0.2.4"])
      s.add_runtime_dependency(%q<ice_nine>, ["~> 0.11.1"])
      s.add_runtime_dependency(%q<adamantium>, ["~> 0.2.0"])
      s.add_runtime_dependency(%q<memoizable>, ["~> 0.4.2"])
      s.add_runtime_dependency(%q<equalizer>, ["~> 0.0.9"])
      s.add_runtime_dependency(%q<anima>, ["~> 0.2.0"])
      s.add_runtime_dependency(%q<concord>, ["~> 0.1.5"])
      s.add_development_dependency(%q<bundler>, [">= 1.3.5", "~> 1.3"])
      s.add_development_dependency(%q<ffi>, ["~> 1.9.6"])
    else
      s.add_dependency(%q<parser>, ["~> 2.2.2"])
      s.add_dependency(%q<ast>, ["~> 2.0"])
      s.add_dependency(%q<diff-lcs>, ["~> 1.2"])
      s.add_dependency(%q<parallel>, ["~> 1.3"])
      s.add_dependency(%q<morpher>, ["~> 0.2.3"])
      s.add_dependency(%q<procto>, ["~> 0.0.2"])
      s.add_dependency(%q<abstract_type>, ["~> 0.0.7"])
      s.add_dependency(%q<unparser>, ["~> 0.2.4"])
      s.add_dependency(%q<ice_nine>, ["~> 0.11.1"])
      s.add_dependency(%q<adamantium>, ["~> 0.2.0"])
      s.add_dependency(%q<memoizable>, ["~> 0.4.2"])
      s.add_dependency(%q<equalizer>, ["~> 0.0.9"])
      s.add_dependency(%q<anima>, ["~> 0.2.0"])
      s.add_dependency(%q<concord>, ["~> 0.1.5"])
      s.add_dependency(%q<bundler>, [">= 1.3.5", "~> 1.3"])
      s.add_dependency(%q<ffi>, ["~> 1.9.6"])
    end
  else
    s.add_dependency(%q<parser>, ["~> 2.2.2"])
    s.add_dependency(%q<ast>, ["~> 2.0"])
    s.add_dependency(%q<diff-lcs>, ["~> 1.2"])
    s.add_dependency(%q<parallel>, ["~> 1.3"])
    s.add_dependency(%q<morpher>, ["~> 0.2.3"])
    s.add_dependency(%q<procto>, ["~> 0.0.2"])
    s.add_dependency(%q<abstract_type>, ["~> 0.0.7"])
    s.add_dependency(%q<unparser>, ["~> 0.2.4"])
    s.add_dependency(%q<ice_nine>, ["~> 0.11.1"])
    s.add_dependency(%q<adamantium>, ["~> 0.2.0"])
    s.add_dependency(%q<memoizable>, ["~> 0.4.2"])
    s.add_dependency(%q<equalizer>, ["~> 0.0.9"])
    s.add_dependency(%q<anima>, ["~> 0.2.0"])
    s.add_dependency(%q<concord>, ["~> 0.1.5"])
    s.add_dependency(%q<bundler>, [">= 1.3.5", "~> 1.3"])
    s.add_dependency(%q<ffi>, ["~> 1.9.6"])
  end
end
