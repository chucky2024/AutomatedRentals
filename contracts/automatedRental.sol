// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract RentalAgreement {
    struct Agreement {
        address landlord;
        address tenant;
        uint256 rent;
        uint256 dueDate;
        bool active;
    }

    mapping(bytes32 => Agreement) public agreements;

    event AgreementCreated(bytes32 indexed agreementId, address indexed landlord, address indexed tenant);
    event RentPaid(bytes32 indexed agreementId, uint256 amount);

    function createAgreement(bytes32 agreementId, address tenant, uint256 rent, uint256 dueDate) public {
        agreements[agreementId] = Agreement(msg.sender, tenant, rent, dueDate, true);
        emit AgreementCreated(agreementId, msg.sender, tenant);
    }

    function payRent(bytes32 agreementId) public payable {
        Agreement storage agreement = agreements[agreementId];
        require(msg.sender == agreement.tenant, "Only tenant can pay");
        require(agreement.active, "Agreement is not active");
        require(msg.value == agreement.rent, "Incorrect rent amount");

        payable(agreement.landlord).transfer(msg.value);
        emit RentPaid(agreementId, msg.value);
    }

    function terminateAgreement(bytes32 agreementId) public {
        Agreement storage agreement = agreements[agreementId];
        require(msg.sender == agreement.landlord, "Only landlord can terminate");
        agreement.active = false;
    }
}
