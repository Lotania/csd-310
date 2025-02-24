#Jason Luttrell 11/30/24  CSD310-T301 Module 11.1

from tabulate import tabulate #to generate a table Documentation @ https://pypi.org/project/tabulate/
import dotenv # to use .env file
from dotenv import dotenv_values
import mysql.connector # to connect
    
def main():

    #using our .env file
    secrets = dotenv_values("c:/Users/User/csd/csd-310/module-11/.env")


    #database config dictionary
    config = {
        "user": secrets["USER"],
        "password": secrets["PASSWORD"],
        "host": secrets["HOST"],
        "database": secrets["DATABASE"],
        "raise_on_warnings": True #not in .env file
    }

    db = mysql.connector.connect(**config) # connect to the movies database 

    try:  #try/catch block for handling potential MySQL database errors

        db = mysql.connector.connect(**config) # connect to the movies database 
        
        # output the connection status 
        print("\n  Database user {} connected to MySQL on host {} with database {}".format(config["user"], config["host"], config["database"]))

        #create Cursor Object
        cursor = db.cursor()

        # Build first report query
        # This report gets a monthly delivery performance report
        showMonthlyDeliveryRpt(cursor)
        
        # Build second report query
        # This report gets a monthly delivery performance report
        showSupplierDeliveryRpt (cursor)
        
        # Build second report query
        # This report gets a monthly delivery performance report
        showDistributorWineOrdersRpt (cursor)




    except mysql.connector.Error as err:
        
        #if there is an error, then the handler notifies user and saves a log entry
       print("something has gone wrong with the file, Please contact tech support")
       with open('errorlog.txt','a') as errlog:
           errlog.write(err)


    finally:  
        db.close() #close the connection to MySQL

def showMonthlyDeliveryRpt (cursor):
    #This function generates a report on the Bachus database
    #that details a report that shows average supplier delivery performance
    #by month and year, against estimated delivery dates.

    #set string for report title
    title = 'Delivery Performance In Days by Month and Year'

    #Create a list of header labels
    header = ['Year', 'Month', 'Delivery Performance (days)']

    #Build report query
    stQry = "SELECT year(a.actual_delivery) as Year, " +\
                    "month(a.actual_delivery) as Month, "  +\
                    "Avg(datediff(a.expected_delivery,a.actual_delivery)) as 'Delivery Performance (days)' " +\
            "FROM supply_orders as a JOIN suppliers as b ON a.supplier_ID = b.supplier_id "  +\
            "GROUP BY Month, Year "  +\
            "ORDER BY Year, Month;"
            
    colWidth = [15,15,15] #Build Max Column Widths list
    colign = ['right', 'left', 'center'] #Build alignment list
            
    cursor.execute(stQry) #Execute Qry

    #Get results from the cursor object
    result = cursor.fetchall()
    
    print(f"\n  --  {title}  --\n") #print the Header

    #print the report table
    print(tabulate(result, headers=header,maxcolwidths=colWidth, colalign=colign, floatfmt='.0f'),'\n\n')
    
    
def showSupplierDeliveryRpt (cursor):
    #This function generates a report on the Bachus database
    #that details a report that shows average delivery performance
    #by supplier, against estimated delivery dates.

    #set string for report title
    title = 'Average Delivery Performance In Days by Supplier'

    #Create a list of header labels
    header = ['Supplier', 'Delivery Performance \n(days)']

    #Build report query
    stQry = "SELECT b.supplier_name as Supplier, " +\
            "Avg(datediff(a.expected_delivery,a.actual_delivery)) as 'Delivery Performance (days)' " +\
            "FROM   supply_orders as a JOIN suppliers as b ON a.supplier_ID = b.supplier_id " +\
            "GROUP BY supplier_name " +\
            "ORDER BY 'Delivery Performance (days)'"

            
    colWidth = [15,15] #Build Max Column Widths list
    colign = ['right', 'center'] #Build alignment list
            
    cursor.execute(stQry) #Execute Qry

    #Get results from the cursor object
    result = cursor.fetchall()
    
    print(f"\n  --  {title}  --\n") #print the Header

    #print the report table
    print(tabulate(result, headers=header,maxcolwidths=colWidth, colalign=colign, floatfmt='.0f'),'\n\n')

def showDistributorWineOrdersRpt (cursor):
    #This function generates a report on the Bachus database
    #that shows number of cases of wine types ordered by each
    #Distributor.

    #set string for report title
    title = 'Number of Cases of Wine Type Ordered by Distributor'

    #Create a list of header labels
    header = ['Supplier', 'Wine Type', 'Delivery Performance \n(days)']

    #Build report query
    stQry = "SELECT 	b.distributor_name as Distributor, " +\
		        "d.wine_name as Wine, " +\
                "SUM(a.qty) 'Cases Ordered' " +\
            "FROM distributor_orders as a " +\
	            "JOIN distributor as b ON a.distributor_ID = b.distributor_ID " +\
                "JOIN batches as c ON a.batch_ID = c.batch_ID " +\
                "JOIN wines as d ON c.wine_ID = d.wine_ID " +\
            "GROUP BY Distributor, Wine;"

    
    colWidth = [25,15,15] #Build Max Column Widths list
    colign = ['right', 'left', 'center'] #Build alignment list
            
    cursor.execute(stQry) #Execute Qry

    #Get results from the cursor object
    result = cursor.fetchall()
    
    print(f"\n  --  {title}  --\n") #print the Header

    #print the report table
    print(tabulate(result, headers=header,maxcolwidths=colWidth, colalign=colign),'\n\n')

if __name__ == '__main__':
    main()