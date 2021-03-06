require_relative './automated_init'

context "Associated entity representation is inserted into database" do
  entity_id = Identifier::UUID::Random.get
  association_id = Identifier::UUID::Random.get

  Controls::Entity.insert entity_id

  entity = Controls::Entity::Example.get entity_id
  entity.example_association.find_or_new :id => association_id do |associated_entity|
    associated_entity.association_attribute = 'some-associated-value'
  end
  entity.save

  test "Database row corresponding to associated entity has been inserted" do
    associated_entity = Controls::Entity::Association::Example.find :id => association_id

    assert associated_entity.association_attribute == 'some-associated-value'
  end
end
