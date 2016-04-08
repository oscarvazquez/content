# This file was generated by the `rails generate rspec:install` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end

def set_job
  @user_params = set_user
  @biz_params = set_business
  @user = create_user(@user_params)
  @biz = create_business(@biz_params)
  @params = Hash.new
  @params['length'] = 500
  @params['price'] = 100
  @params['timeline'] = '5m'
  @params['user'] = @user
  @params['business'] = @biz
  @params
end

def set_review
  @user_params = set_user
  @biz_params = set_business
  @job_params = set_job
  @user = create_user(@user_params)
  @biz = create_business(@biz_params)
  @job = create_job(@job_params)
  @params = Hash.new
  @params['review'] = 'This was amazing'
  @params['rating'] = 5
  @params['writer'] = @biz
  @params['receiver'] = @user
  @params['job'] = @job
  @params
end

def set_user
  @params = Hash.new
  @params['first_name'] = "marcos"
  @params['last_name'] = "vazquez"
  @params['email'] = "marc@marcos.com"
  @params['password'] = "redfred"
  @params['password_confirmation'] = "redfred"
  @params['street_address'] = "1807 pacific place"
  @params['city'] = "san juan"
  @params['state'] = "puerto rico"
  @params['country'] = "PR"
  @params['zip_code'] = "00911"
  @params
end

def set_business
  @biz_params = Hash.new
  @biz_params['name'] = 'oscar.tech'
  @biz_params['zip_code'] = '95014'
  @biz_params['city'] = 'Cupertino'
  @biz_params['state'] = "CA"
  @biz_params['street_address'] = "1135 south stelling rd"
  @biz_params['country'] = "US"
  @biz_params['email'] = 'oscar@oscar.com'
  @biz_params['password'] = 'redfred'
  @biz_params
end

def set_pitch 
  @pitch_params = Hash.new
  @pitch_params['pitch'] = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
  @pitch_params['title'] = "this is the title and its awesome"
  @pitch_params['length'] = 500
  @pitch_params['price'] = 100
  @pitch_params['timeline'] = '5m'
  @user_params = set_user
  @biz_params = set_business
  @user = create_user(@user_params)
  @biz = create_business(@biz_params)
  @pitch_params['user'] = @user
  @pitch_params['business'] = @biz
  @pitch_params
end

def create_pitch(pitch_params)
  pitch = Pitch.create(pitch_params)
end

def create_review(review_params)
  review = Review.create(review_params)
end

def create_business(biz_params)
  business = Business.create(biz_params)
end

def create_user(params)
  user = User.create(params)
end

def create_job(job_params)
  job = Job.create(job_params)
end
