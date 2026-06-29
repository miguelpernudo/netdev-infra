{ config, ... }:

{
    # sudoedit uses micro, and ensures the user-level theme
    # is applied when running as root
  	environment.variables.EDITOR = "micro";
	  environment.variables.VISUAL = "micro";
}
