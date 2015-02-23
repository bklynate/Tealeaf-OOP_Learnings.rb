require "pry"

class GoodDog
  attr_accessor :name, :weight, :height

  def change_info(n,w,h)
    name = n
    weight = w
    height = h
  end

  def initialize(name)
    @name = name
  end

  def speak
    "> #{name} says Arf!!"
  end

  def info
    "Name: #{name} | Weight: #{weight} | Height: #{height}"
  end
end

fido = GoodDog.new("Fido")
jules = GoodDog.new("Jules")

binding.pry
puts fido.speak
puts jules.speak
puts fido.name
puts jules.name
jules.name = "Julien" #Ability to write the method over 
puts jules.name