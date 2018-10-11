require 'rails_helper'

RSpec.describe Contributor, type: :model do

  describe "Associations" do
    it { should belong_to(:repository) }
  end
end