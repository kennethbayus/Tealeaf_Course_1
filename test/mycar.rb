class MyCar
	
	attr_accessor :color
	attr_reader :year

	def initialize(year, color, model)
		@year=year
		@color=color
		@model=model
		@speed=0
	end

	def speed_up(mph)
		@speed += mph
	end

	def brake (mph)
		@speed -= mph
	end

	def shut_down()
		@speed=0
	end

	def current_speed()
		puts "current speed is #{@speed}"
	end

	def spray_paint(color)
		self.color = color
	end

end

lumia=MyCar.new(1928,"r","lumia")

lumia.current_speed

lumia.speed_up(15)

lumia.current_speed

p lumia.color
lumia.color=('blue')
p lumia.color

p lumia.year

lumia.spray_paint("green")

p lumia.color	