import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MarkretPlaceModule = buildModule("MarkretPlaceModule", (m) => {
  const Marketplace = m.contract("Marketplace");

  return { Marketplace };
});

export default MarkretPlaceModule;