// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract RoleBasedAccessControl is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

    constructor() {
        // Grant the contract deployer the default admin role: it will be able to grant and revoke any roles
       /* _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(ADMIN_ROLE, msg.sender);
        */
    }

    // Modifier to check for a specific role
    modifier onlyAdmin() {
        require(hasRole(ADMIN_ROLE, msg.sender), "Restricted to admins");
        _;
    }

    function grantUserRole(address account) external onlyAdmin {
        grantRole(USER_ROLE, account);
    }

    function revokeUserRole(address account) external onlyAdmin {
        revokeRole(USER_ROLE, account);
    }

    function restrictedAction() external view {
        require(hasRole(USER_ROLE, msg.sender), "Restricted to users with USER_ROLE");
        // Perform some action accessible only to users
    }
}
