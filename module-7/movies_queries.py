#Anthony Nguyen, Assignment 310.7
#The purpose of this assignment is to demonstrate 
#the basics of Python conectivity to SQL databases.

#required for sql python connection
import mysql.connector

my_sql = mysql.connector.connect(
	host = "localhost",
	user = "root",
	password = "0verW@tch",
	database = "movies"
)

#gather data from studio table and display in easily readable format
cursor1 = my_sql.cursor()
cursor1.execute("SELECT * FROM studio")
squeal_1 = cursor1.fetchall()
print("----- DISPLAYING Studio Records -----")
for squeal in squeal_1:
	print("Studio ID: {}\nStudio Name: {}\n".format(squeal[0],squeal[1]))

#gather data from genre table and display in easily readable format
cursor2 = my_sql.cursor()
cursor2.execute("SELECT * FROM genre")
squeal_2 = cursor2.fetchall()
print("----- DISPLAYING Genres -----")
for squeal in squeal_2:
	print("Genre ID: {}\nGenre Name: {}\n".format(squeal[0],squeal[1]))

#gather data from film table with runtime under 120
cursor3 = my_sql.cursor()
cursor3.execute("SELECT film_name, film_runtime FROM film WHERE film_runtime < 120")
squeal_3 = cursor3.fetchall()
print("----- DISPLAYING Short Film Records -----")
for squeal in squeal_3:
	print("Film: {}\nRuntime: {}\n".format(squeal[0],squeal[1]))
	
#gather data from film table and display in order of director
cursor4 = my_sql.cursor()
cursor4.execute("SELECT film_name, film_director FROM film ORDER BY film_director")
squeal_4 = cursor4.fetchall()
print("----- DISPLAYING Directors in Alphabetical Order -----")
for squeal in squeal_4:
	print("Film: {}\nDirector: {}\n".format(squeal[0],squeal[1]))

#saves changes in current transaction and close connection
my_sql.commit()
my_sql.close()