// SPDX-Licenses-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 */
 contract artisteData {
     //songs by artiste
     struct Songs {
         bytes32 song;
         bytes32 credentialKey;
     }
     
    // artiste info struct     
     struct artisteCredential {
         uint256 artisteId;
         bytes32 songTitle;
         uint256 numberOfAlbums;
         bytes32 albumName;
     }
     //mapping of songs to an artiste
     mapping(address => Songs) artisteSongs;
     
     //song link with the artisteCredential
     mapping(bytes32 => artisteCredential) artisteInfo;
     
     
     event artisteLog(uint256 artisteId,bytes32 songTitle,uint256 numberOfAlbums,bytes32 albumName);
     
     function uploadSong(bytes32 song) external {
         address user = msg.sender;
        
            //bytes carries link of the user and the song
         bytes32 _credentialKey = bytes32(keccak256(abi.encode(user,song)));
          Songs memory songs = Songs(song,_credentialKey);
         artisteSongs[user] = songs;
     }
     function addCredentials(uint256 artisteId,bytes32 songTitle,uint256  numberOfAlbums, bytes32 albumName) external {
         address user = msg.sender;
         Songs memory songs = artisteSongs[user];
         bytes32 access = songs.credentialKey;
         artisteCredential memory _aC = artisteCredential(artisteId,songTitle,numberOfAlbums,albumName);
         artisteInfo[access] = _aC;
         emit artisteLog(artisteId,songTitle,numberOfAlbums,albumName);
     }
     
     ///a test to get song title
     function getSongTitle(bytes32 access) external view returns(bytes32) {
         artisteCredential memory _aC = artisteInfo[access];
         return _aC.songTitle;
     }
     
     //to get the access key of the artiste
     function getAccessKey() external view returns(bytes32) {
         address user = msg.sender;
         Songs memory songs = artisteSongs[user];
         return songs.credentialKey;
     }
     
     //a test to convert song name to bytes32
     function convertTobyte(string memory _word) external view returns(bytes32 convert){
        convert = bytes32(keccak256(abi.encode(_word)));         
     }
 }
