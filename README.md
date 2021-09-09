# Miau

Miau (MIcro AUthorization) is a simple authorization library for Rails
inspired by Banken.
Miau provides a set of helpers which restricts what resources
a given user is allowed to access.

## Usage

~~~ ruby
# app/models/application_controller.rb
class ApplicationController
...
  include Miau
...

# def miau_user
#   current_user
# end

# verify_authorized

# rescue Miau::NotDefinedError
#  # do some logging or whatever

# rescue Miau::NotAuthorizedError
#  # do some logging or whatever

# rescue Miau::AuthorizationNotPerformedError
#  # do some logging or whatever

...
end
~~~

~~~ ruby
# app/controllers/posts_controller.rb
  class PostsController < ApplicationController
    ...
    def show
      ...
      authorize!
      ...
    end
    ...
  end
~~~

~~~ ruby
# app/viewa/posts/show.rb
  <% if authorized? %>
    ...
  <% else %>
    ...
  <% end %>
~~~

## Installation

``` ruby
# Gemfile
gem "miau"
```
and run "bundle install".
