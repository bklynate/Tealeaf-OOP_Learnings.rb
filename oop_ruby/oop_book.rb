class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

  def set_name=(name)
    @name = name
  end

  def speak
    puts "> #{@name} says Arf!!"
  end
end

fido = GoodDog.new("Fido")
jules = GoodDog.new("Jules")

fido.speak
jules.speak