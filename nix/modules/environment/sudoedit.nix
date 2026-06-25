{ config, ... }:

{
    # sudoedit usa micro, y arregla que el tema a nivel de usuario 
    # se aplique en root
  	environment.variables.EDITOR = "micro";
	  environment.variables.VISUAL = "micro";
}
