require 'Qt'


class CollisionGraph < Qt::Widget

    def initialize
        super

        setWindowTitle("Collision Graph")

        @colorFactor = 5
        @recXsep = 5
        @colorMax = 250
        @recHeightFactor = -5

    end
    
    
    def paintEvent(event)
          @painter = Qt::Painter.new(self)
          drawShapes(@painter)
          @painter.end
    end

    
    def drawShapes(painter)
        update()
        painter.setRenderHint Qt::Painter::Antialiasing

        recWidth = (width()/$colA.length)-@recXsep unless not $colA 
        #simple incrementor for spacing of bars
        i = 0

        if $colA
            if ($colA.max*@recHeightFactor) > height()
                recHeightFactor = height()/$colA.max
            else
                recHeightFactor = @recHeightFactor
            end
        end

        $colA.each { |count| 
            #condition to keep the color variable within bounds
                if (count*@colorFactor) <= @colorMax
                    color = count*@colorFactor
                else
                    color = @colorMax
                end
                #create rectangle with color and size based on 
                painter.setBrush Qt::Brush.new Qt::Color.new(color, 0, @colorMax-color)
                painter.drawRect(i*(recWidth+@recXsep), height(), recWidth, count*recHeightFactor)

                i += 1
        } unless $colA == nil
    end
end