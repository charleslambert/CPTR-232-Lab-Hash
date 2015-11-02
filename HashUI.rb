#!/usr/bin/env ruby

require 'Qt'
require_relative "MyHash.rb"
require_relative "HashCollisionGraph.rb"

class HashUI < Qt::Widget

    slots('createHash()', 'hashVal()')

    def initialize
        super
        
        setWindowTitle("MyHash")
        
        init_ui
        connections

        resize(350, 280)
        move(300, 300)

        @graph = CollisionGraph.new

        show
    end

    def init_ui
    	grid = Qt::GridLayout.new(self)

    	#create line edits and labels
    	@pLabel = Qt::Label.new("p =",self)
    	@pEdit = Qt::LineEdit.new(self)
    	@wLabel = Qt::Label.new("w =",self)
    	@wEdit = Qt::LineEdit.new(self)
    	@aLabel = Qt::Label.new("A =",self)
    	@aEdit = Qt::LineEdit.new(self)
        @eLabel = Qt::Label.new("element =",self)
        @eEdit = Qt::LineEdit.new(self)
        @kLabel = Qt::Label.new("key =",self)
        @kEdit = Qt::LineEdit.new(self)


    	#place the line edits and there labels
        #line edits and labels for creating hash
    	grid.addWidget(@pLabel, 0, 0)
    	grid.addWidget(@pEdit, 0, 1, 1, 3)
    	grid.addWidget(@wLabel, 1, 0)
    	grid.addWidget(@wEdit, 1, 1, 1, 3)
    	grid.addWidget(@aLabel, 2 ,0)
    	grid.addWidget(@aEdit, 2, 1, 1, 3)

        #line edits and labels for hasing a value
        grid.addWidget(@eLabel, 4, 0)
        grid.addWidget(@eEdit, 4, 1, 1, 3)
        grid.addWidget(@kLabel, 5, 0)
        grid.addWidget(@kEdit, 5, 1, 1, 3)

    	#create buttons
    	@makeHash = Qt::PushButton.new("Make Hash",self)
    	@quit = Qt::PushButton.new("Quit",self)
        @hashVal = Qt::PushButton.new("Hash Value",self)

    	#place buttons
    	grid.addWidget(@makeHash,3,0)
        grid.addWidget(@hashVal, 6,0)
    	grid.addWidget(@quit,7,2)
    end

    def connections
        connect(@quit, SIGNAL('clicked()'), $qApp, SLOT('quit()'))
        connect(@makeHash, SIGNAL('clicked()'), self, SLOT(:createHash))
        connect(@hashVal, SIGNAL('clicked()'), self, SLOT(:hashVal))
    end

    def createHash()
        @hash = MyHash.new(@pEdit.text.to_i,@wEdit.text.to_i,@aEdit.text.to_f)
        $colA = @hash.hashArray
        

    end

    def hashVal()
        @hash.insert(@kEdit.text.to_i, @eEdit.text.to_i)
        $colA = @hash.hashArray
    end
end

app = Qt::Application.new(ARGV)
HashUI.new
app.exec