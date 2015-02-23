class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "> #{@name} says Arf!!"
  end
end

fido = GoodDog.new("Fido")
jules = GoodDog.new("Jules")

puts fido.speak
puts jules.speak
puts fido.name
puts jules.name
jules.name = "Julien" #Ability to write the method over 
puts jules.name