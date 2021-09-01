// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
contract streamPayment {
  
  struct songInfo {
      bytes32 song;
      bytes32 songAccessKey;
  }
  
  struct streamInfo {
      uint256 time;
      uint256 numberOfStreams;
  }
  
   uint256  second = block.number + 3;
   uint256  count = 0;
  //mapping(address => userInfo) _userInfo;
  mapping(bytes32 => songInfo) _songInfo;
  mapping(bytes32 => streamInfo) _streamInfo;
  
  mapping(address=>uint256) usercount;
  mapping(address => uint256) userTime;
  
  // 2 register song name
  function songInput(bytes32 song) external {
      address user = msg.sender;
     bytes32 songAccessKey = keccak256(abi.encode(user,song));
     songInfo memory sI = songInfo(song,songAccessKey);
     _songInfo[song] = sI;
   }
  
  
  // 4 when a user streams a song function has to be avail 
   function streaming(bytes32 songAccessKey) external {
        usercount[msg.sender] = count;
        userTime[msg.sender] = second;
      if(userTime[msg.sender] <= block.number){
          uint256 newTime = second + 3;
          userTime[msg.sender] = newTime;
          streamInfo memory _stI = streamInfo(userTime[msg.sender], usercount[msg.sender]++);
         _streamInfo[songAccessKey] = _stI;
         
      }
   }
   
   // 5 returns number of streams
   function getNumberOfStreams(bytes32 songAccessKey) external view returns(uint256){
       streamInfo memory _stI = _streamInfo[songAccessKey];
       return _stI.numberOfStreams;
   }
   
   // 3 get the song access key(contains the user listening and song encrypt info)
   function getSongAccessKey(bytes32 song) external view returns(bytes32) {
       songInfo memory _sI = _songInfo[song];
       return _sI.songAccessKey;
   }
   
   //XXX 1 convert songname to byte
   function convertTobyte(string memory _songName) external view returns(bytes32 convert){
     convert = bytes32(keccak256(abi.encode(_songName)));         
    }
}