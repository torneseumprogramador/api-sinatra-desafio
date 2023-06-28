class ObjParaJsonServico
  def self.converter_lista(lista)
    lista.map(&:to_h).to_json
  end

  def self.converter_obj(obj)
    obj.to_h.to_json
  end
end