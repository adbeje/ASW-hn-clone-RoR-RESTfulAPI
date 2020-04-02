class Contribucion < ApplicationRecord
  has_one :user
  has_many :comments
  
  validate :verificar
  
  def verificar
    if title.blank?
        errors.add(:title, "Title can't be blank")
    else
      if !url.blank? && url =~ URI::regexp
        if text.blank?
        else 
          errors.add(:url, "Can't have both urls and text, so you need to pick one")
        end
      elsif !url.blank?
          errors.add(:url, "Invalid Url")
      else 
      end
    end
  end
  
end
