#Anthony Nguyen, Assignment 310.8
#The purpose of this assignment is to demonstrate 
#the basics of Python conectivity to SQL databases.

#required for sql python connection
import mysql.connector

#connecting to movies database on mysql
my_sql = mysql.connector.connect(
	host = "localhost",
	user = "root",
	password = "0verW@tch",
	database = "movies"
)

#establishing main cursor instance
cursor = my_sql.cursor()

#main print function: launch the instance of the database, with a different title each time
def show_films(cursor, title):
	cursor.execute("SELECT film_name AS Name, film_director AS Director, genre_name AS Genre, studio_name AS Studio FROM film INNER JOIN genre ON film.genre_id = genre.genre_id INNER JOIN studio ON film.studio_id = studio.studio_id;")
	
	films = cursor.fetchall()
	print("\n -- {} --".format(title))
	
	#formatting output
	for film in films:
		print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(film[0], film[1], film[2], film[3]))
	
#insert new record into films
def insertinto_films(cursor):
	cursor.execute("INSERT INTO film (film_id, film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id) VALUES (4, 'Freddy Got Fingered', 2001, 87, 'Tom Green', 1, 1)")

#changing an attribute in a record
def update_films(cursor):
	cursor.execute("UPDATE film SET genre_id = 1 WHERE film_name = 'Alien';")

#deleting a row
def delete_films(cursor):
	cursor.execute("DELETE FROM film WHERE film_name = 'Gladiator';")


#main bloc of code
show_films(cursor, "DISPLAYING FILMS")

insertinto_films(cursor)
show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

update_films(cursor)
show_films(cursor, "DISPLAYING FILMS AFTER UPDATE - Changed genre of Alien to Horror")

delete_films(cursor)
show_films(cursor, "DISPLAYING FILMS AFTER DELETE")

#saves changes in current transaction and close connection
my_sql.commit()
my_sql.close()