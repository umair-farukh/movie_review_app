class AssociateUserToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :user, index: true
  end
end
