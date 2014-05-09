require 'spec_helper'

describe "Creating to do lists" do
	def create_to_do_list(options={})
		options[:title] ||= "My to_do_list"
		options[:description] ||= "This is my to do list."

		visit "/to_do_lists"
		click_link "New To do list"
		expect(page).to have_content("New to_do_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create To do list"
	end

	it "redirects to the to do list index page on success" do
		create_to_do_list
		expect(page).to have_content("My to_do_list")
	end

	it "displays an error when the todo list has no title" do
		expect(ToDoList.count).to eq(0)

		create_to_do_list title: ""

		expect(page).to have_content("error")
		expect(ToDoList.count).to eq(0)

		visit "/to_do_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the todo list has a title less than 3 characters" do
		expect(ToDoList.count).to eq(0)

		create_to_do_list title: "Hi"

		expect(page).to have_content("error")
		expect(ToDoList.count).to eq(0)

		visit "/to_do_lists"
		expect(page).to_not have_content("This is what I'm doing today.")
	end

	it "displays an error when the todo list has no description" do
		expect(ToDoList.count).to eq(0)

		create_to_do_list  title: "Greocery List", description: ""

		expect(page).to have_content("error")
		expect(ToDoList.count).to eq(0)

		visit "/to_do_lists"
		expect(page).to_not have_content("Grocery List")
	end

	it "displays an error when the todo list has a description less than 5 characters" do
		expect(ToDoList.count).to eq(0)

		create_to_do_list title: "Grocery List", description: "Food"

		expect(page).to have_content("error")
		expect(ToDoList.count).to eq(0)

		visit "/to_do_lists"
		expect(page).to_not have_content("Grocery List")

	end

end
