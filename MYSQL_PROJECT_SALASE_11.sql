-- Table 1: Need to write down query and full fill the below requirement 
-- [	Category	Yesterday Orders	Yesterday GMV	Yesterday Revenue	
-- Yesterday Customers	Yesterday New Customers	MTD Orders	MTD Orders Growth	MTD GMV	MTD GMV Growth	MTD Revenue	MTD Revenue Growth	MTD Customers
-- MTD Customers Growth	MTD New Customers	MTD New Customers Growth	LMTD Orders	LMTD GMV	LMTD Revenue	LMTD Customers	LMTD New Customers	
-- LM Orders	LM GMV	LM Revenue	LM Customers	LM New Customers]			


SELECT y.category,

COUNT(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 DAY,'%Y-%M')THEN X.order_id ELSE NULL END) AS YESTERDAY_ORDERS,

SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 DAY,'%Y-%M') THEN X.selling_price ELSE NULL END) AS YESTERDAY_GMV,

SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 DAY, '%Y-%M')THEN X.selling_price/1.18 ELSE NULL END) AS YESTERDAY_REVENUE,

COUNT(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 DAY,'%Y-%M') THEN X.customer_id ELSE NULL END) AS YESTERDAY_CUSTOMER,

COUNT(DISTINCT CASE WHEN DATE(order_date)= DATE(CURRENT_DATE - INTERVAL 1 DAY)THEN X.customer_id ELSE NULL END) AS YESTERDAY_NEW_CUSTOMER,

COUNT(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')=DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.order_id ELSE NULL END) AS MTD_ORDERS,


  COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M')THEN X.order_id ELSE NULL END)
  -
  COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%Y-%M')THEN X.order_id ELSE null
   END ) AS MTD_ORDER_GROWTH,

  SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.selling_price ELSE NULL END) AS MTD_GMV,
  SUM(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.selling_price ELSE NULL END) 
  -
  SUM(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M')THEN X.selling_price ELSE NULL END)
  AS MTD_GMV_GROWTH,
  

   SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.selling_price/1.18 ELSE NULL END) AS MTD_REVENUE,

   SUM(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE , '%Y-%M')THEN X.selling_price/1.18 ELSE NULL END)
   -
   SUM(DISTINCT CASE WHEN  DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%M')THEN X.selling_price/1.18 ELSE null
   END) AS MTD_REVENUE_GROWTH,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%M') = DATE_FORMAT(CURRENT_DATE, '%Y-%M') THEN X.customer_id ELSE NULL END) AS MTD_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE, '%Y-%m')THEN X.customer_id ELSE NULL END) 
- 
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m')THEN X.customer_id ELSE NULL

    END) AS MTD_Customer_Growth,

   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.customer_id ELSE 'NULL_1' END) AS MTD_NEW_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE, '%Y-%m')THEN X.customer_id ELSE NULL
    END) - 
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m')THEN X.customer_id ELSE NULL
    END) AS MTD_New_Customer_Growth,
   
   count(CASE WHEN month(x.order_date) >= DATE_FORMAT(curdate() - INTERVAL 1 MONTH, '%Y-%m-01')
   AND order_date <= LAST_DAY(curdate())THEN order_id ELSE 0 END) AS lmtd_order,
   
   sum(case when date_format(order_date ,'%y-%m') = date_format(current_date - interval 1 month , '%y-%m') and order_date <= last_day(current_date - interval 1 month) then x.selling_price 
   else 0 end ) as LMTD_GMV,
   
   SUM(CASE WHEN DATE_FORMAT(order_date,'%y-%m') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%y-%m') AND order_date <= LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) THEN X.selling_price/1.18
   ELSE 0 END ) AS LMTD_REVENUE,
   
   COUNT(CASE WHEN date_format(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%Y-%M')and order_date <= LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) THEN x.customer_id
   ELSE 0 END) AS LMTD_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%Y-%M')AND ORDER_DATE <= LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH ) THEN X.customer_id
   ELSE 0 END) AS NEW_LMTD_CUSTOMER,
   
   COUNT(case when DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M') THEN X.order_id ELSE 0 END) AS LM_ORDERS,
   
   SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE -  INTERVAL 1 MONTH , '%Y-%M') THEN X.selling_price ELSE 0 END) AS LM_GMV,
   
   SUM(CASE WHEN DATE_FORMAT(ORDER_DATE,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M')THEN X.selling_price/1.18 ELSE 0 END) AS LM_REVENUE,
   
   COUNT(CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M') THEN X.customer_id ELSE 0 END) AS LM_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%M') THEN X.customer_id ELSE 0 END) AS 
   LM_NEW_CUSTOMER
   
 from order_details_v1 as x
 join producthierarchy as y
 on x.product_id = y.product_id
 group by y.category;
 
 
 
 -- Table 2: Need to write down query and full fill the below requirement 
-- [PRODUCT_ID,PRODUCT_NAME,	Category	Yesterday Orders	Yesterday GMV	Yesterday Revenue	
-- Yesterday Customers	Yesterday New Customers	MTD Orders	MTD Orders Growth	MTD GMV	MTD GMV Growth	MTD Revenue	MTD Revenue Growth	MTD Customers
-- MTD Customers Growth	MTD New Customers	MTD New Customers Growth	LMTD Orders	LMTD GMV	LMTD Revenue	LMTD Customers	LMTD New Customers	
-- LM Orders	LM GMV	LM Revenue	LM Customers	LM New Customers]
 
 

 
 
select y.product_id,y.product AS product_name,y.category,

count(case when date_format(x.order_date,'%y-%m')= date_format(current_date - interval 1 day , '%y-%m')then x.order_id else null end) as YESTERDAY_ORDERS,
SUM(case when date_format(x.order_date,'%y-%m')= date_format(current_date - interval 1 day,'%y-%m')then x.selling_price else null end ) as YESTERDAY_GMV,
SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 DAY, '%Y-%M')THEN X.selling_price/1.18 ELSE NULL END) AS YESTERDAY_REVENUE,

