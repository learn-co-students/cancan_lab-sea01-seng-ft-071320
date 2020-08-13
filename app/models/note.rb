class Note < ApplicationRecord
  belongs_to :user
  has_many :viewers
  has_many :readers, through: :viewers, source: :user

  def visible_to
    readers.map(&:name).join(',') + (!!self.user ? user.name : '')
  end

  def visible_to=(comma_string)
    comma_string.split(',').map(&:strip).each do |reader_name|
      reader = User.find_by(name: reader_name)
      readers << reader unless !reader
    end
  end
end
