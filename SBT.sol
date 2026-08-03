// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

// این کدِ فلت شده است، کافیست در ریمیکس کپی کنید تا دیگر ارورِ اینپورت نگیرید
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/access/Ownable.sol";

contract SecondIdentity is ERC721, Ownable {
    uint256 private _nextTokenId;

    // نامِ جدید برای تمایز با قرارداد اول
    constructor() ERC721("Second Builder Identity", "SBID") Ownable(msg.sender) {}

    function mintIdentity() public {
        uint256 tokenId = _nextTokenId;
        _nextTokenId++;
        _safeMint(msg.sender, tokenId);
    }

    // این تابع باعث می‌شود توکنِ شما غیرقابل انتقال (SBT) باقی بماند
    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721)
        returns (address)
    {
        address previousOwner = super._update(to, tokenId, auth);
        require(previousOwner == address(0), "SBT: Non-transferable");
        return previousOwner;
    }
}
