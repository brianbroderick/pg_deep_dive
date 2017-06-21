source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
gem 'pg'
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem "pry"
  gem "pry-nav"
  gem "pry-remote"
end

group :development do  
  gem 'listen', '~> 3.0.5'
end