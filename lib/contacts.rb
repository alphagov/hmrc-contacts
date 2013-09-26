module Contacts
  autoload :Interactor, 'contacts/interactor'

  mattr_accessor :mainstream_search_client
  mattr_accessor :contacts_search_client
  mattr_accessor :worldwide_api

  module_function
end
