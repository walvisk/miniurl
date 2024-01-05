require 'rails_helper'

RSpec.describe "home/show", type: :view do
  it "display correct information" do
    mapping = MappingCreationJob.perform_now("https://github.com/rspec/rspec-rails")

    assign(:short_url, "#{root_url}#{mapping.key}")
    assign(:hit_count, mapping.hit_count)
    assign(:og_url, mapping.og_url)

    render
    expect(rendered).to have_field("short_url", with: "#{root_url}#{mapping.key}", type: "text", class: "form-control")
    expect(rendered).to have_field("og_url", with: mapping.og_url,  visible: false)
  end
end
