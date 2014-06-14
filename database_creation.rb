# require 'CSV'
# require 'sqlite3'

# For reference, below is how I created the Sox database 
# in sqlite3 from the CSV on baseball-reference. 

# db = SQLite3::Database.new "test.db"

# red_sox_array = CSV.read("historical_sox.csv")

# # convert CSV file to sqlite3 databse

# db.execute <<-SQL 
#   create table red_sox (
#     RK varchar(30),
#     YEAR varchar(30),
#     TM varchar(30),
#     LG varchar(30),
#     G varchar(30),
#     W varchar(30),
#     L varchar(30),
#     TIES varchar(30),
#     WLPCNT varchar(30),
#     PYTHWL varchar(30),
#     FINISH varchar(30),
#     GB varchar(30),
#     PLAYOFFS varchar(30),
#     R varchar(30),
#     RA varchar(30),
#     BATAGE varchar(30),
#     PAAGE varchar(30),
#     NUMBAT varchar(30),
#     P varchar(30),
#     TOPPLAYER varchar(30),
#     MANAGER varchar(30),
#     val varchar(30)
#   ); 
# #   SQL
 
# red_sox_array.delete_at(0)
# red_sox_array.each do |row|
#   db.execute("insert into red_sox values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", row)
# end