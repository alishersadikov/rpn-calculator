guard :minitest, test_folders: ["."] do
  # Re-test test files when they're modified.
  watch(%r{\A.+_test\.rb\z}) { |m| "./#{m[1]}" }
  # Run the test file of the implementation (non-test) file that was modified.
  watch(%r{\A(.+)(?<!_test)\.rb\z}) { |m| "./#{m[1]}_test.rb" }
end
