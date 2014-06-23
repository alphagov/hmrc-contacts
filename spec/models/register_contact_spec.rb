require "spec_helper"

describe Contacts::RegisterContact do
  let!(:presenter) { double("ContactPresenter") }
  let!(:presented_contact) { { base_path: '/base-path', title: 'title' } }

  it "sends data to the content-store on register" do
    presenter.should_receive(:present).and_return(presented_contact)
    Contacts.content_store_api.should_receive(:put_content_item).with('/base-path', presented_contact)

    Contacts::RegisterContact.register(presenter)
  end
end