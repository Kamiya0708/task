class Task < ApplicationRecord
    validates :name, presence: true, length: {maximum: 30}
    belongs_to :user
    has_one_attached :image

    def self.ransackable_attributes(auth_object = nil)
        %w[name created_at]
    end

    def self.ransackable_associations(auth_object = nil)
        []
    end
end
