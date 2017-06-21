class CommandObject
  
  def self.call(*args)
    new(*args).call
  end

end
