Miau
====
[![Gem Version](https://badge.fury.io/rb/miau.png)](http://badge.fury.io/rb/miau)

Miau (MIcro AUthorization) is a simple authorization library for Rails
inspired by Pundit and Banken.
Miau provides a set of helpers which restricts what resources
a given user is allowed to access.

Installation
------------

~~~ ruby
# Gemfile
gem "miau"
~~~

and run "bundle install".

Usage (as intended)
-------------------

~~~ ruby
# app/models/application_controller.rb
class ApplicationController < ActionController::Base
...
  include Miau
...
end
~~~

~~~ ruby
# app/controllers/posts_controller.rb            # app/views/posts/update.rb
  class PostsController < ApplicationController    <% if authorized? %>
    ...                                              ...
    def update                                     <% else %>
      ...                                            ...
      authorize!                                   <% end %>
      ...
    end
    ...
  end
~~~

~~~ ruby
# app/policies/application_policy.rb             # app/policies/posts_policy.rb
  class ApplicationPolicy                          class PostsPolicy < ApplicationPolicy
    attr_reader :user, :resource                     ...
                                                     def update
    def initalize(user, resource)                      user.admin? && resource.published?
      @user = user                                   end
      @resource = resource                           ...
    end                                            end
    ...
    def update
      false
    end
    ...
  end
~~~

"authorize!" will raise an exception (which can be handled by "rescue")
in case a policy returns "false" or isn't available.

"authorize?" will return the value of the policy.


Internals
---------

At the bottom line based on a "policy" and an "action"
a corresponding policy method is called.

The policy method has access to the "user" and the "resource".

"user" is set by the default method "miau_user" as:

~~~
# app/models/application_controller.rb
  ...
  def miau_user
    current_user
  end
  ...
~~~

and the method may be overwritten.

The default value for "policy" is inferred from the controller,
i.e. "authorization!" called from "PostsController" will
set the "policy" to "PostsPolicy".

The default value for "action" is set by "params[:action]".

"resource" may be set as a parameter.

A full blown sample :

~~~
  authorize! article, policy: :Comments, action: :extract
~~~

Usage (more elaborated)
-----------------------

~~~ ruby
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
~~~

Policies remain as before.
Rescue's may be inserted previously in the exception chain.

"verify_authorized" checks that an "authorize!" has been called.


PORO
----
Miau is a very small library, it just provides a few helpers.
All of the policy classes are just plain Ruby classes,
allowing DRY, encapsulation, aliasing and inheritance.

There is no magic behind the scenes.
Just the embedding in Rails required some specific knowledge.
