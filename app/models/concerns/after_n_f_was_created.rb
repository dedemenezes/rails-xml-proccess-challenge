class AfterNFWasCreated < ActiveModel::Validator
  def validate(record)
    if record.dh_emi.present? && record.dh_emi < Date.new(1970, 01, 01)
      record.errors.add(:dh_emi, "can't be in the past")
    end
  end
end
