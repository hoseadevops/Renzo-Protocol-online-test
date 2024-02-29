// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.19;

import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "../Permissions/IRoleManager.sol";
import "./RenzoOracleStorage.sol";
import "./IRenzoOracle.sol";
import "../Errors/Errors.sol";

/// @dev This contract will be responsible for looking up values via Chainlink
/// Data retrieved will be verified for liveness via a max age on the oracle lookup.
/// All tokens should be denominated in the same base currency and contain the same decimals on the price lookup.
contract RenzoOracle is
    IRenzoOracle,
    Initializable,
    ReentrancyGuardUpgradeable,
    RenzoOracleStorageV1
{
    //// @dev The mapping of supported token addresses to their respective Chainlink oracle address
    //// 支持的代币地址与它们相应的 Chainlink Oracle 地址之间的映射
    //// mapping(IERC20 => AggregatorV3Interface) public tokenOracleLookup;
    
    /// @dev Error for invalid 0x0 address
    string constant INVALID_0_INPUT = "Invalid 0 input";

    // Scale factor for all values of prices
    uint256 constant SCALE_FACTOR = 10 ** 18;

    /// @dev The maxmimum staleness allowed for a price feed from chainlink
    uint256 constant MAX_TIME_WINDOW = 86400 + 60; // 24 hours + 60 seconds

    /// @dev Allows only a whitelisted address to configure the contract
    modifier onlyOracleAdmin() {
        if(!roleManager.isOracleAdmin(msg.sender)) revert NotOracleAdmin();
        _;
    }

    /// @dev Event emitted when a token's oracle address is updated
    event OracleAddressUpdated(IERC20 token, AggregatorV3Interface oracleAddress);

    /// @dev Prevents implementation contract from being initialized.
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        // _disableInitializers();
    }

    /// @dev Initializes the contract with initial vars
    function initialize(IRoleManager _roleManager) public initializer {
        if(address(_roleManager) == address(0x0)) revert InvalidZeroInput();

        __ReentrancyGuard_init();     
        
        roleManager = _roleManager;   
    }


    /// 设置用于 Oracle 查询的地址 权限受限于 Oracle 管理员
    /// 将地址设置为 0x0 以禁用对该代币的查询

    /// 支持的代币地址与它们相应的 Chainlink Oracle 地址之间的映射
    /// mapping(IERC20 => AggregatorV3Interface) public tokenOracleLookup;

    /// @dev Sets addresses for oracle lookup.  Permission gated to oracel admins only.
    /// Set to address 0x0 to disable lookups for the token.
    function setOracleAddress(IERC20 _token, AggregatorV3Interface _oracleAddress) external nonReentrant onlyOracleAdmin { 
        if(address(_token) == address(0x0)) revert InvalidZeroInput();

        // Verify that the pricing of the oracle is 18 decimals - pricing calculations will be off otherwise
        if(_oracleAddress.decimals() != 18) revert InvalidTokenDecimals(18, _oracleAddress.decimals());

        tokenOracleLookup[_token] = _oracleAddress;
        emit OracleAddressUpdated(_token, _oracleAddress);
    }

    /// @dev 给定单个代币和余额，返回基础货币中资产的价值
    /// 返回的价值将以查找预言机的小数精度计价
    /// （例如，价值为100将返回为100 * 10^18）

    /// @dev Given a single token and balance, return value of the asset in underlying currency
    /// The value returned will be denominated in the decimal precision of the lookup oracle
    /// (e.g. a value of 100 would return as 100 * 10^18)
    function lookupTokenValue(IERC20 _token, uint256 _balance) public view returns (uint256) {           
        AggregatorV3Interface oracle = tokenOracleLookup[_token];
        if(address(oracle) == address(0x0)) revert OracleNotFound();

        // chainlink AggregatorV3Interface latestRoundData
        //
        // roundId: 轮次ID。
        // answer: 此特定数据源提供的数据。根据您选择的数据源，此答案可能提供资产价格、储备情况、NFT底价和其他类型的数据。
        // startedAt: 轮次开始时的时间戳。
        // updatedAt: 轮次更新时的时间戳。
        // answeredInRound: 已弃用 - 以前用于当答案可能需要多轮计算时

        (, int256 price, , uint256 timestamp, ) = oracle.latestRoundData();
        // 验证过期时间
        if(timestamp < block.timestamp - MAX_TIME_WINDOW) revert OraclePriceExpired();
        // 价格有效性验证
        if(price <= 0) revert InvalidOraclePrice();

        // Price is times 10**18 ensure value amount is scaled
        return uint256(price) * _balance / SCALE_FACTOR;
    }

    /// @dev 给定单个代币和价值，返回表示该价值所需的代币数量
    /// 假设代币价值已经以与预言机相同的小数精度计价

    /// @dev Given a single token and value, return amount of tokens needed to represent that value
    /// Assumes the token value is already denominated in the same decimal precision as the oracle
    function lookupTokenAmountFromValue(IERC20 _token, uint256 _value) external view returns (uint256) {           
        AggregatorV3Interface oracle = tokenOracleLookup[_token];
        if(address(oracle) == address(0x0)) revert OracleNotFound();

        (, int256 price, , uint256 timestamp, ) = oracle.latestRoundData();
        if(timestamp < block.timestamp - MAX_TIME_WINDOW) revert OraclePriceExpired();
        if(price <= 0) revert InvalidOraclePrice();

        // Price is times 10**18 ensure token amount is scaled
        return _value * SCALE_FACTOR / uint256(price);
    }

    // @dev 给定代币列表和余额，返回总价值（假设所有查找都以相同的基础货币计价）
    /// 返回的值将以查找 Oracle 的小数精度为单位
    /// （例如，一个值为 100 的结果将返回为 100 * 10^18）

    // @dev Given list of tokens and balances, return total value (assumes all lookups are denomintated in same underlying currency)
    /// The value returned will be denominated in the decimal precision of the lookup oracle
    /// (e.g. a value of 100 would return as 100 * 10^18)
    function lookupTokenValues(IERC20[] memory _tokens, uint256[] memory _balances) external view returns (uint256) {
        if(_tokens.length != _balances.length) revert MismatchedArrayLengths();

        uint256 totalValue = 0;
        uint256 tokenLength = _tokens.length;
        for (uint256 i = 0; i < tokenLength;) {
            totalValue += lookupTokenValue(_tokens[i], _balances[i]);
            unchecked{++i;}
        }

        return totalValue;
    }
    
    /// @dev 给定当前协议价值、新增加的价值以及 ezETH 的供应量，确定要铸造的数量
    /// 值应以相同的基础货币及相同的小数精度为单位

    /// @dev Given amount of current protocol value, new value being added, and supply of ezETH, determine amount to mint
    /// Values should be denominated in the same underlying currency with the same decimal precision
    function calculateMintAmount(uint256 _currentValueInProtocol, uint256 _newValueAdded, uint256 _existingEzETHSupply) external pure returns (uint256) {
        // For first mint, just return the new value added.
        // Checking both current value and existing supply to guard against gaming the initial mint
        if (_currentValueInProtocol == 0 || _existingEzETHSupply == 0) {
            return _newValueAdded; // value is priced in base units, so divide by scale factor
        }
        
        // Calculate the percentage of value after the deposit 
        uint256 inflationPercentaage = SCALE_FACTOR * _newValueAdded / (_currentValueInProtocol + _newValueAdded);

        // Calculate the new supply
        uint256 newEzETHSupply = (_existingEzETHSupply * SCALE_FACTOR) / (SCALE_FACTOR - inflationPercentaage);

        // Subtract the old supply from the new supply to get the amount to mint
        uint256 mintAmount = newEzETHSupply - _existingEzETHSupply;

        // Sanity check
        if(mintAmount == 0) revert InvalidTokenAmount();

        return mintAmount;
    }

    // 给定要销毁的 ezETH 数量、ezETH 的供应量以及协议中的总价值，确定要返回给用户的价值数量

    // Given the amount of ezETH to burn, the supply of ezETH, and the total value in the protocol, determine amount of value to return to user    
    function calculateRedeemAmount(uint256 _ezETHBeingBurned, uint256 _existingEzETHSupply, uint256 _currentValueInProtocol) external pure returns (uint256) {
      // This is just returning the percentage of TVL that matches the percentage of ezETH being burned 
      uint256 redeemAmount = (_currentValueInProtocol * _ezETHBeingBurned) / _existingEzETHSupply;

      // Sanity check
      if(redeemAmount == 0) revert InvalidTokenAmount();

      return redeemAmount;
    }
}