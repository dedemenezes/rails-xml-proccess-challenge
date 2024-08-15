class DHCannotBeInTheFuture < ActiveModel::Validator
  def validate(record)
    if record.dh_emi.present? && record.dh_emi > Date.today.end_of_day
      record.errors.add(:dh_emi, "can't be in the future")
    end
  end
end
