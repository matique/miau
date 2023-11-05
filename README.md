Miau
====
[![Gem Version](https://badge.fury.io/rb/miau.png)](http://badge.fury.io/rb/miau)

Miau (MIcro AUthorization) is a simple authorization gem for Rails
inspired by Pundit and Banken.
Miau provides a set of helpers which restricts what resources
a given user is allowed to access.

## Installation

As usual:
```ruby
# Gemfile
gem "miau"
```
and run "bundle install".

## Usage (as intended)

```ruby
# app/models/application_controller.rb
class ApplicationController < ActionController::Base
...
  include Miau
...
end
```

```ruby
# app/controllers/posts_controller.rb            # app/views/posts/update.erb
  class PostsController < ApplicationController    <% if authorized? %>
    ...                                              ...
    def update                                     <% else %>
      ...                                            ...
      authorize!                                   <% end %>
      ...
    end
    ...
  end
```

```ruby
# app/policies/application_policy.rb             # app/policies/posts_policy.rb
  class ApplicationPolicy                          class PostsPolicy < ApplicationPolicy
    attr_reader :user, :resource                     ...
                                                     def update
    def initalize(user, resource)                      user.admin? && resource.published?
      @user = user                                   end
      @resource = resource                           ...
    end                                            end
  end
```

"authorize!" will raise an exception (which can be handled by "rescue")
in case a policy returns "false" or isn't available.

"authorized?" will return the value of the policy.

"app/policies/application_policy.rb" is included in the gem.

Internals
---------

At the bottom line based on a "policy" and an "action"
a corresponding policy method is called.

The policy method has access to the "user" and the "resource".

"user" is set by the default method "miau_user" (can be overwritten) as:

```ruby
# app/models/application_controller.rb
  ...
  def miau_user
    current_user
  end
  ...
```

The default value for "policy" is inferred from "params[:controller]",
i.e. "authorize!" called from "PostsController" will
set the "policy" to "PostsPolicy".

The default value for "action" is set by "params[:action]".

"resource" may be set as a parameter.

A full blown sample :

```ruby
  authorize! article, policy: :posts, action: :show
```

Usage (more elaborated)
-----------------------

```ruby
# app/models/application_controller.rb
class ApplicationController
...
  include Miau
...

  after_action { verify_authorized }

  def miau_user
    current_user
  end

  rescue Miau::NotDefinedError
    # do some logging or whatever

  rescue Miau::NotAuthorizedError
    # do some logging or whatever

  rescue Miau::AuthorizationNotPerformedError
    # do some logging or whatever

...
end
```

Policies remain as before.
Rescue's may be inserted previously in the exception chain.

"verify_authorized" checks that an "authorize!" has been called.

DRYing
------

```ruby
# app/policies/posts_policy.rb          -->      # app/policies/posts_policy.rb
  class PostsPolicy < ApplicationPolicy            class PostsPolicy < ApplicationPolicy
    def new                                          miau %i[create edit], :new
      user.admin? && Time.now.monday?
    end                                              def new
                                                       user.admin? && Time.now.monday?
    def create                                       end
      user.admin? && Time.now.monday?                ...
    end                                            end

    def edit
      user.admin? && Time.now.monday?
    end
    ...
  end
```

PORO
----
Miau is a small gem, it just provides a few helpers.
All of the policy classes are just plain Ruby classes,
allowing DRY, encapsulation, aliasing and inheritance.

There is no magic behind the scenes.
Just the embedding in Rails required some specific knowledge.

## Miscellaneous

Copyright (c) 2021-2023 Dittmar Krall (www.matiq.com),
released under the MIT license:

* https://opensource.org/licenses/MIT
