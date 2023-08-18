require 'http'

$foxes_tags = {}

class Foxes
  def self.fox(object)
    self.internal("fox", object) 
  end
  
  def self.curious(object)
    self.internal("curious", object) 
  end
  
  def self.happy(object)
    self.internal("happy", object) 
  end
  
  def self.scary(object)
    self.internal("scary", object) 
  end
  
  def self.sleeping(object)
    self.internal("sleeping", object) 
  end

  private 

  def self.internal(name, object)
    time = Time.now.to_i/86400
    if !$foxes_tags.include?name || $foxes_tags[name]["time"] != time
      $foxes_tags[name] = {"time" => time, "count" => Integer(HTTP.get('https://foxes.cool/counts/' << name).to_s)}
    end

    id = Random.rand($foxes_tags[name]["count"])
    params = ""

    object.each do |name, value|
      params << name << "=" << String(value) << "&"
    end

    if params != ""
      params = "?" << params[0...-1]
    end
    "https://img.foxes.cool/" << name << "/" << String(id) << ".jpg" << params
  end

  private_class_method :internal
end
