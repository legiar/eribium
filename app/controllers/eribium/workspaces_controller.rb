module Eribium

  class WorkspacesController < WorkspaceController
    defaults  route_prefix: 'eribium',
              resource_class: Workspace,
              collection_name: 'workspaces',
              instance_name: 'workspace'
  end

end