describe 'latihan automation api on  https://restful-api.dev/' do

    it 'get list of all object', :test_1 do
        get '/objects'

        ap json_body

        expect_json_types('*', id: :string, name: :string)
        expect_json_types('*',data: :object_or_null)
        expect_status 200
    end

    it 'GET LIST OF OBJECTS BY IDS', :test_2 do
        get '/objects', 'params' =>
        {
          'id' => '4, 5'
        }
    
        expect_status(200) # assertion
    
        # satu per satu
        expect_json_types('0', id: :string, name: :string) # assertion
        expect_json_types('0', data: :object_or_null) # assertion
    
        expect_json_types('1', id: :string, name: :string) # assertion
        expect_json_types('1', data: :object_or_null) # assertion
    
        # # ATAU bulk
        # expect_json_types('*', id: :string, name: :string) # assertion
        # expect_json_types('*', data: :object_or_null) # assertion
      end
    
    
  it 'POST OBJECT', :test_3 do
      # request body
      post '/objects', {
        "name": "Supra X",
          "data": {
              "year": 2019,
              "price": 15000000,
              "cc": 125,
              "warna": "hitam/merah"
          }
      }
  
      ap json_body
  
      expect_json_types(id: :string)
  
      expect_json("name": "Supra X")
  
      # cara 1
      # expect_json("data.year": 2019)
      # expect_json("data.price": 15000000)
      # expect_json("data.cc": 125)
      # expect_json("data.warna": "hitam/merah")
  
      # cara 2
      expect_json("data":{
              "year": 2019,
              "price": 15000000,
              "cc": 125,
              "warna": "hitam/merah"
      })
    end

  


  it 'PUT UPDATE OBJECT', :test_5 do

    object_id = 'ff808181902733350190403367ac28d4'
    # request body
    put "/objects/#{object_id}", {
      "name": "Supra X 125 CC",
        "data": {
            "year": 2022,
            "price": 16000000,
            "cc": 125,
            "warna": "hitam/merah"
        }
    }

    ap json_body

    expect_json_types(id: :string)
    expect_json("name": "Supra X 125 CC")
    expect_json("data":{
            "year": 2022,
            "price": 16000000,
            "cc": 125,
            "warna": "hitam/merah"
    })
  end

  it 'PATCH PARTIALLY UPDATE OBJECT', :test_6 do

    object_id = 'ff808181902733350190403367ac28d4'
    # request body
    patch "/objects/#{object_id}", {
      "name": "Supra X 125 CC MERAH/HITAM"
    }

    ap json_body

    expect_json_types(id: :string)
    expect_json("name": "Supra X 125 CC MERAH/HITAM")
    expect_json("data":{
            "year": 2023,
            "price": 16000000,
            "cc": 125,
            "warna": "hitam/merah"
    })
  end


  it 'DELETE OBJECT', :test_7 do
    object_id = 'ff808181902733350190404590c628e0'
    delete "/objects/#{object_id}"

    expect_status(200)

    expect_json(message: "Object with id = #{object_id} has been deleted.")
  end

end
