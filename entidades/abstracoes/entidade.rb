class Entidade
  def to_h
    hash = {}
    instance_variables.each do |var|
        hash[var.to_s.delete('@')] = instance_variable_get(var)
    end
    hash
  end
end