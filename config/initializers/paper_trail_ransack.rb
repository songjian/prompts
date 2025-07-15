module PaperTrail
  class Version < ::ActiveRecord::Base
    def self.ransackable_attributes(auth_object = nil)
      [
        "id",
        "item_type",
        "item_id",
        "event",
        "whodunnit",
        "object",
        "created_at"
      ]
    end
  end
end