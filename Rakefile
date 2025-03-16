require 'rake/testtask'

Rake::TestTask.new do |t|
  # Add the current directory to the load path in case your files are here
  t.libs << '.'
  # Adjust the file pattern to match your test file(s)
  t.test_files = FileList['06/test_*.rb']
  t.verbose = true
  # Pass the --no-plugins CLI argument to disable plugin loading
  t.options = '--no-plugins'
end

desc 'Default: run tests'
task default: :test
