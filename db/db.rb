require 'sequel'
require_relative '../config/config'

DB = Sequel.connect Config[:db]
