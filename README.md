# cars_django_app
Django app that uses GraphQl

How to get started: 
 1. Clone the project and install the following dependencies (the following are for linux):
 ```
 $ pip install django
 $ pip install graphene_django
 $ pip install virtualenv
 ```
 2. Source the dev.sh file
 ```  
 $ . dev.sh
 ```
 3. After sourcing the dev.sh file , build the vitual env by running the following command
 ```
 $ rebuild_virtualenv
 ```
 4. Run the server
 ```
 $ runserver
 ```
 5. Once your server is running head to http://127.0.0.1:8000/graphql/

 6. Type the following to make a query: 
    ```
    { allVehicles
      {
        id, name, 
        colour {
          name
        }
      }
    }
    ```

See basic tutorial here : https://docs.graphene-python.org/projects/django/en/latest/tutorial-plain/#
