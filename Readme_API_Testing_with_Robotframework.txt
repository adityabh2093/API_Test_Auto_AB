API Testing with Robotframework

1.Project Structure
	API_Test_Auto_AB[workspace folder]
		- API Automation Project
			- Resources
				- JSON 		[api request body]
				- TestData	[Property Files]
			    - All resources files
			- Testcases
				- All Test suites
			- Utils
				- Global_Resources
					- All Common files which are use in project
				- PythonLibarary
					- ALl Internal library

		- docker 
			- Scripts
			- Dockerfile
		- Drivers	
			- All Required Drivers 


Note :- In config File you need to mentioned your apikey,apiReadAccessToken,Uname and pass if required else cases will run on default parameters 