# novaix_govconnect

### How to set up the **`Novaix GovConnect Server`** application:

step 1:
— Clone the application from GitHub using the following command:
```git:
    git clone https://github.com/vindikaters-coders/novaix_govconnect.git
```

step 2:
— Locate the `govconnect-server` folder and Open project in your favorite IDE

step 3:
— Locate the `application.yml` file and update the database credentials
```database:
  url: jdbc:mysql://localhost:3306/govconnect?createDatabaseIfNotExist=true
  username: your_username
  password: your_password
```

step 4:
— Install the dependencies using maven

step 5:
— Locate the `GovConnectServerApplication` and run the application