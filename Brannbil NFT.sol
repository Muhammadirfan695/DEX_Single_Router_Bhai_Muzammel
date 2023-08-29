// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;
    function approve(address to, uint256 tokenId) external;
    function setApprovalForAll(address operator, bool _approved) external;
    function getApproved(uint256 tokenId) external view returns (address operator);
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
interface IERC721Metadata is IERC721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function tokenURI(uint256 tokenId) external view returns (string memory);
}
interface IERC721Enumerable is IERC721 {
    function totalSupply() external view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);
    function tokenByIndex(uint256 index) external view returns (uint256);
}
interface IERC20 {
    function transfer(address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 value) external returns (bool);
    function _approve(address owner, address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function totalSupply() external view returns (uint256);
    function balanceOf(address who) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
interface IPrice{
    function one$Wire () external view returns (uint256);
    function one$Lar () external view returns (uint256);
}
interface IPancakeRouter01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}
library Address {
    function isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}
library SafeMath {
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;
        return c;
    }
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
       if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "SafeMath: modulo by zero");
        return a % b;
    }
}
library Strings {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";
    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
    function toHexString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return toHexString(value, length);
    }
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }
}
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _transferOwnership(_msgSender());
    }

   
    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
abstract contract ERC165 is IERC165 {
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
      return interfaceId == type(IERC165).interfaceId;
    }
}
abstract contract Pausable is Context, Ownable {

    event Paused(address account);
    event Unpaused(address account);

    bool private _paused;

    constructor() {
        _paused = false;
    }

    function paused() public view virtual returns (bool) {
        return _paused;
    }

    modifier whenNotPaused() {
        require(!paused(), "Pausable: paused");
        _;
    }

    modifier whenPaused() {
        require(paused(), "Pausable: not paused");
        _;
    }

    function _pause() internal virtual whenNotPaused {
      _paused = true;
      emit Paused(_msgSender());
    }

    function _unpause() internal virtual whenPaused {
      _paused = false;
      emit Unpaused(_msgSender());
    }

    function pause() public virtual onlyOwner{
        _pause();
    }

    function unPause() public virtual onlyOwner{
        _unpause();
    }
}
contract ERC721A is
      Context,
      ERC165,
      IERC721,
      IERC721Metadata,
      IERC721Enumerable
      {
    using Address for address;
    using Strings for uint256;

    struct TokenOwnership {
      address addr;
      uint64 startTimestamp;
    }

    struct AddressData {
      uint128 balance;
      uint128 numberMinted;
    }

    uint256 internal currentIndex = 24;

    string private _name;

    string private _symbol;

    mapping(uint256 => TokenOwnership) private _ownerships;

    mapping(address => AddressData) private _addressData;

    mapping(uint256 => address) private _tokenApprovals;

    mapping(address => mapping(address => bool)) private _operatorApprovals;


    constructor(
      string memory name_,
      string memory symbol_
    ) {
      _name = name_;
      _symbol = symbol_;
    }

    function totalSupply() public view override returns (uint256) {
      return currentIndex -1;
    }

    function tokenByIndex(uint256 index) public view override returns (uint256) {
      require(index < totalSupply()+1, "ERC721A: global index out of bounds");
      return index;
    }

    function tokenOfOwnerByIndex(address owner, uint256 index)
      public
      view
      override
      returns (uint256)
    {
      require(index < balanceOf(owner), "ERC721A: owner index out of bounds");
      uint256 numMintedSoFar = totalSupply()+1;
      uint256 tokenIdsIdx = 0;
      address currOwnershipAddr = address(0);
      for (uint256 i = 0; i <numMintedSoFar; i++) {
        TokenOwnership memory ownership = _ownerships[i];
        if (ownership.addr != address(0)) {
          currOwnershipAddr = ownership.addr;
        }
        if (currOwnershipAddr == owner) {
          if (tokenIdsIdx == index) {
            return i;
          }
          tokenIdsIdx++;
        }
      }
      revert("ERC721A: unable to get token of owner by index");
    }

    function supportsInterface(bytes4 interfaceId)
      public
      view
      virtual
      override(ERC165, IERC165)
      returns (bool)
    {
      return
        interfaceId == type(IERC721).interfaceId ||
        interfaceId == type(IERC721Metadata).interfaceId ||
        interfaceId == type(IERC721Enumerable).interfaceId ||
        super.supportsInterface(interfaceId);
    }

    function balanceOf(address owner) public view override returns (uint256) {
      require(owner != address(0), "ERC721A: balance query for the zero address");
      return uint256(_addressData[owner].balance);
    }

    function _numberMinted(address owner) internal view returns (uint256) {
      require(
        owner != address(0),
        "ERC721A: number minted query for the zero address"
      );
      return uint256(_addressData[owner].numberMinted);
    }

    function ownershipOf(uint256 tokenId)
      internal
      view
      returns (TokenOwnership memory)
    {
      require(_exists(tokenId), "ERC721A: owner query for nonexistent token");

      uint256 lowestTokenToCheck;


      for (uint256 curr = tokenId; curr >= lowestTokenToCheck; curr--) {
        TokenOwnership memory ownership = _ownerships[curr];
        if (ownership.addr != address(0)) {
          return ownership;
        }
      }

      revert("ERC721A: unable to determine the owner of token");
    }

    function ownerOf(uint256 tokenId) public view override returns (address) {
      return ownershipOf(tokenId).addr;
    }

    function name() public view virtual override returns (string memory) {
      return _name;
    }

    function symbol() public view virtual override returns (string memory) {
      return _symbol;
    }

    function tokenURI(uint256 tokenId)
      public
      view
      virtual
      override
      returns (string memory)
    {
      require(
        _exists(tokenId),
        "ERC721Metadata: URI query for nonexistent token"
      );

      string memory baseURI = _baseURI();
      return
        bytes(baseURI).length > 0
          ? string(abi.encodePacked(baseURI, tokenId.toString()))
          : "";
    }

    function _baseURI() internal view virtual returns (string memory) {
      return "";
    }

    function approve(address to, uint256 tokenId) public override {
      address owner = ERC721A.ownerOf(tokenId);
      require(to != owner, "ERC721A: approval to current owner");

      require(
        _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
        "ERC721A: approve caller is not owner nor approved for all"
      );

      _approve(to, tokenId, owner);
    }

    function getApproved(uint256 tokenId) public view override returns (address) {
      require(_exists(tokenId), "ERC721A: approved query for nonexistent token");

      return _tokenApprovals[tokenId];
    }

    function setApprovalForAll(address operator, bool approved) public override {
      require(operator != _msgSender(), "ERC721A: approve to caller");

      _operatorApprovals[_msgSender()][operator] = approved;
      emit ApprovalForAll(_msgSender(), operator, approved);
    }

    function isApprovedForAll(address owner, address operator)
      public
      view
      virtual
      override
      returns (bool)
    {
      return _operatorApprovals[owner][operator];
    }

    function transferFrom(
      address from,
      address to,
      uint256 tokenId
    ) public override {
      _transfer(from, to, tokenId);
    }

    function safeTransferFrom(
      address from,
      address to,
      uint256 tokenId
    ) public override {
      safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom(
      address from,
      address to,
      uint256 tokenId,
      bytes memory _data
    ) public override {
      _transfer(from, to, tokenId);
      require(
        _checkOnERC721Received(from, to, tokenId, _data),
        "ERC721A: transfer to non ERC721Receiver implementer"
      );
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
      return tokenId < currentIndex;
    }


    function _safeMint(address to, uint256 quantity) internal {
      _safeMint(to, quantity, "");
    }

    function _safeMint(
      address to,
      uint256 quantity,
      bytes memory _data
    ) internal {
      uint256 startTokenId = currentIndex;
      require(to != address(0), "ERC721A: mint to the zero address");
      require(!_exists(startTokenId), "ERC721A: token already minted");

      _beforeTokenTransfers(address(0), to, startTokenId, quantity);

      AddressData memory addressData = _addressData[to];
      _addressData[to] = AddressData(
        addressData.balance + uint128(quantity),
        addressData.numberMinted + uint128(quantity)
      );
      _ownerships[startTokenId] = TokenOwnership(to, uint64(block.timestamp));

      uint256 updatedIndex = startTokenId;

      for (uint256 i = 1; i <=quantity; i++) {
        emit Transfer(address(0), to, updatedIndex);
        require(
          _checkOnERC721Received(address(0), to, updatedIndex, _data),
          "ERC721A: transfer to non ERC721Receiver implementer"
        );
        
        updatedIndex++;
        
      }

      currentIndex = updatedIndex;
      _afterTokenTransfers(address(0), to, startTokenId, quantity);
    }

    function _transfer(
      address from,
      address to,
      uint256 tokenId
    ) private {
      TokenOwnership memory prevOwnership = ownershipOf(tokenId);

      bool isApprovedOrOwner = (_msgSender() == prevOwnership.addr ||
        getApproved(tokenId) == _msgSender() ||
        isApprovedForAll(prevOwnership.addr, _msgSender()));

      require(
        isApprovedOrOwner,
        "ERC721A: transfer caller is not owner nor approved"
      );

      require(
        prevOwnership.addr == from,
        "ERC721A: transfer from incorrect owner"
      );
      require(to != address(0), "ERC721A: transfer to the zero address");

      _beforeTokenTransfers(from, to, tokenId, 1);

      _approve(address(0), tokenId, prevOwnership.addr);

      _addressData[from].balance -= 1;
      _addressData[to].balance += 1;
      _ownerships[tokenId] = TokenOwnership(to, uint64(block.timestamp));

      uint256 nextTokenId = tokenId + 1;
      if (_ownerships[nextTokenId].addr == address(0)) {
        if (_exists(nextTokenId)) {
          _ownerships[nextTokenId] = TokenOwnership(
            prevOwnership.addr,
            prevOwnership.startTimestamp
          );
        }
      }

      emit Transfer(from, to, tokenId);
      _afterTokenTransfers(from, to, tokenId, 1);
    }

    function _approve(
      address to,
      uint256 tokenId,
      address owner
    ) private {
      _tokenApprovals[tokenId] = to;
      emit Approval(owner, to, tokenId);
    }

    uint256 public nextOwnerToExplicitlySet = 0;

    function _setOwnersExplicit(uint256 quantity) internal {
      uint256 oldNextOwnerToSet = nextOwnerToExplicitlySet;
      require(quantity > 0, "quantity must be nonzero");
      uint256 endIndex = oldNextOwnerToSet + quantity - 1;
      require(_exists(endIndex), "not enough minted yet for this cleanup");
      for (uint256 i = oldNextOwnerToSet; i <= endIndex; i++) {
        if (_ownerships[i].addr == address(0)) {
          TokenOwnership memory ownership = ownershipOf(i);
          _ownerships[i] = TokenOwnership(
            ownership.addr,
            ownership.startTimestamp
          );
        }
      }
      nextOwnerToExplicitlySet = endIndex + 1;
    }

    function _checkOnERC721Received(
      address from,
      address to,
      uint256 tokenId,
      bytes memory _data
    ) private returns (bool) {
      if (to.isContract()) {
        try
          IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, _data)
        returns (bytes4 retval) {
          return retval == IERC721Receiver(to).onERC721Received.selector;
        } catch (bytes memory reason) {
          if (reason.length == 0) {
            revert("ERC721A: transfer to non ERC721Receiver implementer");
          } else {
            assembly {
              revert(add(32, reason), mload(reason))
            }
          }
        }
      } else {
        return true;
      }
    }
    
    function _beforeTokenTransfers(
      address from,
      address to,
      uint256 startTokenId,
      uint256 quantity
    ) internal virtual {}

    function _afterTokenTransfers(
      address from,
      address to,
      uint256 startTokenId,
      uint256 quantity
    ) internal virtual {}
}
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function _nonReentrantBefore() private {
        // On the first call to nonReentrant, _status will be _NOT_ENTERED
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;
    }

    function _nonReentrantAfter() private {
        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Returns true if the reentrancy guard is currently set to "entered", which indicates there is a
     * `nonReentrant` function in the call stack.
     */
    function _reentrancyGuardEntered() internal view returns (bool) {
        return _status == _ENTERED;
    }
}
contract BRANNBIL is ERC721A, Ownable, Pausable, ReentrancyGuard{
  
    using SafeMath for uint256;
    IPrice public Price;
    
    IPancakeRouter01 public Router;
    IERC20 public LAR;
    IERC20 public BUSD;
    IERC20 public WIRE;
    address public WETH;

    string public prefixURI="";
    string public baseExtension = "";

    uint256 public pool1;
    uint256 public pool2;
    uint256 public pool3;
    uint256 public pool4;
    uint256 public pool5;

    uint256 public PoolPercentage = 50;
    uint256 public count1;
    uint256 public count2;
    uint256 public count3;
    uint256 public count4;
    uint256 public count5;


    uint256 public SWAPTokenPercentage = 20;
    uint256 public SwapandLiquifyCount = 2;
    address public LpReceiver;
    address public BUSDReceiver;
    uint256 HalfToken;
    uint256 ContractBalance;
    uint256 public returnToken;


    constructor() 
    ERC721A("BRANNBIL NFT", "BRANNBIL")
    {
      WIRE = IERC20(0x3b3CD14d6D2fc39A68630582c2EB8ec98C21A81e);
      LAR = IERC20(0x052775Cf897b3eC894F26b8d801C514123c305D1); 
      BUSD = IERC20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);
      Router = IPancakeRouter01(0x10ED43C718714eb63d5aA57B78B54704E256024E);
      Price = IPrice(0x39fEE6E2182A72B390C9DB877b7Accd996Eb355F);
      LpReceiver = 0xB6DC6721Bc86120166128b5Fd56dF349Df85A993;
      BUSDReceiver = 0xB6DC6721Bc86120166128b5Fd56dF349Df85A993;
      WETH = Router.WETH();
    }


    uint256 price1   = 2500;
    uint256 price2_1 = 1250;
    uint256 price2_2 = 1250;
    uint256 price3   = 2000;
    uint256 price4   = 1250;
    uint256 price5_1 = 2000;
    uint256 price5_2 = 500;

    function getmintPay1Price(uint256 count) public view returns(uint256 token0){
        token0 = (price1.mul(1 ether)).mul(count);
    }

    function getmintPay2Price(uint256 count) public view returns(uint256 token0, uint256 token1){
        uint256 tokenPrice = Price.one$Lar();
        token0 = (price2_1.mul(1e18)).mul(count);
        token1 = (price2_2.mul(tokenPrice)).mul(count);
    }

    function getmintPay3Price(uint256 count) public view returns(uint256 token0){
        token0 = (price3.mul(1 ether)).mul(count);
    }

    function getmintPay4Price(uint256 count) public view returns(uint256 token0){
        token0 = (price4.mul(1 ether)).mul(count);
    }

    function getmintPay5Price(uint256 count) public view returns(uint256 token0, uint256 token1){
        uint256 tokenPrice = Price.one$Wire();
        token0 = (price5_1.mul(1e18)).mul(count);
        token1 = (price5_2.mul(tokenPrice)).mul(count);
    }


    function mintPay1(uint256 count) public whenNotPaused nonReentrant{

        require(msg.sender == tx.origin," External Error ");
        uint256 mintPrice =  getmintPay1Price(count)  ;

        require(BUSD.transferFrom(_msgSender(),address(this),mintPrice),"Approve Token First");
        pool1 = pool1.add((mintPrice.mul(PoolPercentage)).div(100));

        count1++;
        bool pool;

        if(count1 == SwapandLiquifyCount){

        uint256 half = pool1/2;
        BUSD.approve(address(Router), half);
        uint256[] memory returnValues = swapExactTokensForTokens(half, address(LAR));
        returnToken = Percentage(returnValues[1]);
        LAR.approve(address(Router), returnValues[1]);
        BUSD.approve(address(Router), half);
        addLiquiditys(returnValues[1], half);
        
        LAR.approve(address(Router), returnToken);
        swapTokensForToken(returnToken);
        pool = true;
        }
        if(pool) {
            count1 = 0;
            pool1 = 0;
        }
        mint(count);
    }

    function mintPay2(uint256 count) public whenNotPaused nonReentrant{
        require(msg.sender == tx.origin," External Error ");
        (uint256 token0,uint256 token1) =  getmintPay2Price(count);

        require(
        LAR.transferFrom(_msgSender(),address(this),token1)
        && 
        BUSD.transferFrom(_msgSender(),address(this),token0)
        ,"Approve Token First"); 

        pool2 = pool2.add((token0.mul(PoolPercentage)).div(100));

        count2++;
        bool pool;

        if(count2 == SwapandLiquifyCount){

        uint256 half = pool2/2;
        BUSD.approve(address(Router), half);
        uint256[] memory returnValues = swapExactTokensForTokens(half, address(LAR));
        returnToken = Percentage(returnValues[1]);
        LAR.approve(address(Router), returnValues[1]);
        BUSD.approve(address(Router), half);
        addLiquiditys(returnValues[1], half);
        
        LAR.approve(address(Router), returnToken);
        swapTokensForToken(returnToken);
        pool = true;
        }
        if(pool) {
            count2 = 0;
            pool2 = 0;
        }
        mint(count);
    }

    function mintPay3(uint256 count) public whenNotPaused nonReentrant{

        require(msg.sender == tx.origin," External Error ");
        uint256 mintPrice =  getmintPay3Price(count);   

        require(BUSD.transferFrom(_msgSender(),address(this),mintPrice),"Approve Token First");
        pool3 = pool3.add((mintPrice.mul(PoolPercentage)).div(100));

        count3++;
        bool pool;
        if(count3 == SwapandLiquifyCount){

        uint256 half = pool3/2;
        BUSD.approve(address(Router), half);
        uint256[] memory returnValues = swapExactTokensForTokens(half, address(LAR));
        returnToken = Percentage(returnValues[1]);
        LAR.approve(address(Router), returnValues[1]);
        BUSD.approve(address(Router), half);
        addLiquiditys(returnValues[1], half);
        
        LAR.approve(address(Router), returnToken);
        swapTokensForToken(returnToken);
        pool = true;
        }
        if(pool) {
            count3 = 0;
            pool3 = 0;
        }
        mint(count);
    }

    function mintPay4(uint256 count) public whenNotPaused nonReentrant{
        require(msg.sender == tx.origin," External Error "); 
        uint256 mintPrice = getmintPay4Price(count);

        require(BUSD.transferFrom(_msgSender(),address(this),mintPrice),"Approve Token First");
        pool4 = pool4.add((mintPrice.mul(PoolPercentage)).div(100));

        count4++;
        bool pool;

        if(count4 == SwapandLiquifyCount){
        uint256 half = pool4/2;
        BUSD.approve(address(Router), half);
        uint256[] memory returnValues = swapExactTokensForTokens(half, address(LAR));
        returnToken = Percentage(returnValues[1]);
        LAR.approve(address(Router), returnValues[1]);
        BUSD.approve(address(Router), half);
        addLiquiditys(returnValues[1], half);
        
        LAR.approve(address(Router), returnToken);
        swapTokensForToken(returnToken);
        pool = true;
        }
        if(pool) {
            count4 = 0;
            pool4 = 0;
        }
        mint(count);
    }

    function mintPay5(uint256 count) public whenNotPaused nonReentrant{
        require(msg.sender == tx.origin," External Error ");

        (uint256 token0,uint256 token1) =  getmintPay5Price(count);     
        require(
        WIRE.transferFrom(_msgSender(),address(this),token1)
        && 
        BUSD.transferFrom(_msgSender(),address(this),token0)
        ,"Approve Token First");

        pool5 = pool5.add((token0.mul(PoolPercentage)).div(100));

        count5++;
        bool pool;

        if(count5 == SwapandLiquifyCount){

        uint256 half = pool5/2;
        BUSD.approve(address(Router), half);
        uint256[] memory returnValues = swapExactTokensForTokens(half, address(LAR));
        returnToken = Percentage(returnValues[1]);
        LAR.approve(address(Router), returnValues[1]);
        BUSD.approve(address(Router), half);
        addLiquiditys(returnValues[1], half);
        
        LAR.approve(address(Router), returnToken);
        swapTokensForToken(returnToken);
        pool = true;
        }
        if(pool) {
            count5 = 0;
            pool5 = 0;
        }
        mint(count);
    }


    function mint(uint256 count) internal {
        _safeMint(msg.sender,count);
    }

    function Percentage(uint256 _swapToken) internal view returns(uint256)
    {
        uint256 swapToken;
        swapToken = (_swapToken.mul(SWAPTokenPercentage)).div(100);
        return swapToken;
    }

    function swapExactTokensForTokens(uint256 value, address token) private 
    returns (uint[] memory amounts)  
    {
        address[] memory path = new address[](2);
        path[0] = address(BUSD);
        path[1] = token;
        return Router.swapExactTokensForTokens(
        value,
        0, 
        path,
        address(this), 
        block.timestamp
        );
    }

    function addLiquiditys(uint256 _amount,uint256 _half) private 
    {
        Router.addLiquidity(
            address(LAR),
            address(BUSD),
            _amount,
            _half,
            0,
            0,
            LpReceiver,
            block.timestamp
        );
    }

    function swapTokensForToken(uint256 _tokenAmount) private {
        address[] memory path = new address[](2);
        path[0] = address(LAR);
        path[1] = address(BUSD);
        Router.swapExactTokensForTokens(
            _tokenAmount,
            0,
            path,
            BUSDReceiver,
            block.timestamp
        );
    }

    function _toString(uint256 value) internal pure returns (string memory ptr) {
        assembly {
          // The maximum value of a uint256 contains 78 digits (1 byte per digit), 
          // but we allocate 128 bytes to keep the free memory pointer 32-byte word aliged.
          // We will need 1 32-byte word to store the length, 
          // and 3 32-byte words to store a maximum of 78 digits. Total: 32 + 3 * 32 = 128.
          ptr := add(mload(0x40), 128)
          // Update the free memory pointer to allocate.
          mstore(0x40, ptr)

          // Cache the end of the memory to calculate the length later.
          let end := ptr

          // We write the string from the rightmost digit to the leftmost digit.
          // The following is essentially a do-while loop that also handles the zero case.
          // Costs a bit more than early returning for the zero case,
          // but cheaper in terms of deployment and overall runtime costs.
          for { 
              // Initialize and perform the first pass without check.
              let temp := value
              // Move the pointer 1 byte leftwards to point to an empty character slot.
              ptr := sub(ptr, 1)
              // Write the character to the pointer. 48 is the ASCII index of '0'.
              mstore8(ptr, add(48, mod(temp, 10)))
              temp := div(temp, 10)
          } temp { 
              // Keep dividing `temp` until zero.
              temp := div(temp, 10)
          } { // Body of the for loop.
              ptr := sub(ptr, 1)
              mstore8(ptr, add(48, mod(temp, 10)))
          }
          
          let length := sub(end, ptr)
          // Move the pointer 32 bytes leftwards to make room for the length.
          ptr := sub(ptr, 32)
          // Store the length.
          mstore(ptr, length)
        }
    }
     
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    return string(abi.encodePacked(prefixURI,_toString(tokenId),baseExtension));
    }

    function updateCurrentIndex(uint256 _newIndex) public onlyOwner {
      currentIndex = _newIndex;
    }

    function setPrefixURI(string calldata _uri) external onlyOwner {
    prefixURI = _uri;
    }

    function setBaseExtension(string memory _newBaseExtension) 
    public 
    onlyOwner 
    {  baseExtension = _newBaseExtension; }

    function WalletOfOwner(address _owner) public view returns (uint256[] memory) {
        uint256 ownerTokenCount = balanceOf(_owner);
        uint256[] memory tokenIds = new uint256[](ownerTokenCount);
        for (uint256 i; i < ownerTokenCount; i++) {
        tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokenIds;
    }

    function UpdateROUTER(IPancakeRouter01 _Router)
    public
    onlyOwner
    {      Router = _Router;        }


    function withdrawLar()
    public
    onlyOwner
    {   LAR.transfer(owner(), LAR.balanceOf(address(this))/3);   }

    
    function withdrawableBUSD()
    private
    view returns(uint256 amount)
    {
      return amount = BUSD.balanceOf(address(this)).sub(pool1.add(pool2).add(pool3).add(pool4).add(pool5)); 
    }

    function withdrawBusd()
    public
    onlyOwner
    {   BUSD.transfer(owner(), withdrawableBUSD());  }

    function emergencyWithdrawBNB()
    public
    onlyOwner
    {   payable(owner()).transfer(address(this).balance);  }

    function emergencyWithdrawLar()
    public
    onlyOwner
    {   LAR.transfer(owner(), LAR.balanceOf(address(this)));   }

    function emergencyWithdrawWire()
    public
    onlyOwner
    {   WIRE.transfer(owner(), WIRE.balanceOf(address(this)));   }

    function emergencyWithdrawBusd()
    public
    onlyOwner
    {   BUSD.transfer(owner(), BUSD.balanceOf(address(this)));   }

    function UpdateBUSDReceiver(address BUSDReceiver_)
    public
    onlyOwner
    {     BUSDReceiver = BUSDReceiver_;        }

    function UpdateLpReceiver(address LpReceiver_)
    public
    onlyOwner
    {     LpReceiver = LpReceiver_;        }

    function UpdateSwapCount(uint256 swapCount_)
    public
    onlyOwner
    { SwapandLiquifyCount = swapCount_; }

    function UpdateSwapPercentage(uint256 swapPercent_)
    public
    onlyOwner
    { SWAPTokenPercentage = swapPercent_; }

   receive() payable external{}
} 