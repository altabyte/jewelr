require 'rails_helper'

RSpec.describe MaterialsController, type: :routing do
  describe 'routing' do

    describe '#index' do
      it 'routes to #index' do
        expect(get: '/materials').to route_to('materials#index')
        expect(get: '/gemstones').to route_to('materials#index', type: 'gemstone')
        expect(get: '/man-mades').to route_to('materials#index', type: 'man-made')
        expect(get: '/metals').to    route_to('materials#index', type: 'metal')
      end
    end

    describe 'STI CRUD routes' do
      %w'gemstone metal man-made'.each do |type|

        it 'routes to #new' do
          expect(get: "/#{type.pluralize}/new").to route_to('materials#new', type: type)
        end

        it 'routes to #show' do
          expect(get: "/#{type.pluralize}/1").to route_to('materials#show', type: type, id: '1')
        end

        it 'routes to #edit' do
          expect(get: "/#{type.pluralize}/1/edit").to route_to('materials#edit', type: type, id: '1')
        end

        it 'routes to #create' do
          expect(post: "/#{type.pluralize}").to route_to('materials#create', type: type)
        end

        it 'routes to #update' do
          expect(put: "/#{type.pluralize}/1").to route_to('materials#update', type: type, id: '1')
        end

        it 'routes to #destroy' do
          expect(delete: "/#{type.pluralize}/1").to route_to('materials#destroy', type: type, id: '1')
        end
      end
    end
  end
end
