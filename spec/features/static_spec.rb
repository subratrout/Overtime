require 'rails_helper'

describe 'navigate' do
  describe 'homepage' do
    it 'can be reached successfully to root path' do
      visit root_path
      expect(page.status_code).to eq(200)
    end
  end
end