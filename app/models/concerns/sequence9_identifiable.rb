require 'uid/sequence'

# This concern sets a unique ID as the primary key id field when the including model is created.
#
module Sequence9Identifiable
  extend ActiveSupport::Concern
  include UID::Sequence

  included do
    before_validation(on: :create) { allocate_id }
    validates :id, numericality: true #, :inclusion => { in: 1_000_000..9_999_999 }
  end

  #---------------------------------------------------------------------------
  private

  def allocate_id
    if self.id.nil?

      # Ensure UID is larger than any possible sequence_7 value
      while(true)
        uid = uid_next(UID.configuration.sequence_9_name).to_i
        self.id = uid and break if uid > 10_000_000
      end
    end
  end
end
