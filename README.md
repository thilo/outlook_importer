# Outlook CSV Importer

Can read csv contacts files exported by Outlook > 2000 and Windows Live Mail and return the contacts as a nested array.


# USAGE

Initialize the importer with a lookup table that specifies which strings in the csv headers match either firstname, lastname and email or name and email. 

    lookup_table = {
      :name => 'Name',
      :email => 'E-Mail-Adresse'
    }
    importer = OutlookImporter.new(lookup_table)

After initialization let the importer read a file and you can access you contacts via the contacts method. 

    importer.read('example.csv')
    importer.contacts # => [["Robin Example", "robin@example.de"]]

For further reference please see the outlook importer test in this project.


# CREDITS
Payango GmbH for allowing us to open source this lib.
Robin Mehner for sharing the Outlook CSV test files.
Frank Prößdorf
Thilo Utke

# LICENSE

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
Version 2, December 2004
 
Copyright (C) 2004 Sam Hocevar
14 rue de Plaisance, 75014 Paris, France
Everyone is permitted to copy and distribute verbatim or modified copies of this license document, and changing it is allowed as long as the name is changed.

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
0. You just DO WHAT THE FUCK YOU WANT TO.
