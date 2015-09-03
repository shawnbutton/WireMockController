require 'spec_helper'

describe WireMockController, :integration do

  it 'has a version number' do
    expect(WireMockController::VERSION).not_to be nil
  end

end
