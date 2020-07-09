// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.6.2;

pragma experimental ABIEncoderV2;
//import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../node_modules/@opengsn/gsn/contracts/BaseRelayRecipient.sol";
import "../node_modules/@opengsn/gsn/contracts/interfaces/IKnowForwarderAddress.sol";

contract TrackRewarder is IKnowForwarderAddress,BaseRelayRecipient{


IERC20 private _token;
    address owner;
    uint _bal;

event trackAdded(address indexed uploader,bytes32 songMeta,uint now);
event payed(address indexed beneficiary, uint256 amountPayed);

constructor (IERC20 token,address _forwarder) public {
    owner = _msgSender();
    _token = token;
   trustedForwarder = _forwarder;
}


struct track{
bytes32 metadata;
address owner;
uint timeUploaded;
}

modifier onlyOwner{
    require(_msgSender() == owner, "you are not the owner");
        _;
}
//uint streams;  Taken care of in the backend
//ERC20 public tokenInterface;


struct Uploader{
    uint id;
    address _add;
    uint256 _votes;
}

address[] public uploaders;
bytes32[] public metadatas;

//mapping(uint=>Uploader) tokenBalance;
mapping(address=>Uploader) Uploaders;
mapping(address=>track) trackOwners;
mapping(bytes32=>track) TrackMetas;
mapping(address=>Uploader) voteCount;



//function addUploader(address _userAdd) public isOwner returns(address){
  //  Uploaders[_msgSe(nder()]._add=_userAdd;
    
//    uploaders.push(_msgSender());
 //   return _userAdd;
    
//}

function addTrack(address uploader) public returns(bytes32 meta){
    meta = (keccak256 (abi.encodePacked (now ,_msgSender())));
    trackOwners[_msgSender()].owner = uploader;
    TrackMetas[meta].metadata = meta;
    emit trackAdded (uploader,meta,now);
    metadatas.push(meta);
    return(meta);
   
}
    
    function redeem(address _artist,uint _amount) internal returns(bool){
        _token.transfer(_artist,_amount);
        
        
    }
    
    function checkBal() public view returns(uint){
        
        return _token.balanceOf(address(this));
    }
    
    function remAllowance(address tokenOwner) public view returns(uint256){
      return  _token.allowance(tokenOwner,address(this));
    }
    
    function pay(address _to,uint amount) external returns(uint) {
        redeem(_to,amount);
        emit payed(_to,amount);
    }
    
    function uploadVoteResult(uint votes,address _address) public onlyOwner {
    voteCount[_address]._votes = votes;
        
    }

  	function versionRecipient() external virtual view override returns (string memory) {
		return "1.0";
	}

    function getTrustedForwarder() public view override returns(address) {
		return trustedForwarder;
	}
    
}



