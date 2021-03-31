# Nginx boshrelease

## Notes

Downloading sources from here:
```bash
pushd src
wget http://www.openssl.org/source/openssl-1.1.1g.tar.gz
wget http://zlib.net/zlib-1.2.11.tar.gz
wget https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz
wget https://github.com/nginx/nginx/archive/refs/tags/release-1.19.8.tar.gz -O nginx-1.19.8.tar.gz
popd
```

Initialising spec testing:
```bash
gem install bundler
bundle config set path 'vendor/bundle'
bundle init
cat<<EOF >> Gemfile
group :development do
  gem 'guard-rspec', require: false
  gem 'bosh-template'
end
EOF
bundle install
bundle exec rspec --init
bundle exec guard init rspec
```

Add this watchers for template changes before the last `end` of the Guardfile:
```ruby
  watch(%r{^jobs/.+/spec$})  { rspec.spec_dir }
  watch(%r{^jobs/.+/templates/(.+)$})  { rspec.spec_dir }
```

Testing:
```bash
bundle exec guard
# or
bundle exec rspec
```


## Writing tests

General guides on [testing templates](https://bosh.io/docs/job-templates/) and for [use of properties in them](https://bosh.io/docs/jobs/#properties)