
import unittest
import os
from appium import webdriver
from time  import sleep


class  appiumSimpleTezt (unittest.TestCase):

	def  setUp(self):
		app = os.path.abspath('./appiumSimpleDemo.app')

		self.driver = webdriver.Remote(
			command_executor = 'http://127.0.0.1:4723/wd/hub',
			desired_capabilities = {
				'app':app,
				'platformName': 'iOS',
				'platformVersion': '10.2.1',
				'deviceName': 'iPhone',
				'bundleId': 'com.cvte.appiumSimpleDemo',
                'udid': '93648e22b68d18dd4009cd4332ad05a1239f26aa' #Qian
#                'udid': '68f73cf8b7676dd695ff9937a90e858069f4b4f7' #tangjiahan
#                'udid': '225b371380b4d26fda07676adca80b5c9bdb42f6'  #gaohaibin
			}
			)

	def test_push_view(self):
		


		next_view_button = self.driver.find_element_by_accessibility_id("entry next view")
		next_view_button.click()

		sleep(2)

		back_view_button = self.driver.find_element_by_accessibility_id("Back")
		back_view_button.click()

	def tearDown(self):
		sleep(1)
		# self.driver.quit()

if __name__ == '__main__':
	suite = unittest.TestLoader().loadTestsFromTestCase(appiumSimpleTezt)
	unittest.TextTestRunner(verbosity=2).run(suite)
