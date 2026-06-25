{ config, ... }:

{
	programs.git = {
    	enable = true;
    	settings = {
     		init.defaultBranch = "main";
        	pull.rebase        = false;
        	user.name  = "miguelpernudo";
        	user.email = "miguelfernandezpernudo@gmail.com";
	 	};
	 };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false; 

      settings = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_ed25519"; 
          identitiesOnly = true;
        };
      
        #"*" = {
        #};
      };
    };
  
    services.ssh-agent.enable = true;
	 
}
