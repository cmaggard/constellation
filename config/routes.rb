ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  map.connect '', :controller => "queue", :action => "index"

  map.connect ':controller/service.wsdl', :action => 'wsdl'
  
  #map.connec
  #map.connect 'tickets/new', :controller => 'tickets', :action => 'new'
  #map.connect 'tickets/:id', :controller => 'tickets', :action => 'view'
  
  map.connect ':controller/:action/:id'
end
