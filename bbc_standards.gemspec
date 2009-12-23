# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bbc_standards}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Patrick Sinclair"]
  s.date = %q{2009-12-23}
  s.email = %q{metade@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["README", "spec", "lib/bbc_standards", "lib/bbc_standards/rspec.rb", "lib/bbc_standards/validator.rb", "lib/bbc_standards.rb"]
  s.homepage = %q{http://github.com/metade/bbc_standards}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{What this thing does}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
