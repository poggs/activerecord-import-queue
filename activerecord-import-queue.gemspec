Gem::Specification.new do |s|
  s.name = 'activerecord-import-queue'
  s.version = '0.0.1'
  s.licenses = ['GPLv2']
  s.summary = "An ActiveRecord object queue for activerecord-import"
  s.description = "ActiveRecordImportQueue implements a simple queue which calls the 'import' method of the base object when there are more than a configurable number of objects pending"
  s.authors = ["Peter Hicks"]
  s.email = 'peter.hicks@poggs.co.uk'
  s.files = ["lib/activerecord-import-queue.rb"]
  s.homepage = 'http://opensource.poggs.com/ruby/gems/activerecord-import-queue'
end
