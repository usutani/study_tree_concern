module Tree
  extend ActiveSupport::Concern

  included do |base|
    belongs_to :parent, class_name: base.to_s, touch: true, optional: true, inverse_of: :children
    has_many :children, class_name: base.to_s, foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent

    scope :roots, -> { where(parent: nil) }
    scope :children_of, ->(parent) { where(parent: parent) }
  end

  def adopt(children)
    transaction do
      Array(children).each do |child|
        child.update! parent: self
      end
    end
  end
end
