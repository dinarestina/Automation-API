describe 'latihan automation api on  https://restful-api.dev/' do

    it 'get list of all object', :test_1 do
        get '/objects'

        ap json_body

        expect_json_types('*', id: :string, name: :string)
        expect_json_types('*',data: :object_or_null)
        expect_status 200
    end

end