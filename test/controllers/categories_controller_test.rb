require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

	def setup
		@category = Category.new(name: "sports")
		@category.save
	end

	test "check route index" do
		get categories_path

		assert_response :success
	end

	test "check route new" do
		get new_category_path

		assert_response :success
	end

	test "check route show" do
		get category_path(@category)

		assert_response :success
	end

end