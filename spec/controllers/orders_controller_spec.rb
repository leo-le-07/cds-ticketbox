require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  it "routes get new" do
    expect(get: "/events/1/orders/new").to route_to(
      controller: "orders",
      action: "new",
      event_id: "1"
    )
  end
  it "routes post create" do
    expect(post: "/events/1/orders").to route_to(
      controller: "orders",
      action: "create",
      event_id: "1"
    )
  end

  describe "GET #new" do
    let(:event) { Event.first }
    it "assigns a new Order to @order" do
      get :new, event_id: event.id
      expect(assigns(:order)).to be_a_new(Order)
    end
    it "renders the :new template" do
      get :new, event_id: event.id
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:event) { Event.first }
      let(:order_params) {FactoryGirl.attributes_for(:order)}
      it "saves the new order to databse" do
        expect{
          post :create, order: order_params, event_id: event.id
        }.to change(Order, :count).by(1)
      end
      it "redirects to order_confirmation#index" do
        post :create, order: order_params, event_id: event.id
        expect(response).to redirect_to order_confirmation_index_path(order_id: assigns[:order], event_id: event.id)
      end
    end
  end
end
