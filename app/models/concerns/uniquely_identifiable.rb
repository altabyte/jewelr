require 'uid/sequence'

# This concern sets a unique ID as the primary key id field when the including model is created.
#
module UniquelyIdentifiable
  extend ActiveSupport::Concern
  include UID::Sequence

  included do
    before_validation(on: :create) { allocate_id }
    validates :id, :numericality => true, :inclusion => { in: 1_000_000..9_999_999 }
  end

  #---------------------------------------------------------------------------
  private

  def allocate_id
    self.id = next_uid if self.id.nil?
  end
end
