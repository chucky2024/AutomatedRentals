import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const RentalAgreementModule = buildModule("RentalAgreementModule", (m) => {

    const erc20 = m.contract("RentalAgreement");

    return { erc20 };
});

export default RentalAgreementModule;
//contract address = 0xAD2534b27f758405010E2A500002BE7fbcDD72b6