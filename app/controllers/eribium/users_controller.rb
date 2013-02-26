module Eribium
  class UsersController < WorkspaceController
    defaults  route_prefix: 'eribium',
              resource_class: User,
              collection_name: 'users',
              instance_name: 'user'
    #filter_access_to :all, model: Eribium::User

  end
end