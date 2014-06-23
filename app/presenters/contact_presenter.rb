class ContactPresenter
  include GovspeakHelper

  attr_reader :contact

  def initialize(contact)
    @contact = contact
  end

  def present
    {
      base_path: contact.link,
      title: contact.title,
      description: contact.description,
      format: "contact",
      publishing_app: "contacts",
      rendering_app: "contacts-frontend",
      update_type: "major",
      public_updated_at: contact.updated_at,
      routes: [
        { path: contact.link, type: "exact", rendering_app: "contacts-frontend" }
      ],
      details: contact_details.merge(language: "en"),
      need_ids: [],
    }
  end

  private

  def contact_details
    {
      slug: contact.slug,
      title: contact.title,
      description: contact.description,
      organisation: contact.organisation.as_json,
      quick_links: contact.quick_links.map {|q| {title: q.title, url: q.url} },
      query_response_time: (contact.query_response_time or false),

      contact_groups: ContactGroupsPresenter.new(contact.contact_groups).present,

      contact_form_links: contact.contact_form_links.map(&:as_json),
      more_info_contact_form: govspeak(contact.more_info_contact_form),

      email_addresses: EmailAddressesPresenter.new(contact.email_addresses).present,
      more_info_email_address: contact.more_info_email_address,

      phone_numbers: PhoneNumbersPresenter.new(contact.phone_numbers).present,

      post_addresses: PostAddressesPresenter.new(contact.post_addresses).present,
      more_info_post_address: govspeak(contact.more_info_post_address),
    }
  end
end