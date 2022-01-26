#!/usr/bin/python


import unittest
import customer
import logging
import logging.config
from datetime import datetime


class TestCustomer(unittest.TestCase):
    """
    Summary: A unit test for the customer class. 

    """
    customer = customer.Customer()
    customer_id = []
    customer_name = []

    def test_set_name(self):
        logging.info("Start test_set_name\n")
        """
        Summary: The test gets the customer_id from the 
            function and checks if it is NULL (fails 
            test). The customer_ids are stored in a list.

        """
        for i in range(4):
            name = 'name' + str(i)
            self.customer_name.append(name)
            customer_id = self.customer.set_name(name)
            self.assertIsNotNone(customer_id)
            self.customer_id.append(customer_id)
        logging.info("customer_id length = ", len(self.customer_id), self.customer_id, "customer_name length = ", len(self.customer_name), self.customer_name)
        logging.info("\nFinished test_set_name\n")


    def test_get_name(self):
        logging.info("\nStart test_get_name\n")
        """
        Summary: The test checks the customer.get_name function by
            collecting the total number of stored customers, then
            verifying the returned name.
        
        """
        length = len(self.customer_id)
        logging.info("customer_id length = ", length, "customer_name length = ", len(self.customer_name))
        for i in range(6):
            if i < length:
                self.assertEqual(self.customer_name[i], self.customer.get_name(self.customer_id[i]))
            else:
                logging.info("Testing for get_name no customer test")
                self.assertEqual('There is no such customer', self.customer.get_name(i))
        logging.info("\nFinished test_get_name\n")



if __name__ == '__main__':

    now = datetime.now()
    date_time = now.strftime("%Y_%m_%d_%H_%M_%S")
    logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO, filename=f"log_{date_time}.log")

    unittest.main()