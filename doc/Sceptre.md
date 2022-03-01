# Sceptre
Sceptre is a tool to drive [CloudFormation](https://aws.amazon.com/cloudformation/). Sceptre manages the creation, update and deletion of stacks while providing meta commands which allow users to retrieve information about their stacks. Sceptre is unopinionated, enterprise ready and designed to run as part of CI/CD pipelines. Sceptre is accessible as a CLI tool or as a Python module.

## Sceptre variables/resolvers used in this solution

* **sceptre_user_data**
	* Sceptre user data **allows users to store arbitrary key-value pairs in their <stack-name>.**  **yaml file**. This data is then passed as a Python dict to the sceptre_handler(sceptre_user_data) function in Python templates.

* **stack_ouput_external**
  * Fetches the value of an output from a different Stack in the same account and region. You can specify a optional AWS profile to connect to a different account/region.

  * If the Stack whose output is being fetched is in the same StackGroup, the basename of that Stack can be used
  
## Jinja Templating

All the stacks are created using Jinja2. 
Refer [Jinja3](https://jinja.palletsprojects.com/en/3.0.x/) for more information
