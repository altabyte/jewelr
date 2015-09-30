require 'rails_helper'

RSpec.describe DescriptionsController, type: :routing do
  describe 'routing' do

    def self.description_types
      types = []
      Dir.foreach("#{Rails.root}/app/models/description") do |type|
        next if %w'. ..'.include? type
        types << type.gsub('_', '-').gsub('.rb', '')
      end
      types
    end
    let(:description_types) { self.class.description_types }

    let(:prefix) { DescriptionsController::TYPE_ROUTE_PREFIX }

    describe 'STI CRUD routes' do
      description_types.each do |type|

        it 'routes to #index' do
          path = "#{prefix}/#{type.pluralize}"
          puts "GET:    #{path}"
          expect(get: path).to route_to('descriptions#index', type: type)
        end

        it 'routes to #new' do
          path = "#{prefix}/#{type.pluralize}/new"
          puts "GET:    #{path}"
          expect(get: path).to route_to('descriptions#new', type: type)
        end

        it 'routes to #show' do
          path = "#{prefix}/#{type.pluralize}/1"
          puts "GET:    #{path}"
          expect(get: path).to route_to('descriptions#show', type: type, id: '1')
        end

        it 'routes to #edit' do
          path = "#{prefix}/#{type.pluralize}/1/edit"
          puts "GET:    #{path}"
          expect(get: path).to route_to('descriptions#edit', type: type, id: '1')
        end

        it 'routes to #create' do
          path = "#{prefix}/#{type.pluralize}"
          puts "POST:   #{path}"
          expect(post: path).to route_to('descriptions#create', type: type)
        end

        it 'routes to #update' do
          path = "#{prefix}/#{type.pluralize}/1"
          puts "PUT:    #{path}"
          puts "PATCH:  #{path}"
          expect(put:   path).to route_to('descriptions#update', type: type, id: '1')
          expect(patch: path).to route_to('descriptions#update', type: type, id: '1')
        end

        it 'routes to #destroy' do
          path = "#{prefix}/#{type.pluralize}/1"
          puts "DELETE: #{path}"
          expect(delete: path).to route_to('descriptions#destroy', type: type, id: '1')
        end
      end
    end
  end
end
