module Eribium
  class RolesController < WorkspaceController
    defaults  route_prefix: 'eribium',
              resource_class: Role,
              collection_name: 'roles',
              instance_name: 'role'
    #filter_access_to :all, model: Eribium::Role
  end
end