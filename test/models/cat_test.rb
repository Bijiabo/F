require 'test_helper'

class CatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @cat = Cat.new name: "Speedy", age: 1, breed: "China Cat"
  end

  test "cat validate" do
    name = @cat.name
    age = @cat.age
    breed = @cat.breed

    assert @cat.valid?

    @cat.name = ""
    assert_not @cat.valid?
    @cat.name = name

    @cat.age = -1
    assert_not @cat.valid?
    @cat.age = "x"
    assert_not @cat.valid?
    @cat.age = age

    @cat.breed = "C"*51
    assert_not @cat.valid?
  end

  test "cat name should be present" do
    @cat.name = " "*5
    assert_not @cat.valid?

    @cat.name = ""
    assert_not @cat.valid?
  end


end
