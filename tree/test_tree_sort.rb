require "test/unit"
require "./tree_sort.rb"

class TC_Tree < Test::Unit::TestCase
    def setup 
        @test  = Tree.new()
        @name  = []
        @key   = {}
        @value = {}
        @parent_key = {}
    end

    def test_add()
        def set_data!( test_name, key, value, parent_key="" )
            @name << test_name
            @key        .store( @name[-1],key )
            @value      .store( @name[-1],value )
            @parent_key .store( @name[-1],parent_key )
        end

        # 01,0
        set_data!( "test1", "01", "0" )
        @test.add!( @key[ @name[0] ], @value[ @name[0] ] )
        assert ( @test.root.key == @key[ @name[0] ] ), 'add0 is fail'
        assert ( @test.output == [[@key[@name[0]], @value[@name[0]]]] 
               ), 'add0 is fail.'

        # 01, 0,   ,  ,
        #   ,  , 10, 1, 01
        set_data!( "test2", "10", "1", "01" )
        @test.add!( @key[@name[1] ], @value[@name[1]], @parent_key[@name[1]] )
        assert ( @test.root.children[0].key == @key[ @name[1] ] ), 'add1 is fail'
        assert ( @test.depth == 2 ), 'depth is fail.'
        assert ( @test.output == [ 
            [@key[@name[0]], @value[@name[0]],            nil,            nil],
            [           nil,              nil, @key[@name[1]], @value[@name[1]]],
        ]), 'add1 is fail.' 

        # 01, 0,   ,  ,   ,  ,
        #   ,  , 10, 1,   ,  , 01
        #   ,  ,   ,  , 11, 2, 10
        set_data!( "test3", "11", "2", "10" )
        @test.add!( @key[@name[2] ], @value[@name[2]], @parent_key[@name[2]] )
        assert ( @test.depth  == 3 ), 'depth id fail'
        assert ( @test.output == [ 
            [@key[@name[0]], @value[@name[0]],            nil,              nil,            nil,               nil],
            [           nil,              nil, @key[@name[1]], @value[@name[1]],            nil,               nil],
            [           nil,              nil,            nil,              nil, @key[@name[2]], @value[@name[2]] ],
        ]), 'add2 is fail.' 

        # 01, 0,   ,  ,   ,  ,
        #   ,  , 10, 1,   ,  , 01
        #   ,  ,   ,  , 10, 3, 10
        #   ,  ,   ,  , 11, 2, 10
        set_data!( "test4", "10", "3", "10" )
        @test.add!( @key[@name[3] ], @value[@name[3]], @parent_key[@name[3]] )
        assert ( @test.depth  == 3 ), 'depth id fail'
        assert ( @test.output == [ 
            [@key[@name[0]], @value[@name[0]],            nil,              nil,            nil,               nil],
            [           nil,              nil, @key[@name[1]], @value[@name[1]],            nil,               nil],
            [           nil,              nil,            nil,              nil, @key[@name[3]], @value[@name[3]] ],
            [           nil,              nil,            nil,              nil, @key[@name[2]], @value[@name[2]] ],
        ]), 'add3 is fail.' 
    end
end

