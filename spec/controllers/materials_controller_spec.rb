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

RSpec.describe MaterialsController, type: :controller do

  let(:user)            { FactoryGirl.create(:user) }
  let!(:gemstones_root) { FactoryGirl.create(:gemstone, name_en: 'Gemstone', selectable: false) }
  let!(:metals_root)    { FactoryGirl.create(:metal,    name_en: 'Metal',    selectable: false) }
  let!(:man_mades_root) { FactoryGirl.create(:man_made, name_en: 'Man Made', selectable: false) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MaterialsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  # This should return the minimal set of attributes required to create a valid
  # Material. As you add validations to Material, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:gemstone, parent_id: gemstones_root.id)
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:gemstone, parent_id: gemstones_root.id, name_en: nil)
  }


  describe 'GET #index' do

    context 'Not signed in' do
      it 'redirects to the login page' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'Signed in' do
      before { sign_in user }

      let!(:materials_hash) {
        gemstones_root.add_child(FactoryGirl.create(:gemstone))
        gemstones_root.add_child(FactoryGirl.create(:gemstone))
        Material.hash_tree
      }

      it 'assigns the @materials_hash' do
        get :index, {}, valid_session
        expect(assigns(:materials_hash)).to eq(materials_hash)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end
    end

  end


  describe 'GET #show' do

    let!(:material) { FactoryGirl.create(:gemstone) }

    context 'Not signed in' do
      it 'redirects to the login page' do
        get :show, { id: material.to_param, type: 'gemstone' }, valid_session
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'Signed in' do
      before { sign_in user }

      it 'assigns the requested material as @material' do
        get :show, { id: material.to_param, type: 'gemstone' }, valid_session
        expect(assigns(:material)).to eq(material)
      end
    end
  end


  # A new material cannot be created unless a parent ID is given ?p=123
  describe 'GET #new' do

    context 'Not signed in' do
      it 'redirects to the login page' do
        get :new, { type: 'gemstone', p: gemstones_root.id }, valid_session
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'Signed in' do
      before { sign_in user }

      describe 'without parent ID' do
        it 'redirects to the materials list' do
          get :new, { type: 'gemstone' }, valid_session
          expect(response).to redirect_to(materials_url)
        end
      end

      describe 'with invalid parent ID' do
        it 'assigns a new material as @material' do
          get :new, { type: 'gemstone', p: '123456' }, valid_session
          expect(response).to redirect_to(materials_url)
        end
      end

      describe 'with valid parent ID' do
        it 'assigns a new material as @material' do
          get :new, { type: 'gemstone', p: gemstones_root.id }, valid_session
          expect(assigns(:material)).to be_a_new(Material::Gemstone)
        end
      end
    end
  end


  describe 'GET #edit' do

    let!(:material) { FactoryGirl.create(:gemstone) }

    context 'Not signed in' do
      it 'redirects to the login page' do
        get :edit, { id: material.to_param, type: Material::Gemstone }, valid_session
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'Signed in' do
      before { sign_in user }

      it 'assigns the requested material as @material' do
        get :edit, { id: material.to_param, type: Material::Gemstone }, valid_session
        expect(assigns(:material)).to eq(material)
      end
    end
  end


  describe 'POST #create' do

    let(:type) { 'gemstone' }
    let(:attribute_hash_name) { 'material_gemstone' }

    context 'Not signed in' do
      it 'redirects to the login page' do
        expect {
          post :create, { type: type, attribute_hash_name => FactoryGirl.attributes_for(:gemstone, parent_id: gemstones_root.id) }, valid_session
        }.not_to change(Material::Gemstone, :count)
      end
    end

    context 'Signed in' do
      before { sign_in user }

      describe 'with valid params' do
        it 'creates a new Gemstone' do
          expect {
            post :create, { type: type, attribute_hash_name => FactoryGirl.attributes_for(:gemstone, parent_id: gemstones_root.id) }, valid_session
          }.to change(Material::Gemstone, :count).by(1)
        end

        it 'assigns a newly created material as @material' do
          post :create, { type: type, attribute_hash_name => FactoryGirl.attributes_for(:gemstone, parent_id: gemstones_root.id) }, valid_session
          expect(assigns(:material)).to be_a(Material::Gemstone)
          expect(assigns(:material)).to be_persisted
        end

        it 'redirects to the created material' do
          post :create, { type: type, attribute_hash_name => FactoryGirl.attributes_for(:gemstone, parent_id: gemstones_root.id) }, valid_session
          expect(response).to redirect_to(gemstones_path)
        end
      end

      describe 'with invalid params' do
        let!(:invalid_attributes) { FactoryGirl.attributes_for(:gemstone, name_en: nil) }
        it 'assigns a newly created but unsaved material as @material' do
          post :create, { type: type, attribute_hash_name => invalid_attributes }, valid_session
          expect(assigns(:material)).to be_a_new(Material::Gemstone)
        end

        it 're-renders the new template' do
          post :create, { type: type, attribute_hash_name => invalid_attributes }, valid_session
          expect(response).to render_template('new')
        end
      end
    end
  end


  describe 'PUT #update' do
    let!(:material)           { FactoryGirl.create(:gemstone, parent_id: gemstones_root.id) }
    let(:type)                { 'gemstone' }
    let(:attribute_hash_name) { 'material_gemstone' }
    let(:new_name) { material.name_en << ' UPDATED' }
    let(:update_attributes) { material.attributes.clone.merge(name_en: new_name) }

    context 'Not signed in' do
      it 'redirects to the login page' do
        put :update, { id: material.to_param, type: type, attribute_hash_name => update_attributes }, valid_session
        material.reload
        expect(material.name_en).not_to eq(new_name)
      end
    end

    context 'Signed in' do
      before { sign_in user }

      describe 'with valid params' do

        it 'updates the requested material' do
          put :update, { id: material.to_param, type: type, attribute_hash_name => update_attributes }, valid_session
          material.reload
          expect(material.name_en).to eq(new_name)
        end

        it 'assigns the requested material as @material' do
          put :update, { id: material.to_param, type: type, attribute_hash_name => update_attributes }, valid_session
          expect(assigns(:material)).to eq(material)
        end

        it 'redirects to the material index' do
          put :update, { id: material.to_param, type: type, attribute_hash_name => update_attributes }, valid_session
          expect(response).to redirect_to(gemstones_path)
        end
      end

      describe 'with invalid params' do

        let!(:invalid_attributes) { material.attributes.clone.merge(name_en: nil) }

        it 'assigns the material as @material' do
          put :update, { id: material.to_param, type: type, attribute_hash_name => invalid_attributes }, valid_session
          expect(assigns(:material)).to eq(material)
        end

        it 're-renders the edit template' do
          put :update, { id: material.to_param, type: type, attribute_hash_name => invalid_attributes }, valid_session
          expect(response).to render_template('edit')
        end
      end
    end
  end


  describe 'DELETE #destroy' do
    let!(:material) { FactoryGirl.create(:gemstone, parent_id: gemstones_root.id) }
    let(:type) { 'gemstone' }

    context 'Not signed in' do
      it 'redirects to the login page' do
        expect {
          delete :destroy, { id: material.to_param, type: type }, valid_session
        }.not_to change(Material, :count)
      end
    end

    context 'Signed in' do
      before { sign_in user }
      it 'destroys the requested material' do
        expect {
          delete :destroy, { id: material.to_param, type: type }, valid_session
        }.to change(Material, :count).by(-1)
      end

      it 'redirects to the materials list' do
        delete :destroy, { id: material.to_param, type: type }, valid_session
        expect(response).to redirect_to(materials_url)
      end
    end
  end
end
