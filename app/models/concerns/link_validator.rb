class LinkValidator < ActiveModel::Validator
  def validate(record)
    if record.link != ""
      begin
        RestClient.get record.link
      rescue => e
        e.response
      end
      if e
        record.errors.add(:link, "you are trying to use is incorrect, try again please.")
      end
    end
  end
end