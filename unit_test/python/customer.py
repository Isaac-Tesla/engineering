#!/usr/bin/python


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
   customer = Customer()
   cust_name = 'Isaac'
   print('A customer has been added with id ', customer.set_name(f'{cust_name}'))
   print('The customer associated with id 0 is ', customer.get_name(0))