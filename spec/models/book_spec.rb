require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:release_date) }
end
