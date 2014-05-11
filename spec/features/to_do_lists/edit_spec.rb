require 'spec_helper'

describe "Editing to do lists" do
let!(:to_do_list) { ToDoList.create(title: "Groceries", description: "Grocery List.") }

	def update_to_do_list(options={})
		options[:title] ||= "My to_do_list"
		options[:description] ||= "This is my to do list."

		to_do_list = options[:to_do_list]

		visit "/to_do_lists"
		within "#to_do_list_#{to_do_list.id}" do
		click_link "Edit"
	end		

	fill_in "Title", with: options[:title]
	fill_in "Description", with: options[:description]
	click_button "Update To do list"
	end

	it "updates to do list successfully with correct information" do
		
		update_to_do_list to_do_list: to_do_list, 
							title: "New Title", 
							description: "New description"

	to_do_list.reload

	expect(page).to have_content("To do list was successfully updated.")
	expect(to_do_list.title).to eq("New Title")
	expect(to_do_list.description).to eq("New description") 
	end		
end