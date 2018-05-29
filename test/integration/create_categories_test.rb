require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

	test "get new categry form and create category" do
		get new_category_path
		assert_template 'categories/new'
		assert_difference 'Category.count', 1 do 
			post categories_path, params: {category: {name: "sports"}} 
			follow_redirect!
		end

		assert_template 'categories/index'
		assert_match "sports", response.body

	end

	test "invalid category submission should result in failure" do
		get new_category_path
		assert_template 'categories/new'
		assert_no_difference 'Category.count' do 
			post categories_path, params: {category: {name: " "}} 

			assert_template 'categories/new'
			assert_select 'h2.panel-title' # look for specific tags from the expected page to ensure that page is rendered.
			assert_select 'div.panel-body' # look for specific tags from the expected page to ensure that page is rendered.
		end
	end

end