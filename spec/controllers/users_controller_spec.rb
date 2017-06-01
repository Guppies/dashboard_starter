RSpec.describe UsersController, type: :controller do
  before :each do
    @user = FactoryGirl.create(:user, class_name: 'AdminUser')
    sign_in(@user, scope: :user)
  end

  describe 'GET index' do
    it 'assigns @users' do
      user2 = FactoryGirl.create(:user, email: Faker::Internet.email)
      get :index
      expect(assigns(:users)).to eq([user2])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST create' do
    it 'creates a new user' do
      expect { post :create, params: { user: { name: Faker::Name.first_name, email: Faker::Internet.email } } }.to change(User, :count).by(1)
      expect(response).to redirect_to(users_path)
    end

    it 'does not create a new user' do
      expect { post :create, params: { user: { name: Faker::Name.first_name, email: 'wrongemail.com' } } }.to change(User, :count).by(0)
      expect(response).to render_template(:new)
    end
  end

  describe 'PATCH update' do
    it 'updates a user' do
      patch :update, params: { id: @user, name: Faker::Name.first_name, email: Faker::Internet.email }
      expect(response).to redirect_to(users_path)
    end

    xit 'does not update a user' do
      patch :update, params: { id: @user, name: Faker::Name.first_name, email: 'wrongemail' }
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the user' do
      expect { delete :destroy, params: { id: @user } }.to change(User, :count).by(-1)
      expect(response).to redirect_to(users_path)
    end
  end
end
