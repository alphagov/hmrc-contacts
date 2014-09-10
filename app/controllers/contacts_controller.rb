class ContactsController < ApplicationController
  helper_method :organisation, :search, :contact_groups

  def index
    @contacts = search.results.includes(:contact_groups).for_listing
  end

  private

  def search_params
    filter = { organisation_id: organisation.id }
    filter.merge(params.fetch(:search, {}))
  end

  def organisation
    @organisation ||= Organisation.find_by_slug(params[:organisation_slug])
  end

  def search
    @search ||= ContactsSearch.new search_params
  end

  def contact_groups
    @contact_groups ||= organisation.contact_groups.by_title
  end
end
