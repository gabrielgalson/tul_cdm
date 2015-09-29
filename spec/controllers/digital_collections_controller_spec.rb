require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe DigitalCollectionsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # DigitalCollection. As you add validations to DigitalCollection, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
   FactoryGirl.build(:digital_collection).attributes
  }

  let(:invalid_attributes) {
   FactoryGirl.build(:invalid_digital_collection).attributes
  }

  let(:private_collection) {
   FactoryGirl.build(:private_digital_collection).attributes
  }

  let(:private_attributes_allowed) {
   FactoryGirl.build(:private_digital_collection_allowed).attributes
  }

  let(:private_attributes_denied) {
   FactoryGirl.build(:private_digital_collection_denied).attributes
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # DigitalCollectionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all digital_collections as @digital_collections" do
      digital_collection = DigitalCollection.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:digital_collections)).to eq([digital_collection])
    end

    it "allows the private collection" do
      digital_collection = DigitalCollection.create! private_attributes_allowed
      get :index, {}, valid_session
      expect(assigns(:digital_collections)).to eq([digital_collection])
    end

    it "denies the private collection" do
      digital_collection = DigitalCollection.create! private_attributes_denied
      get :index, {}, valid_session
      expect(assigns(:digital_collections)).to be_empty
    end
  end

  describe "GET restricted" do
    context "Unauthenticated Session" do
      it "denies the private collection" do
        digital_collection = DigitalCollection.create! private_collection
        get :restricted, {}
        expect(assigns(:digital_collections)).to be_nil
      end
    end

    context "Authenticated Access" do
      before (:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "allows the private collection" do
        digital_collection = DigitalCollection.create! private_collection
        get :restricted, {}
        expect(assigns(:digital_collections)).to eq([digital_collection])
      end

      it "allows with allowed IP address" do
        digital_collection = DigitalCollection.create! private_attributes_allowed
        get :restricted, {}
        expect(assigns(:digital_collections)).to eq([digital_collection])
      end

      it "allows with unrecognized collection" do
        digital_collection = DigitalCollection.create! private_attributes_denied
        get :restricted, {}
        expect(assigns(:digital_collections)).to eq([digital_collection])
      end
    end
  end

  describe "GET show" do
    it "assigns the requested digital_collection as @digital_collection" do
      digital_collection = DigitalCollection.create! valid_attributes
      get :show, {:id => digital_collection.to_param}, valid_session
      expect(assigns(:digital_collection)).to eq(digital_collection)
    end

    it "assigns the requested private_digital_collection_allowed as @digital_collection" do
      digital_collection = DigitalCollection.create! private_attributes_allowed
      get :show, {:id => digital_collection.to_param}, valid_session
      expect(assigns(:digital_collection)).to eq(digital_collection)
      expect(flash.now[:error]).to be_nil
    end

    it "assigns the requested private_digital_collection_denied as @digital_collection" do
      digital_collection = DigitalCollection.create! private_attributes_denied
      get :show, {:id => digital_collection.to_param}, valid_session
      expect(response).to redirect_to(digital_collections_path)
      expect(flash.now[:error]).to eq I18n.t('tul_cdm.digital_collection.not_available')
    end

    it "Attempts to show a non-existent record" do
      get :show, {:id => -1}, valid_session
      expect(response).to redirect_to(digital_collections_path)
      expect(flash.now[:error]).to eq I18n.t('tul_cdm.digital_collection.not_available')
    end
  end

  context "With valid session" do
    before (:each) do
      sign_in FactoryGirl.create(:user)
    end

    describe "GET new" do
      it "assigns a new digital_collection as @digital_collection" do
        get :new, {}, valid_session
        expect(assigns(:digital_collection)).to be_a_new(DigitalCollection)
      end
    end

    describe "GET edit" do
      it "assigns the requested digital_collection as @digital_collection" do
        digital_collection = DigitalCollection.create! valid_attributes
        get :edit, {:id => digital_collection.to_param}, valid_session
        expect(assigns(:digital_collection)).to eq(digital_collection)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new DigitalCollection" do
          expect {
            post :create, {:digital_collection => valid_attributes}, valid_session
          }.to change(DigitalCollection, :count).by(1)
        end

        it "assigns a newly created digital_collection as @digital_collection" do
          post :create, {:digital_collection => valid_attributes}, valid_session
          expect(assigns(:digital_collection)).to be_a(DigitalCollection)
          expect(assigns(:digital_collection)).to be_persisted
        end

        it "redirects to the created digital_collection" do
          post :create, {:digital_collection => valid_attributes}, valid_session
          expect(response).to redirect_to(DigitalCollection.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved digital_collection as @digital_collection" do
          post :create, {:digital_collection => invalid_attributes}, valid_session
          expect(assigns(:digital_collection)).to be_a_new(DigitalCollection)
        end

        it "re-renders the 'new' template" do
          post :create, {:digital_collection => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:new_attributes) {
          FactoryGirl.build(:updated_digital_object).attributes
        }

        it "updates the requested digital_collection" do
          digital_collection = DigitalCollection.create! valid_attributes
          put :update, {:id => digital_collection.to_param, :digital_collection => new_attributes}, valid_session
          digital_collection.reload
          expect(digital_collection.collection_alias).to eq new_attributes["collection_alias"]
          expect(digital_collection.name).to eq new_attributes["name"]
          expect(digital_collection.image_url).to eq new_attributes["image_url"]
          expect(digital_collection.thumbnail_url).to eq new_attributes["thumbnail_url"]
          expect(digital_collection.description).to eq new_attributes["description"]
          expect(digital_collection.is_private).to eq new_attributes["is_private"]
          expect(digital_collection.allowed_ip_addresses).to eq new_attributes["allowed_ip_addresses"]
          expect(digital_collection.featured).to eq new_attributes["featured"]
          expect(digital_collection.custom_url).to eq new_attributes["custom_url"]
        end

        it "assigns the requested digital_collection as @digital_collection" do
          digital_collection = DigitalCollection.create! valid_attributes
          put :update, {:id => digital_collection.to_param, :digital_collection => valid_attributes}, valid_session
          expect(assigns(:digital_collection)).to eq(digital_collection)
        end

        it "redirects to the digital_collection" do
          digital_collection = DigitalCollection.create! valid_attributes
          put :update, {:id => digital_collection.to_param, :digital_collection => valid_attributes}, valid_session
          expect(response).to redirect_to(digital_collection)
        end
      end

      describe "with invalid params" do
        it "assigns the digital_collection as @digital_collection" do
          digital_collection = DigitalCollection.create! valid_attributes
          put :update, {:id => digital_collection.to_param, :digital_collection => invalid_attributes}, valid_session
          expect(assigns(:digital_collection)).to eq(digital_collection)
        end

        it "re-renders the 'edit' template" do
          digital_collection = DigitalCollection.create! valid_attributes
          put :update, {:id => digital_collection.to_param, :digital_collection => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested digital_collection" do
        digital_collection = DigitalCollection.create! valid_attributes
        expect {
          delete :destroy, {:id => digital_collection.to_param}, valid_session
        }.to change(DigitalCollection, :count).by(-1) end

      it "redirects to the digital_collections list" do
        digital_collection = DigitalCollection.create! valid_attributes
        delete :destroy, {:id => digital_collection.to_param}, valid_session
        expect(response).to redirect_to(digital_collections_url)
      end
    end
  end

  context "Unauthenticated session" do

    describe "GET new" do
      it "assigns a new digital_collection as @digital_collection" do
        get :new, {}, valid_session
        expect(flash.now[:error]).to eq I18n.t('devise.failure.unauthenticated')
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET edit" do
      it "assigns the requested digital_collection as @digital_collection" do
        digital_collection = DigitalCollection.create! valid_attributes
        get :edit, {:id => digital_collection.to_param}, valid_session
        expect(flash.now[:error]).to eq I18n.t('devise.failure.unauthenticated')
        expect(response).to redirect_to(root_path)
      end
    end

    describe "POST create" do
      it "creates a new DigitalCollection" do
        post :create, {:digital_collection => valid_attributes}
        expect(flash.now[:error]).to eq I18n.t('devise.failure.unauthenticated')
        expect(response).to redirect_to(root_path)
      end
    end

    describe "PUT update" do
      let(:new_attributes) {
        FactoryGirl.build(:updated_digital_object).attributes
      }

      it "updates the requested digital_collection" do
        digital_collection = DigitalCollection.create! valid_attributes
        put :update, {:id => digital_collection.to_param, :digital_collection => new_attributes}, valid_session
        expect(flash.now[:error]).to eq I18n.t('devise.failure.unauthenticated')
        expect(response).to redirect_to(root_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects to the digital_collections list" do
        digital_collection = DigitalCollection.create! valid_attributes
        delete :destroy, {:id => digital_collection.to_param}, valid_session
        expect(flash.now[:error]).to eq I18n.t('devise.failure.unauthenticated')
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