COUNT(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 DAY,'%Y-%M') THEN X.customer_id ELSE NULL END) AS YESTERDAY_CUSTOMER,

COUNT(DISTINCT CASE WHEN DATE(order_date)= DATE(CURRENT_DATE - INTERVAL 1 DAY)THEN X.customer_id ELSE NULL END) AS YESTERDAY_NEW_CUSTOMER,

COUNT(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')=DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.order_id ELSE NULL END) AS MTD_ORDERS,


  COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M')THEN X.order_id ELSE NULL END)
  -
  COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%Y-%M')THEN X.order_id ELSE null
   END ) AS MTD_ORDER_GROWTH,

  SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.selling_price ELSE NULL END) AS MTD_GMV,
  SUM(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.selling_price ELSE NULL END) 
  -
  SUM(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M')THEN X.selling_price ELSE NULL END)
  AS MTD_GMV_GROWTH,
  

   SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.selling_price/1.18 ELSE NULL END) AS MTD_REVENUE,

   SUM(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE , '%Y-%M')THEN X.selling_price/1.18 ELSE NULL END)
   -
   SUM(DISTINCT CASE WHEN  DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%M')THEN X.selling_price/1.18 ELSE null
   END) AS MTD_REVENUE_GROWTH,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%M') = DATE_FORMAT(CURRENT_DATE, '%Y-%M') THEN X.customer_id ELSE NULL END) AS MTD_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE, '%Y-%m')THEN X.customer_id ELSE NULL END) 
- 
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m')THEN X.customer_id ELSE NULL

    END) AS MTD_Customer_Growth,

   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.customer_id ELSE 'NULL_1' END) AS MTD_NEW_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE, '%Y-%m')THEN X.customer_id ELSE NULL
    END) - 
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m')THEN X.customer_id ELSE NULL
    END) AS MTD_New_Customer_Growth,
   
   count(CASE WHEN month(x.order_date) >= DATE_FORMAT(curdate() - INTERVAL 1 MONTH, '%Y-%m-01')
   AND order_date <= LAST_DAY(curdate())THEN order_id ELSE 0 END) AS lmtd_order,
   
   sum(case when date_format(order_date ,'%y-%m') = date_format(current_date - interval 1 month , '%y-%m') and order_date <= last_day(current_date - interval 1 month) then x.selling_price 
   else 0 end ) as LMTD_GMV,
   
   SUM(CASE WHEN DATE_FORMAT(order_date,'%y-%m') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%y-%m') AND order_date <= LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) THEN X.selling_price/1.18
   ELSE 0 END ) AS LMTD_REVENUE,
   
   COUNT(CASE WHEN date_format(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%Y-%M')and order_date <= LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) THEN x.customer_id
   ELSE 0 END) AS LMTD_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%Y-%M')AND ORDER_DATE <= LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH ) THEN X.customer_id
   ELSE 0 END) AS NEW_LMTD_CUSTOMER,
   
   COUNT(case when DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M') THEN X.order_id ELSE 0 END) AS LM_ORDERS,
   
   SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE -  INTERVAL 1 MONTH , '%Y-%M') THEN X.selling_price ELSE 0 END) AS LM_GMV,
   
   SUM(CASE WHEN DATE_FORMAT(ORDER_DATE,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M')THEN X.selling_price/1.18 ELSE 0 END) AS LM_REVENUE,
   
   COUNT(CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M') THEN X.customer_id ELSE 0 END) AS LM_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%M') THEN X.customer_id ELSE 0 END) AS 
   LM_NEW_CUSTOMER


from order_details_v1 as x
join producthierarchy as y
on x.product_id = y.product_id
group by  y.product_id,y.product,y.category;


-- Table 3: Need to write down query and full fill the below requirement 
-- [	CITY,	Yesterday Orders	Yesterday GMV	Yesterday Revenue	
-- Yesterday Customers	Yesterday New Customers	MTD Orders	MTD Orders Growth	MTD GMV	MTD GMV Growth	MTD Revenue	MTD Revenue Growth	MTD Customers
-- MTD Customers Growth	MTD New Customers	MTD New Customers Growth	LMTD Orders	LMTD GMV	LMTD Revenue	LMTD Customers	LMTD New Customers	
-- LM Orders	LM GMV	LM Revenue	LM Customers	LM New Customers]

select y.city,

count(case when date_format(x.order_date,'%y-%m')= date_format(current_date - interval 1 day , '%y-%m')then x.order_id else null end) as yesterday_order,
SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 DAY,'%Y-%M') THEN X.selling_price ELSE NULL END) AS YESTERDAY_GMV,

SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 DAY, '%Y-%M')THEN X.selling_price/1.18 ELSE NULL END) AS YESTERDAY_REVENUE,

COUNT(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 DAY,'%Y-%M') THEN X.customer_id ELSE NULL END) AS YESTERDAY_CUSTOMER,

COUNT(DISTINCT CASE WHEN DATE(order_date)= DATE(CURRENT_DATE - INTERVAL 1 DAY)THEN X.customer_id ELSE NULL END) AS YESTERDAY_NEW_CUSTOMER,

COUNT(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')=DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.order_id ELSE NULL END) AS MTD_ORDERS,


  COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M')THEN X.order_id ELSE NULL END)
  -
  COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%Y-%M')THEN X.order_id ELSE null
   END ) AS MTD_ORDER_GROWTH,

  SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.selling_price ELSE NULL END) AS MTD_GMV,
  SUM(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.selling_price ELSE NULL END) 
  -
  SUM(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M')THEN X.selling_price ELSE NULL END)
  AS MTD_GMV_GROWTH,
  

   SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.selling_price/1.18 ELSE NULL END) AS MTD_REVENUE,

   SUM(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE , '%Y-%M')THEN X.selling_price/1.18 ELSE NULL END)
   -
   SUM(DISTINCT CASE WHEN  DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%M')THEN X.selling_price/1.18 ELSE null
   END) AS MTD_REVENUE_GROWTH,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%M') = DATE_FORMAT(CURRENT_DATE, '%Y-%M') THEN X.customer_id ELSE NULL END) AS MTD_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE, '%Y-%m')THEN X.customer_id ELSE NULL END) 
- 
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m')THEN X.customer_id ELSE NULL

    END) AS MTD_Customer_Growth,

   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE,'%Y-%M') THEN X.customer_id ELSE 'NULL_1' END) AS MTD_NEW_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE, '%Y-%m')THEN X.customer_id ELSE NULL
    END) - 
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date, '%Y-%m') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m')THEN X.customer_id ELSE NULL
    END) AS MTD_New_Customer_Growth,
   
   count(CASE WHEN month(x.order_date) >= DATE_FORMAT(curdate() - INTERVAL 1 MONTH, '%Y-%m-01')
   AND order_date <= LAST_DAY(curdate())THEN order_id ELSE 0 END) AS lmtd_order,
   
   sum(case when date_format(order_date ,'%y-%m') = date_format(current_date - interval 1 month , '%y-%m') and order_date <= last_day(current_date - interval 1 month) then x.selling_price 
   else 0 end ) as LMTD_GMV,
   
   SUM(CASE WHEN DATE_FORMAT(order_date,'%y-%m') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%y-%m') AND order_date <= LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) THEN X.selling_price/1.18
   ELSE 0 END ) AS LMTD_REVENUE,
   
   COUNT(CASE WHEN date_format(order_date,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%Y-%M')and order_date <= LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH) THEN x.customer_id
   ELSE 0 END) AS LMTD_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH , '%Y-%M')AND ORDER_DATE <= LAST_DAY(CURRENT_DATE - INTERVAL 1 MONTH ) THEN X.customer_id
   ELSE 0 END) AS NEW_LMTD_CUSTOMER,
   
   COUNT(case when DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M') THEN X.order_id ELSE 0 END) AS LM_ORDERS,
   
   SUM(CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE -  INTERVAL 1 MONTH , '%Y-%M') THEN X.selling_price ELSE 0 END) AS LM_GMV,
   
   SUM(CASE WHEN DATE_FORMAT(ORDER_DATE,'%Y-%M')= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M')THEN X.selling_price/1.18 ELSE 0 END) AS LM_REVENUE,
   
   COUNT(CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH,'%Y-%M') THEN X.customer_id ELSE 0 END) AS LM_CUSTOMER,
   
   COUNT(DISTINCT CASE WHEN DATE_FORMAT(order_date,'%Y-%M') = DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%M') THEN X.customer_id ELSE 0 END) AS 
   LM_NEW_CUSTOMER

from order_details_v1 as x
join store_cities_1 as y
on x.store_id = y.store_id
group by y.city;


 
 
 


 





 
 

 
 
 
 








    
