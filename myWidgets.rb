require 'Qt'

class MyValueBox < Qt::Widget
	def initialize(label, mode)
		super()

		@mode = mode


		grid = Qt::GridLayout.new(self)

		@label = Qt::Label.new(label, self)
		if @mode == :spin
			@box = Qt::SpinBox.new do |i|
				i.range = 1..(1<<31-1)
        		i.singleStep = 1
        	end
        elsif @mode == :text
        	@box = Qt::LineEdit.new(self)
        end

        grid.addWidget(@label,0,0)
        grid.addWidget(@box, 0, 1, 1, 3)
	end

	def value(*set)
		case set.length
		when 0
			if @mode == :text
				value = @box.text.to_f
			else
				value = @box.value
			end
				return value
		when 1
			set = set.first
			if @mode == :text
				@box.text = set
			else
				@box.value = set
			end
		end
	end
end