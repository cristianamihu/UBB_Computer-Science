I used the process of incremental development based on functionalities and test-driven development. I separated the user interface part from the rest of the application and implemented a procedural solution (several functions all in the same module), validation of input data, the program signals errors to the user. This application has an in-memory repository, so the data manipulated by the application is kept
only in the computer's memory and is not saved in a permanent database or other persistent storage system.

I created an application for the management of travel packages offered by a travel agency. The application stores travel packages offered to customers as follows: the start and end date of the trip, the
destination and the price.


The application allows:

   1. Addition
      
      • Add travel package
      
      • Modify travel package


   3. Deletion
      
      • Deleting all travel packages available for a given destination
      
      • Deleting all travel packages that have a shorter duration than a given number of days
      
      • Deleting all travel packages that have a price higher than a given amount


   5. Search
      
      • Printing travel packages with a given destination and with a price lower than a given amount


When you run the application, a menu appears in the console from which you can choose a functionality by entering the number indicated by the desired functionality in the command line.
