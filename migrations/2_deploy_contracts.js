var Paymaster=artifacts.require('NaivePaymaster');
var mainContract=artifacts.require('TrackRewarder');
var ERC20=artifacts.require('ALTOSTREAM');
module.exports=function(deployer){
    deployer.deploy(Paymaster);
    deployer.deploy(ERC20).then(function(){
        return deployer.deploy(mainContract, ERC20.address,'0xcC87aa60a6457D9606995C4E7E9c38A2b627Da88')
    });
    
        
    
};