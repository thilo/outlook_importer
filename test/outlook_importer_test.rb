require File.dirname(__FILE__) + '/test_helper.rb'

class OutlookImporterTest < Test::Unit::TestCase
  def test_read_outlook_contacts
    lookup_table = {
      :firstname => 'Vorname',
      :lastname => 'Nachname',
      :email => 'E-Mail-Adresse'
    }
    importer = OutlookImporter.new(lookup_table)
    importer.read('outlook_2007_de.csv')
    
    assert_equal importer.contacts.first, ["Robin Example", "robin@example.de"]
  end
  
  def test_read_livemail_contacts
    lookup_table = {
      :name => 'Name',
      :email => 'E-Mail-Adresse'
    }
    importer = OutlookImporter.new(lookup_table)
    importer.read('livemail_de.csv')
    
    assert_equal importer.contacts.first, ["Robin Example", "robin@example.de"]
  end
  
  def test_read_outlook_contacts_without_providing_a_lookup_table
    importer = OutlookImporter.new
    importer.read('outlook_2007_de.csv')
    
    assert_equal importer.contacts.first, ["Robin Example", "robin@example.de"]    
  end

  def test_read_livemail_contacts_without_providing_a_lookup_table
    importer = OutlookImporter.new
    importer.read('livemail_de.csv')
    
    assert_equal importer.contacts.first, ["Robin Example", "robin@example.de"]    
  end
  
  def test_read_from_a_file
    importer = OutlookImporter.new
    importer.read(File.new('livemail_de.csv'))
    
    assert_equal importer.contacts.first, ["Robin Example", "robin@example.de"]
  end
  
  def test_initilize_raise_invalid_argument_error_if_lookup_not_satisfied
    assert_raise ArgumentError do
      importer = OutlookImporter.new(:firstname => '', :lastname => '', :email => '')
    end
  end
  
  def test_initialize_raises_invalid_argument_error_if_lookup_is_missing_a_value
    assert_raise ArgumentError do
      lookup = {:firstname => 'Vorname', :lastname => 'Nachname'}
      importer = OutlookImporter.new(lookup)
    end
  end
end