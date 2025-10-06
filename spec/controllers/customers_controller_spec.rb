require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let!(:customer1) { Customer.create!(first_name: "Aldien", last_name: "Asc", phone_number: "1111111111", date_of_birth: 34.years.ago) }
  let!(:customer2) { Customer.create!(first_name: "Zion", last_name: "Desc", phone_number: "2222222222", date_of_birth: 10.years.ago) }

  let(:valid_attributes) do
    {
      first_name: "John",
      last_name: "Doe",
      phone_number: "3333333333",
      date_of_birth: 30.years.ago
    }
  end

  let(:invalid_attributes) do
    {
      first_name: "",
      last_name: "",
      phone_number: "",
      date_of_birth: ""
    }
  end

  describe "GET #index" do
    it "assigns value and renders index page" do
      get :index
      expect(assigns(:customers)).to be_present
      expect(response).to render_template(:index)
    end

    it "assigns @customers with pagination" do
      get :index, params: { page: 1 }
      expect(assigns(:customers)).to include(customer1, customer2)
      expect(assigns(:customers).current_page).to eq(1)
    end

    it "sorts by last_name by default" do
      get :index
      expect(assigns(:customers).first.last_name).to eq("Asc")
    end

    it "sorts dynamically when params are passed" do
      get :index, params: { sort: "first_name", direction: "desc" }
      expect(assigns(:customers).first.first_name).to eq("Zion")
    end
  end

  describe "GET #show" do
    it "assigns value and renders show page" do
      get :show, params: { id: customer1.id }

      expect(assigns(:customer)).to eq(customer1)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "renders new page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "assigns value and renders edit page" do
      get :edit, params: { id: customer1.id }

      expect(assigns(:customer)).to eq(customer1)
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new customer" do
        expect {
          post :create, params: { customer: valid_attributes }
        }.to change(Customer, :count).by(1)
      end

      it "redirects to customers index with notice" do
        post :create, params: { customer: valid_attributes }
        expect(response).to redirect_to(customers_path)
        expect(flash[:notice]).to eq("Customer was successfully created.")
      end
    end

    context "with invalid params" do
      it "does not create a customer" do
        expect {
          post :create, params: { customer: invalid_attributes }
        }.to_not change(Customer, :count)
      end

      it "renders the new template with unprocessable_entity status" do
        post :create, params: { customer: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) { { first_name: "Updated" } }

      it "updates the customer" do
        patch :update, params: { id: customer1.id, customer: new_attributes }
        customer1.reload
        expect(customer1.first_name).to eq("Updated")
      end

      it "redirects to customers index with notice" do
        patch :update, params: { id: customer1.id, customer: new_attributes }
        expect(response).to redirect_to(customers_path)
        expect(flash[:notice]).to eq("Customer was successfully updated.")
      end
    end

    context "with invalid params" do
      it "does not update and renders edit template" do
        patch :update, params: { id: customer1.id, customer: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the customer" do
      expect {
        delete :destroy, params: { id: customer1.id }
      }.to change(Customer, :count).by(-1)
    end

    it "redirects to customers index with notice" do
      delete :destroy, params: { id: customer2.id }
      expect(response).to redirect_to(customers_path)
      expect(flash[:notice]).to eq("Customer was successfully deleted.")
    end
  end
end
