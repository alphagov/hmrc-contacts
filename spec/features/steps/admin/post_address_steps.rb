module Admin
  module PostAddressSteps
    include ::CommonSteps

    def post_address_exists(contact, post_address)
      ensure_on admin_contact_post_addresses_path(contact)

      has_selector?(post_addresses_table_selector) &&
        within(post_addresses_table_selector) do
          has_content? post_address.title
        end
    end

    def delete_post_address(post_address)
      ensure_on edit_admin_contact_post_address_path(
        post_address.contact,
        post_address,
      )

      click_link "Delete"
    end

    def update_post_address(post_address, new_details = {})
      ensure_on edit_admin_contact_post_address_path(
        post_address.contact,
        post_address,
      )

      new_details.each do |field, value|
        fill_in "post_address_#{field}", with: value
      end

      yield if block_given?

      find("#post-address-submit").click
    end

    def create_post_address(contact, details = {})
      ensure_on new_admin_contact_post_address_path(contact)

      details.each do |field, value|
        fill_in "post_address_#{field}", with: value
      end

      select "United Kingdom", from: "post_address_world_location_slug"

      yield if block_given?

      find("#post-address-submit").click
    end

    def post_address_updated(post_address, details = {})
      ensure_on edit_admin_contact_post_address_path(
        post_address.contact,
        post_address,
      )

      details.all? do |field, value|
        has_field?("post_address_#{field}", with: value)
      end
    end

    def post_addresses_table_selector
      "table.post-addresses-table"
    end
  end
end
