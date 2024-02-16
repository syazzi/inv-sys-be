class DepartmentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  has_many :stocks
end
