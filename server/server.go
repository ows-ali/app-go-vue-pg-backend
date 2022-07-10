package main

import (
   "database/sql"
   "fmt"
   "math"
   "log"
   "os"
   _ "github.com/lib/pq" 
   "github.com/jinzhu/gorm"

   "github.com/gofiber/fiber/v2"
   "github.com/gofiber/fiber/v2/middleware/cors"

)


type Order struct {
	gorm.Model
	Id  int `json:"id"`
	CustomerName string    `json:"customer_name"`
	CustomerCompany string    `json:"company_name"`
    OrderName string    `json:"order_name"`
	CreatedAt string `json:"created_at"`
    TotalAmount float64 `json:"total_amount"`
	DeliveredAmount float64    `json:"delivered_amount"`


}

func indexOrderHandler(c *fiber.Ctx, db *sql.DB ) error {
    var str = ""
    var offset = "0" 
    // str := 
    // offset := c.Query("offset")
    
    // fmt.Println(c.Query("order_name"))
    if (c.Query("order_name") != "") {
        str = c.Query("order_name")
    }
    if (c.Query("offset") != "") {
        offset = c.Query("offset")
    }
    rows, err := db.Query(`    SELECT o.id, 
       customers.name as customer_name,
       cc.company_name,
       o.order_name,
       to_char(o.created_at::timestamp AT TIME ZONE 'Australia/Melbourne', 'Mon dd, yyyy HH12:MI AM'),

       
       sum(oi.quantity*oi.price_per_unit) as total_amount,

       (select sum(d.delivered_quantity*oi2.price_per_unit) from deliveries d join order_items oi2 on d.order_item_id = oi2.id where oi2.order_id = o.id) as delivered_amount

        FROM orders o 
        LEFT JOIN customers 
        ON o.customer_id = customers.login
        LEFT JOIN customer_companies cc
        ON cc.company_id = customers.company_id
        LEFT JOIN order_items oi
        ON oi.order_id = o.id
        Left join deliveries d 
        on d.order_item_id  = oi.id
        where o.order_name like '%`+str+`%'
        GROUP BY o.id,customers.name, cc.company_name
        order by o.order_name
        limit 10 offset $1`,offset)
    defer rows.Close()
    if err != nil {
        log.Fatalln(err)
        c.JSON("An error occured")
    }

 
    var orders []Order

    // Foreach movie
    for rows.Next() {
        var id int
        var created_at string
        var order_name string
        var customer_name string
        var company_name string
        var total_amount float64
        var delivered_amount float64

         rows.Scan(&id, &customer_name, &company_name, &order_name, &created_at, &total_amount, &delivered_amount)

        // fmt.Println(customer_name)

        orders = append(orders, Order{Id: id, CreatedAt: created_at, OrderName: order_name, CustomerName: customer_name, CustomerCompany: company_name, TotalAmount: math.Round(float64(total_amount)*1000)/1000, DeliveredAmount: math.Round(float64(delivered_amount)*1000)/1000 })
    }
    return c.JSON(orders)

    // var respo
}


func main() {
   
   connStr := "postgres://vfieojtfkhivkj:53dc1f1348bd02692c998793eb4a8cadf17ba2617a4419023e31e2e396dbcffc@ec2-54-227-248-71.compute-1.amazonaws.com:5432/d7ioq39s06i2qh"

      // Connect to database
   db, err := sql.Open("postgres", connStr)
   if err != nil {
       log.Fatal(err)
   }

    //    engine := html.New("./views", ".html")
    //    app := fiber.New(fiber.Config{
    //        Views: engine,
    //    })
   app := fiber.New()
   app.Use(cors.New())

    //    app.Get("/", func(c *fiber.Ctx) error {
    //       return indexHandler(c, db)
    //   })


   app.Get("/orders", func(c *fiber.Ctx) error {
      return indexOrderHandler(c, db)
   })

  port := os.Getenv("PORT")
  if port == "" {
      port = "3000"
  }

  app.Static("/", "./public") // add this before starting the app
  log.Fatalln(app.Listen(fmt.Sprintf(":%v", port)))
   
   // log.Fatalln(app.Listen(fmt.Sprintf(":%v", port)))
}
