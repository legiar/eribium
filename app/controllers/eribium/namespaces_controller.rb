module Eribium
  
  class NamespacesController < WorkspaceController
    defaults  route_prefix: 'eribium',
              resource_class: Namespace,
              collection_name: 'namespaces',
              instance_name: 'namespace'
  end

end