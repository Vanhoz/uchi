require 'rails_helper'

RSpec.describe Repository, type: :model do

  subject {
    described_class.new(link: 'https://github.com/rails/rails')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a link" do
    subject.link = ''
    expect(subject).to_not be_valid
  end

  it "is not valid with bad link" do
    subject.link = 'https://github.com/rails/sliar'
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should have_many(:contributors) }
  end

  describe ".create_link" do
    it "create an api link when string is not empty" do
      link = subject.link
      subject.create_link('https://github.com/prawnpdf/prawn')
      expect(subject.link).to_not eq(link)

      link = subject.link
      subject.create_link('')
      expect(subject.link).to eq(link)
    end
  end

  describe "triggers create_contributors after create" do
    it { is_expected.to callback(:create_contributors).after(:create) }
  end

end