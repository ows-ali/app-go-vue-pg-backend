# go-vue-pg-app-backend

This is the backend of a simple order application whose backend is built on Go, frontend is built on VueJs and database is postgres (from Heroku dyno).

The backend uses fiber (for GET api), pq (for db connection), gorm (for modeling) to create api. It runs a comprehensive query which joins tables and returns data grouped by each order with its customer and total amount data

The frontend uses vue-good-table with sorting and searching functionality to render the data

It has pagination implemented, can switch between two pages. 

It has order names, customer names, customer company names, total amount and total earned amount as per delivered quantities

We can also sort by order date, which is in AUS/Melbourne timezone (handled on postgres level)

We can also search by entering order name

## Repos

**Frontend**: https://github.com/ows-ali/app-go-vue-frontend/

**Backend**: https://github.com/ows-ali/app-go-vue-pg-backend

## Setup

You can clone the repos for backend and frontend.

The backend is already connected with postgres on cloud (via Heroku dyno) but if needed the database can be setup locally. 

(Optional)
Run the db queries given in populate_tables.sql given at the root of backend repo. It has queries to create tables as well as populate them afterwards.

For backend run: 
```
go run github.com/cosmtrek/air
```

And for frontend, run 
```
npm i
npm run dev
```
Server should run on port 3000
## App Screenshot

<img width="1380" alt="app screenshot" src="https://github.com/ows-ali/app-go-vue-frontend/blob/main/app%20screenshot.png">

