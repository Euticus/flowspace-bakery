require 'rails_helper'

RSpec.describe CookiesBakeJob, type: :job do
  
  scenario 'job performs properly' do 
    cookie = FactoryBot.create(:cookie)
    expect(cookie.is_baked).to eq nil
    cookie.bake_job
    expect(cookie.is_baked).to eq true
  end 
end
