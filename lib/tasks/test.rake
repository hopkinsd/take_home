require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/**/*spec.rb']
end
