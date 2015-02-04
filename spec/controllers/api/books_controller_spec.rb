require 'rails_helper'

RSpec.describe Api::BooksController, type: :controller do
  describe "#index" do
    let!(:books) do
      3.times.map { create :book }
    end
    
    it "should return array of all books in json" do
      get :index, format: :json

      expect(response).to be_success
      expect(response.content_type).to eq Mime::JSON
      expect(json_response.count).to eq 3
      expect(json_response.map { |b| b['name'] }.sort).to eq Book.pluck(:name).sort
    end
  end

  describe '#create' do
    context 'when all params are vaild' do
      let(:book_create) do
        post :create, format: :json, book: { name: 'book_name', description: 'book_description', release_date: '2015-01-01' }
      end

      it 'should create new book' do
        expect { book_create }.to change { Book.count }.by(1)
      end

      it 'should return new book data in json' do
        book_create

        expect(response).to be_success
        expect(response.content_type).to eq Mime::JSON
        expect(json_response['name']).to eq Book.last.name
        expect(json_response['description']).to eq Book.last.description
        expect(json_response['release_date'].to_date).to eq Book.last.release_date
      end
    end

    context 'when any params are invalid' do
      let(:invalid_name_book_create) do
        post :create, format: :json, book: { name: '', description: 'book_description', release_date: '2015-01-01' }
      end

      it 'should not create new book' do
        expect { invalid_name_book_create }.to change { Book.count }.by(0)
      end

      it 'should return name errors in json' do
        invalid_name_book_create

        expect(response.status).to eq 422
        expect(response.content_type).to eq Mime::JSON
        expect(json_response).to eq Hash['name', ["can't be blank"]]
      end
    end
  end

  describe '#show' do
    let!(:book) { create :book }

    context 'when book with specified id exist' do
      it 'should return book data in json' do
        get :show, format: :json, id: book.id
        
        expect(response).to be_success
        expect(response.content_type).to eq Mime::JSON
        expect(json_response['name']).to eq book.name
        expect(json_response['description']).to eq book.description
        expect(json_response['release_date'].to_date).to eq book.release_date
      end
    end
  
    context 'when book with specified id is not found' do
      it 'should return 404 in response' do
        get :show, format: :json, id: 0

        expect(response.status).to eq 404
      end
    end
  end

  describe '#update' do
    let!(:book) { create :book }

    context 'when all params are vaild' do
      let(:book_update) do
        patch :update, format: :json, id: book.id, book: { name: 'book_name', description: 'book_description', release_date: '2015-01-01' }
      end
      
      it "should update book with specified id" do
        book_update
        
        book.reload
        expect(book.name).to eq 'book_name'
        expect(book.description).to eq 'book_description'
        expect(book.release_date).to eq '2015-01-01'.to_date
      end

      it 'should return new book data in json' do
        book_update
        
        book.reload
        expect(response).to be_success
        expect(response.content_type).to eq Mime::JSON
        expect(json_response['name']).to eq book.name
        expect(json_response['description']).to eq book.description
        expect(json_response['release_date'].to_date).to eq book.release_date
      end
    end
  
    context 'when any params are invalid' do
      it 'should return name errors in json' do
        patch :update, format: :json, id: book.id, book: { name: '' }

        expect(response.status).to eq 422
        expect(response.content_type).to eq Mime::JSON
        expect(json_response).to eq Hash['name', ["can't be blank"]]
      end
    end

    context 'when book with specified id is not found' do
      it 'should return 404 in response' do
        patch :update, format: :json, id: 0, book: { name: 'book_name' }

        expect(response.status).to eq 404
      end
    end
  end
  
  describe '#destroy' do
    let!(:book) { create :book }

    it "should destroy book with specified id" do
      delete :destroy, format: :json, id: book.id
      
      expect(response.status).to eq 204
      expect(Book.find_by(id: book.id)).to eq nil
    end

    context 'when book with specified id is not found' do
      it 'should return 404 in response' do
        delete :destroy, format: :json, id: 0

        expect(response.status).to eq 404
      end
    end
  end
end
