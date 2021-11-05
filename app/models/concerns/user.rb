class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true,
                    format: { with: EMAIL_REGEX, message: 'format is invalid' }
  validates :first_name, presence: true

  enum status: {
    inactive: 0,
    active: 1
  }

  before_validation do
    if new_record? && password.blank?
      random_password = rand(36**8).to_s(36)
      self.password = hexdigest(random_password)
    end
    self.password = hexdigest(password) if password.present? && new_record?
    self.email = email.presence
  end

  before_create do
    self.status ||= :active
  end

  before_save do
    self.auth_token = hexdigest(password.to_s + email.to_s + Time.now.to_i.to_s)
  end

  def object_json
    as_json(
      except: %i[auth_token password]
    )
  end

  def full_name
    [first_name, last_name].join(' ').strip
  end
end
