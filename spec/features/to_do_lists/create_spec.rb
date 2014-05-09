require 'spec_helper'

describe "Creating to do lists" do
	it "redirects to the to do list index page on success" do
		visit "/to_do_lists"
		click_link "New To do list"
		expect(page).to have_content("New to_do_list")

		fill_in "Title", with: "My to_do_list"
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create To do list"

		expect(page).to have_content("My to_do_list")
	end


	it "displays an error when the todo list has no title" do
		expect(ToDoList.count).to eq(0)

		visit "/to_do_lists"
		click_link "New To do list"
		expect(page).to have_content("New to_do_list")

		fill_in "Title", with: ""
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create To do list"

		expect(page).to have_content("error")
		expect(ToDoList.count).to eq(0)

		visit "/to_do_lists"
		expect(page).to_not have_content("This is what I'm doing today.")

	end

	it "displays an error when the todo list has a title less than 3 characters" do
		expect(ToDoList.count).to eq(0)

		visit "/to_do_lists"
		click_link "New To do list"
		expect(page).to have_content("New to_do_list")

		fill_in "Title", with: "Hi"
		fill_in "Description", with: "This is what I'm doing today."
		click_button "Create To do list"

		expect(page).to have_content("error")
		expect(ToDoList.count).to eq(0)

		visit "/to_do_lists"
		expect(page).to_not have_content("This is what I'm doing today.")

	end

end
