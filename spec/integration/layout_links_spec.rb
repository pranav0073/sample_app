require 'spec_helper'

describe "Layout Links" do
	it "should have home page at '/'" do
		get '/'
		response.should render_template('pages/home')
	end

	it "should have a contact at '/contact'" do
		get '/contact'
		response.should render_template('pages/contact')
	end
	it "should have an About page at '/about'" do
    get '/about'
    response.should render_template('pages/about')
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should render_template('pages/help')
  end
end
