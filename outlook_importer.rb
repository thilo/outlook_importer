require 'rubygems'
require 'fastercsv'

class OutlookImporter
  def initialize(mapping)
    @mapping = mapping.invert
    raise ArgumentError unless valid_arguments?
  end
  
  def read(file_path)
    separator = File.new(file_path).gets.match(/([,;])[^,;]+\n/)[1]
    @csv = FasterCSV.read(file_path, :headers => true, :col_sep => separator)
    assign_header_columns(@csv.headers)
  end
  
  def assign_header_columns(headers)
    @header_column_indices = {}
    @mapping.keys.each do |key|
      @header_column_indices[@mapping[key]] = headers.index(key)
    end  
  end
  
  def contacts
    _contacts = []
    @csv.each do |row|
      _contacts << contact_entry(row)
    end
    _contacts
  end
  
  def contact_entry(row)
    [
      contact_entry_name(row),
      row[@header_column_indices[:email]]
    ]
  end

  def contact_entry_name(row)
    if joined_arguments?
      row[@header_column_indices[:name]]
    else
      "#{row[@header_column_indices[:firstname]]} #{row[@header_column_indices[:lastname]]}"
    end
  end
  
  def valid_arguments?
    required_values_present? && required_keys_present?
  end
  
  def required_values_present?
    required_keys_split_up - @mapping.values == [] ||
      required_keys_joined - @mapping.values == []
  end
  
  def required_keys_present?
    values = @mapping.keys
    values.select{|val| val && val.length > 0}.length == values.length
  end
  
  def required_keys_split_up
    [:firstname, :lastname, :email]
  end
  
  def required_keys_joined
    [:name, :email]
  end
  
  def joined_arguments?
    @joined_arguments ||= @header_column_indices.include?(:name)
  end
end