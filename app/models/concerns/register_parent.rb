module RegisterParent
  extend ActiveSupport::Concern
  included do
    after_save :register_parent
  end

  def register_parent
    presenter = ContactPresenter.new(contact)
    Publisher.publish(presenter)
  end
end
