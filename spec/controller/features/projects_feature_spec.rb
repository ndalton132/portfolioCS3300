require "rails_helper"

RSpec.feature "Projects", type: :feature do
    context "Update project" do
      let(:project) { Project.create(title: "Test title", description: "Test content") }
      before(:each) do
        user = FactoryBot.create(:user)
        login_as(user)
        visit new_project_path
      end
 
 
      scenario "should be successful" do
        
        within("form") do
          fill_in "Title", with: "stuff"
          fill_in "Description", with: "New description content"
        end
    
        click_button "Update Project"
        expect(page).to have_content("Project was successfully updated.")
      end
 
 
      scenario "should fail" do
       
        within("form") do
          fill_in "Description", with: ""
        end
        click_button "Create Project"
        expect(page).to have_content("Description can't be blank")
      end

      scenario "should fail" do
        within("form") do
          fill_in "Title", with: ""
        end
        click_button "Update Project"
        expect(page).to have_content("Title can't be blank")
      end
    end

    context "Login" do
      scenario "should sign up" do
        visit root_path
        click_link 'Sign up'
        within("form") do
          fill_in "Email", with: "testing@test.com"
          fill_in "Password", with: "123456"
          fill_in "Password confirmation", with: "123456"
          click_button "Sign up"
        end
        expect(page).to have_content("Welcome! You have signed up successfully.")
      end
  
  
      scenario "should log in" do
        user = FactoryBot.create(:user)
        login_as(user)
        visit root_path
        expect(page).to have_content("Logged in")
      end
    end
  
end

RSpec.feature "Projects", type: :feature do


    context "Create project" do
      let(:project) { Project.create(title: "Test title", description: "Test content") }
      before(:each) do
        user = FactoryBot.create(:user)
        login_as(user)
        visit new_project_path
      end
 
 
      scenario "should be successful" do
        within("form") do
          fill_in "Title", with: "This is the title"
          fill_in "Description", with: "New description content"
        end
        click_button "Create Project"
        expect(page).to have_content("Project was successfully created.")
      end
 
 
      scenario "should fail" do
        within("form") do
          fill_in "Description", with: ""
        end
        click_button "Create Project"
        expect(page).to have_content("Description can't be blank")
      end

      scenario "should fail" do
        within("form") do
          fill_in "Title", with: ""
        end
        click_button "Create Project"
        expect(page).to have_content("Title can't be blank")
      end
    end
end

RSpec.feature "HomePages", type: :feature do
    scenario "The visitor should see projects" do
      visit root_path
      expect(page).to have_text("Projects")
    end
  end
  
