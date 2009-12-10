class ActionController::Routing::RouteSet
  def load_routes_with_muck_oauth!
    muck_oauth_routes = File.join(File.dirname(__FILE__), *%w[.. .. config muck_oauth_routes.rb])
    add_configuration_file(muck_oauth_routes) unless configuration_files.include? muck_oauth_routes
    load_routes_without_muck_oauth!
  end
  alias_method_chain :load_routes!, :muck_oauth
end