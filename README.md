To install this calendar app (assuming you don't have Ruby 2.7.1 and Rails 6.0 installed), follow the appropriate set of instructions (Linux or MacOS Catalina):

Ubuntu 20.04

```
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev


Install ruby, rbenv, nodejs, yarn, and rails:
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.7.1
rbenv global 2.7.1
ruby -v #2.7.1

gem install bundler
rbenv rehash

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update
sudo apt-get install -y nodejs yarn

gem install rails -v 6.0.2.2
rbenv rehash
rails -v # Rails 6.0.2.2


git clone git@github.com:bleung9/calendar.git

cd into the directory, then:
bundle install

rake db:create
rake db:migrate

To run the server:
rails s

To open up a console:
rails c

To run all tests:
rspec

To run a specific test:
rspec path/to/test.rb

```


