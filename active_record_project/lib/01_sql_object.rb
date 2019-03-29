require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    @cols ||= DBConnection.execute2(<<-SQL)
      SELECT *
      FROM #{self.table_name}
    SQL
    .first.map { |el| el.to_sym }
  end

  def self.finalize!
    columns.each do |attr|
      define_method(attr) { attributes[attr] }
      define_method("#{attr}=") { |val| attributes[attr] = val}
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    self.to_s.downcase + 's'  # name  + 's'
  end

  def self.all
    # ...
    arg1 = table_name
    puts arg1
    DBConnection.execute(<<-SQL, arg1)
      SELECT *
      FROM ?
    SQL
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
    params.each do |k, v|
      raise "unknown attribute '#{k}'" unless self.class.columns.include?(k)
      send("#{k}=", v)
    end
    
  end

  def attributes
    # ...
    @attributes ||= Hash.new
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
