# -*- encoding: utf-8 -*-
# stub: morpher 0.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "morpher"
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Markus Schirp"]
  s.date = "2014-04-22"
  s.description = "Composeable predicates on POROs"
  s.email = ["mbj@schirp-dso.com"]
  s.extra_rdoc_files = ["TODO", "LICENSE"]
  s.files = ["LICENSE", "TODO"]
  s.homepage = "https://github.com/mbj/morpher"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.5.1"
  s.summary = "Composeable predicates on POROs"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<abstract_type>, ["~> 0.0.7"])
      s.add_runtime_dependency(%q<ast>, ["~> 2.0.0"])
      s.add_runtime_dependency(%q<adamantium>, ["~> 0.2.0"])
      s.add_runtime_dependency(%q<ice_nine>, ["~> 0.11.0"])
      s.add_runtime_dependency(%q<equalizer>, ["~> 0.0.9"])
      s.add_runtime_dependency(%q<anima>, ["~> 0.2.0"])
      s.add_runtime_dependency(%q<concord>, ["~> 0.1.4"])
      s.add_runtime_dependency(%q<procto>, ["~> 0.0.2"])
    else
      s.add_dependency(%q<abstract_type>, ["~> 0.0.7"])
      s.add_dependency(%q<ast>, ["~> 2.0.0"])
      s.add_dependency(%q<adamantium>, ["~> 0.2.0"])
      s.add_dependency(%q<ice_nine>, ["~> 0.11.0"])
      s.add_dependency(%q<equalizer>, ["~> 0.0.9"])
      s.add_dependency(%q<anima>, ["~> 0.2.0"])
      s.add_dependency(%q<concord>, ["~> 0.1.4"])
      s.add_dependency(%q<procto>, ["~> 0.0.2"])
    end
  else
    s.add_dependency(%q<abstract_type>, ["~> 0.0.7"])
    s.add_dependency(%q<ast>, ["~> 2.0.0"])
    s.add_dependency(%q<adamantium>, ["~> 0.2.0"])
    s.add_dependency(%q<ice_nine>, ["~> 0.11.0"])
    s.add_dependency(%q<equalizer>, ["~> 0.0.9"])
    s.add_dependency(%q<anima>, ["~> 0.2.0"])
    s.add_dependency(%q<concord>, ["~> 0.1.4"])
    s.add_dependency(%q<procto>, ["~> 0.0.2"])
  end
end
