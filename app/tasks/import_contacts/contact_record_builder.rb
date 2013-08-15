class ImportContacts
  class ContactRecordBuilder
    def self.build(attributes)
      new(attributes).build
    end

    def initialize(attributes = {})
      @attributes = attributes
      @contact_record = ContactRecord.new(contact_attributes)
    end

    def attributes
      @attributes || {}
    end

    def contact_attributes
      {
        description: attributes['description'],
        keywords: attributes.fetch('keywords', '').to_s.split(","),
        contact_type: ContactType.find_by_title(attributes['clustergroup'])
      }
    end

    def build
      @contact_record.websites = website_records
      @contact_record.email_addresses = email_address_records
      @contact_record.post_addresses = post_address_records
      @contact_record.numbers = number_records

      @contact_record
    end

    private

    def website_records
      WebsiteBuilder.build(@contact_record, attributes).select(&:valid?)
    end

    def email_address_records
      EmailAddressBuilder.build(@contact_record, attributes).select(&:valid?)
    end

    def post_address_records
      PostAddressBuilder.build(@contact_record, attributes).select(&:valid?)
    end

    def number_records
      NumberBuilder.build(@contact_record, attributes).select(&:valid?)
    end
  end
end
