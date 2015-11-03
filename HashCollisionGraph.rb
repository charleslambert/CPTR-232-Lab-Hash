require 'Qt'


class CollisionGraph < Qt::Widget

    def initialize
        super
        setWindowTitle("Collision Graph")
        winWidth = 350
        winHeight = 280
        winX = 670
        winY = 300

        @colorFactor = 20
        @recXSep = 20
        @recHeightFactor = -5
        @recY = 110
        @recWidth = 10

        resize(winWidth, winHeight)
        move(winX, winY)

    end
    
    
    def paintEvent(event)
          painter = Qt::Painter.new(self)
          drawShapes(painter)
          painter.end
    end

    
    def drawShapes(painter)
        update()
        painter.setRenderHint Qt::Painter::Antialiasing

        #simple incrementor for spacing of bars
        i = 0

        $colA.each { |count| 
            #condition to keep the color variable within bounds
                if (count*@colorFactor) <= 150
                    color = count*@colorFactor
                else
                    color = 150
                end
                #create rectangle with color and size based on 
                painter.setBrush Qt::Brush.new Qt::Color.new(color, 0, 150-color)
                painter.drawRect(10+i*@recXSep, @recY, @recWidth, count*@recHeightFactor)

                i += 1
        } unless $colA == nil
    end

    def resizeWin(height)

    end
end