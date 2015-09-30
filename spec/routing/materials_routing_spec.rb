require 'rails_helper'

RSpec.describe MaterialsController, type: :routing do
  describe 'routing' do

    def self.material_types
      types = []
      Dir.foreach("#{Rails.root}/app/models/material") do |type|
        next if %w'. ..'.include? type
        types << type.gsub('_', '-').gsub('.rb', '')
      end
      types
    end
    let(:material_types) { self.class.material_types }

    let(:prefix) { MaterialsController::TYPE_ROUTE_PREFIX }

    describe 'STI CRUD routes' do
      material_types.each do |type|

        it 'routes to #index' do
          path = "#{prefix}/#{type.pluralize}"
          puts "GET:    #{path}"
          expect(get: path).to route_to('materials#index', type: type)
        end

        it 'routes to #new' do
          path = "#{prefix}/#{type.pluralize}/new"
          puts "GET:    #{path}"
          expect(get: path).to route_to('materials#new', type: type)
        end

        it 'routes to #show' do
          path = "#{prefix}/#{type.pluralize}/1"
          puts "GET:    #{path}"
          expect(get: path).to route_to('materials#show', type: type, id: '1')
        end

        it 'routes to #edit' do
          path = "#{prefix}/#{type.pluralize}/1/edit"
          puts "GET:    #{path}"
          expect(get: path).to route_to('materials#edit', type: type, id: '1')
        end

        it 'routes to #create' do
          path = "#{prefix}/#{type.pluralize}"
          puts "POST:   #{path}"
          expect(post: path).to route_to('materials#create', type: type)
        end

        it 'routes to #update' do
          path = "#{prefix}/#{type.pluralize}/1"
          puts "PUT:    #{path}"
          puts "PATCH:  #{path}"
          expect(put:   path).to route_to('materials#update', type: type, id: '1')
          expect(patch: path).to route_to('materials#update', type: type, id: '1')
        end

        it 'routes to #destroy' do
          path = "#{prefix}/#{type.pluralize}/1"
          puts "DELETE: #{path}"
          expect(delete: path).to route_to('materials#destroy', type: type, id: '1')
        end
      end
    end
  end
end
