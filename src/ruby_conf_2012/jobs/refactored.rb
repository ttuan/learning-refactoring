class JobSite
  attr_reader :contact

  def initialize(location, contact)
    @location = location
    @contact = contact || NullContact.new
  end

  def contact_name
    contact.name
  end

  def contact_phone
    contact.phone
  end

  def email_contact(email_body)
    contact.deliver_personal_email(email_body)
  end
end

class Contact < OpenStruct
  def deliver_personal_email(email)
    email.deliver(name)
  end
end

class NullContact
  def name
    'no name'
  end

  def phone
    'no phone'
  end

  def deliver_personal_email(email)
  end
end
