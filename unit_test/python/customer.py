#!/usr/bin/python

import logging
import logging.config
from datetime import datetime


class Customer:
   name = []

   def set_name(self, customer_name):
      self.name.append(customer_name)
      return len(self.name) - 1

   def get_name(self, customer_id):
      if customer_id >= len(self.name):
         return 'There is no such customer'
      else:
         return self.name[customer_id]


if __name__ == '__main__':

   now = datetime.now()
   date_time = now.strftime("%Y_%m_%d_%H_%M_%S")
   logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO, filename=f"log_{date_time}.log")

   customer = Customer()
   cust_name = 'Isaac'
   logging.info('Customer added, id = ', customer.set_name(f'{cust_name}'))
   logging.info('Customer with id 0 is ', customer.get_name(0))