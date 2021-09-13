require 'rails_helper'

RSpec.describe CookiesBakeJob, type: :job do
  
  scenario 'job performs properly' do 
    cookie = FactoryBot.create(:cookie)
    expect(cookie.is_baked).to eq false
    sleep 5
    expect(cookie.is_baked).to eq true
  end 
end
