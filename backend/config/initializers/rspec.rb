if Rails.env.test?
  RSpec.configure do |config|
    config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    end

    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = true
    end

    config.shared_context_metadata_behavior = :apply_to_host_groups

    config.filter_run_when_matching :focus

    config.example_status_persistence_file_path = "spec/examples.txt"

    config.disable_monkey_patching!

    if config.files_to_run.one?
      config.default_formatter = "doc"
    end

    config.profile_examples = 10

    config.order = :random

    Kernel.srand config.seed

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.around(:each) do |example|
      DatabaseCleaner.cleaning do
        example.run
      end
    end
  end
end 