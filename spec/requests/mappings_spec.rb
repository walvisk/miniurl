require 'rails_helper'

RSpec.describe "Mappings", type: :request do
  describe "POST /mappings" do
    context "with valid parameters" do
      it "creates a new mapping" do
        post "/mappings", params: { mapping: { og_url: "https://github.com/walvisk/miniurl" } }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['root_url']).to be_present
        expect(parsed_response['key']).to be_present
      end
    end

    context "with invalid parameters" do
      it "returns bad request" do
        post "/mappings", params: { mapping: { og_url: "just casual text" } }
        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq("Validation failed: URL is invalid")
      end
    end
  end
end
