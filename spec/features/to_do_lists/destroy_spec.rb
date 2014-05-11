require 'spec_helper'

describe "Deleting to do lists" do
let!(:to_do_list) { ToDoList.create(title: "Groceries", description: "Grocery List.") }

it "Is successful when clicking destroy link" do
	visit "/to_do_lists"

	within "#to_do_list_#{to_do_list.id}" do
		click_link "Destroy"
	end
	expect(page).to_not have_content(to_do_list.title)
	expect(ToDoList.count).to eq(0)
end
end