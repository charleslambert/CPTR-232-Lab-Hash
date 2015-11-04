#!/usr/bin/env ruby

require 'Qt'
require_relative "MyHash.rb"
require_relative "HashCollisionGraph.rb"
require_relative "myWidgets.rb"

class HashUI < Qt::Widget

    slots('createHash()', 'insert()', 'delete()', 'search()', 'hashRandom()')

    def initialize
        super
        
        setWindowTitle("MyHash")
        
        init_ui
        connections

        setFixedSize(600, 400)
        move(300, 300)

        show
    end

    def init_ui
    	@graph = CollisionGraph.new

    	#create spinbox/label widgets
        @pBox = MyValueBox.new("p = ", :spin)
        @wBox = MyValueBox.new("w = ", :spin)
        @aBox = MyValueBox.new("a = ", :text)
        @kBox = MyValueBox.new("key = ", :spin)
        @vBox = MyValueBox.new("value = ", :text)
        @nkBox = MyValueBox.new("# of keys", :spin)
        @dBox = MyValueBox.new("Delay", :spin)
       
    	#create buttons
    	@makeHash = Qt::PushButton.new("Make Hash", self)
    	@quit = Qt::PushButton.new("Quit", self)
        @hashVal = Qt::PushButton.new("Insert", self)
        @deleteVal = Qt::PushButton.new("Delete", self)
        @searchVal = Qt::PushButton.new("Search")
        @HashRandom = Qt::PushButton.new("Hash Random Value Set")

        #place the line 
        @hBBox = Qt::HBoxLayout.new do |i|
            i.addWidget(@hashVal)
            i.addWidget(@deleteVal)
            i.addWidget(@searchVal)
        end

        @verBox = Qt::VBoxLayout.new do |i|
            i.addWidget(@pBox)
            i.addWidget(@wBox)
            i.addWidget(@aBox)
            i.addWidget(@makeHash)
            i.addWidget(@kBox)
            i.addWidget(@vBox)
            i.addLayout(@hBBox)
            i.addWidget(@nkBox)
            i.addWidget(@dBox)
            i.addWidget(@HashRandom)
            i.addWidget(@quit)
        end

        @winBox = Qt::HBoxLayout.new(self) do |i|
            i.addLayout(@verBox)
            i.addWidget(@graph)
        end

    end

    def connections
        connect(@quit, SIGNAL('clicked()'), $qApp, SLOT('quit()'))
        connect(@makeHash, SIGNAL('clicked()'), self, SLOT(:createHash))
        connect(@hashVal, SIGNAL('clicked()'), self, SLOT(:insert))
        connect(@deleteVal, SIGNAL('clicked()'), self, SLOT(:delete))
        connect(@searchVal, SIGNAL('clicked()'), self, SLOT(:search))
        connect(@HashRandom, SIGNAL('clicked()'), self, SLOT(:hashRandom))
    end

    def createHash()
        @hash = MyHash.new(@pBox.value,@wBox.value,@aBox.value)
        $colA = @hash.hashArray
    end

    def delete()
        if @hash
            @hash.delete(@kBox.value)
            $colA = @hash.hashArray
        end
    end

    def search
        if @hash
            if @hash.search(@kBox.value)
                @vBox.value(@hash.search(@kBox.value).value)
            else
                @vBox.value("")
            end
        end
    end

    def insert()
        if @hash
            @hash.insert(@kBox.value, @vBox.value)
            $colA = @hash.hashArray
        end
    end

    def hashRandom()
        if @hash
            random = Random.new
            @nkBox.value.times do
                sleep(@dBox.value/10)
                @hash.insert(random.rand(100), random.rand(100))
                $colA = @hash.hashArray
                @graph.repaint()
            end
        end
    end
end

app = Qt::Application.new(ARGV)
HashUI.new
app.exec