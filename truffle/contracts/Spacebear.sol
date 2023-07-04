
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import '@ganache/console.log/console.sol';

//import "@openzeppelin/contracts/security/Pausable.sol";

contract Spacebear is ERC721, Ownable{
    
    uint public Counter;
    
    constructor() ERC721("Spacebear","SBR"){}

    function _baseURI() internal pure override returns (string memory){
        return "https://ipfs.io/ipfs/QmU1CNuwJZTxc6FZqKLsUPVjPrR1Fg2U79sNDYQozpBj7w/genesis/";
    }

    function buyToken() public payable {
        uint256 tokenId = Counter;
        console.log("got here:", tokenId, msg.value);
        require( msg.value == tokenId * 0.1 ether,"Wrong amount of funds sent" );
        Counter ++;
        _safeMint(msg.sender, tokenId);
    }


    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = Counter;
        Counter++;
        _safeMint(to, tokenId);
        
    }

    /* function _burn(uint256 tokenId) internal virtual  override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    } */

    function tokenURI(uint256 tokenId) public pure virtual override(ERC721) returns (string memory){
        return string(abi.encodePacked(_baseURI(),(tokenId+1),".json"));
    } 


}
