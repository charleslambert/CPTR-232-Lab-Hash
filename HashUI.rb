#!/usr/bin/env ruby

require 'Qt'
require_relative "MyHash.rb"
require_relative "HashCollisionGraph.rb"
require_relative "myWidgets.rb"

class HashUI < Qt::Widget

    slots('createHash()', 'insert()')

    def initialize
        super
        
        setWindowTitle("MyHash")
        
        init_ui
        connections

        resize(350, 280)
        move(300, 300)

        

        show
    end

    def init_ui
    	grid = Qt::GridLayout.new(self)

    	#create spinbox/label widgets
        @pBox = MyValueBox.new("p = ", :spin)
        @wBox = MyValueBox.new("w = ", :spin)
        @aBox = MyValueBox.new("a = ", :text)
        @kBox = MyValueBox.new("key = ", :spin)
        @vBox = MyValueBox.new("value = ", :text)


    	#place the line 
        grid.addWidget(@pBox,0,0, 1, 3)
        grid.addWidget(@wBox,1,0, 1, 3)
        grid.addWidget(@aBox,2,0, 1, 3)
        grid.addWidget(@kBox,4,0, 1, 3)
        grid.addWidget(@vBox,5,0, 1, 3)
       
    	#create buttons
    	@makeHash = Qt::PushButton.new("Make Hash", self)
    	@quit = Qt::PushButton.new("Quit", self)
        @hashVal = Qt::PushButton.new("Insert", self)
        @deleteVal = Qt::PushButton.new("Delete", self)
        @searchVal = Qt::PushButton.new("Search")

    	#place buttons
    	grid.addWidget(@makeHash,3, 0)
        grid.addWidget(@hashVal, 6, 0)
        grid.addWidget(@deleteVal, 6, 1)
        grid.addWidget(@searchVal, 6, 2)
    	grid.addWidget(@quit,7,2)
    end

    def connections
        connect(@quit, SIGNAL('clicked()'), $qApp, SLOT('quit()'))
        connect(@makeHash, SIGNAL('clicked()'), self, SLOT(:createHash))
        connect(@hashVal, SIGNAL('clicked()'), self, SLOT(:insert))
    end

    def createHash()
        @hash = MyHash.new(@pBox.value,@wBox.value,@aBox.value)
        $colA = @hash.hashArray
        if @graph

        else
            @graph = CollisionGraph.new
        end
        @graph.show
        
    end

    def delete
    end

    def search
    end

    def insert()
        @hash.insert(@kBox.value, @vBox.value)
        $colA = @hash.hashArray
    end
end

app = Qt::Application.new(ARGV)
HashUI.new
app.exec