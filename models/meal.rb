class Meal < MiniActiveRecord::Model


  self.attribute_names = [:id, :name, :chef_id, :created_at, :updated_at]


  # def [](attribute)
  #   raise_error_if_invalid_attribute!(attribute)

  #   @attributes[attribute]
  # end

  # def []=(attribute, value)
  #   raise_error_if_invalid_attribute!(attribute)

  #   @attributes[attribute] = value
  # end

  def chef
    Chef.where('id = ?', self[:chef_id])
  end

  def chef=(chef)
    self[:chef_id] = chef[:id]
    self.save

    chef
  end
end
