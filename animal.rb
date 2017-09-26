class Animal
    def initialize(weight)
       @weight = weight 
    end
    
    def weigh
       "I weigh #{@weight} lbs" 
    end
    
end

class Pet < Animal
    def initialize(weight, name)
        super(weight)
        @name = name  
    end
    
    def name
        "My name is #{@name}"  
    end
end

class Dog < Pet
   def speak
     "WOOF"  
   end
end

class Cat < Pet
    def speak
     "???"
   end   
end

candy = Dog.new(75, "Candy")
print "This is the dog's name #{candy.name}\n"
puts candy.speak
candy.weigh
bob = Cat.new(25, "Bob")
bob.name
bob.speak
bob.weigh
