// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {EnumerableSet} from '@openzeppelin/contracts/utils/structs/EnumerableSet.sol';
import {SafeCast} from 'src/contracts/dependencies/openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {IERC20} from 'aave-v3-origin/contracts/dependencies/openzeppelin/contracts/IERC20.sol';
import {VersionedInitializable} from 'aave-v3-origin/contracts/misc/aave-upgradeability/VersionedInitializable.sol';
import {IGhoReserve} from 'src/contracts/facilitators/gsm/interfaces/IGhoReserve.sol';

/**
 * @title GhoReserve
 * @author Aave/TokenLogic
 * @notice It allows approved entities to withdraw and return GHO funds, with a defined maximum withdrawal capacity per entity.
 * @dev To be covered by a proxy contract.
 */
contract GhoReserve is Ownable, VersionedInitializable, IGhoReserve {
  using EnumerableSet for EnumerableSet.AddressSet;
  using SafeCast for uint256;

  /// @inheritdoc IGhoReserve
  address public immutable GHO_TOKEN;

  /// Map of entities and their assigned capacity and amount of GHO used
  mapping(address => GhoUsage) private _ghoUsage;

  /// Set of entities with a GHO limit available
  EnumerableSet.AddressSet private _entities;

  /**
   * @dev Constructor
   * @param ghoAddress The address of the GHO token on the remote chain
   */
  constructor(address ghoAddress) Ownable(msg.sender) {
    require(ghoAddress != address(0), 'ZERO_ADDRESS_NOT_VALID');
    GHO_TOKEN = ghoAddress;
  }

  /**
   * @dev Initializer
   * @param newOwner The address of the new owner
   */
  function initialize(address newOwner) external initializer {
    require(newOwner != address(0), 'ZERO_ADDRESS_NOT_VALID');
    _transferOwnership(newOwner);
  }

  /// @inheritdoc IGhoReserve
  function use(uint256 amount) external {
    require(_entities.contains(msg.sender), "NOT_ENTITY");
    
    GhoUsage storage entity = _ghoUsage[msg.sender];
    require(entity.limit >= entity.used + amount, 'LIMIT_EXCEEDED');

    entity.used += amount.toUint128();
    IERC20(GHO_TOKEN).transfer(msg.sender, amount);
    emit GhoUsed(msg.sender, amount);
  }

  /// @inheritdoc IGhoReserve
  function restore(uint256 amount) external {
    require(_entities.contains(msg.sender), "NOT_ENTITY");

    _ghoUsage[msg.sender].used -= amount.toUint128();
    IERC20(GHO_TOKEN).transferFrom(msg.sender, address(this), amount);
    emit GhoRestored(msg.sender, amount);
  }

  /// @inheritdoc IGhoReserve
  function transfer(address to, uint256 amount) external onlyOwner {
    IERC20(GHO_TOKEN).transfer(to, amount);
    emit GhoTransferred(to, amount);
  }

  /// @inheritdoc IGhoReserve
  function addEntity(address entity) external onlyOwner {
    require(_entities.add(entity), 'ENTITY_ALREADY_EXISTS');
    emit EntityAdded(entity);
  }

  /// @inheritdoc IGhoReserve
  function removeEntity(address entity) external onlyOwner {
    GhoUsage memory usage = _ghoUsage[entity];
    require(usage.used == 0, 'ENTITY_GHO_USED_NOT_ZERO');
    require(usage.limit == 0, 'ENTITY_GHO_LIMIT_NOT_ZERO');
    require(_entities.remove(entity), 'ENTITY_NOT_REMOVED');

    delete _ghoUsage[entity];

    emit EntityRemoved(entity);
  }

  /// @inheritdoc IGhoReserve
  function setLimit(address entity, uint256 limit) external onlyOwner {
    require(_entities.contains(entity), 'ENTITY_DOES_NOT_EXIST');
    _ghoUsage[entity].limit = limit.toUint128();

    emit GhoLimitUpdated(entity, limit);
  }

  /// @inheritdoc IGhoReserve
  function getEntities() external view returns (address[] memory) {
    return _entities.values();
  }

  /// @inheritdoc IGhoReserve
  function getUsed(address entity) external view returns (uint256) {
    return _ghoUsage[entity].used;
  }

  /// @inheritdoc IGhoReserve
  function getUsage(address entity) external view returns (uint256, uint256) {
    GhoUsage memory usage = _ghoUsage[entity];
    return (usage.limit, usage.used);
  }

  /// @inheritdoc IGhoReserve
  function getLimit(address entity) external view returns (uint256) {
    return _ghoUsage[entity].limit;
  }

  /// @inheritdoc IGhoReserve
  function isEntity(address entity) external view returns (bool) {
    return _entities.contains(entity);
  }

  /// @inheritdoc IGhoReserve
  function totalEntities() external view returns (uint256) {
    return _entities.length();
  }

  /// @inheritdoc IGhoReserve
  function GHO_REMOTE_RESERVE_REVISION() public pure virtual override returns (uint256) {
    return 1;
  }

  /// @inheritdoc VersionedInitializable
  function getRevision() internal pure virtual override returns (uint256) {
    return GHO_REMOTE_RESERVE_REVISION();
  }
}
